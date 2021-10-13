#!/bin/sh
test="${HOME}/test"
list="${HOME}/test/list"
links="${HOME}/test/links"
#1
mkdir $test
#2
cd $test && ls -a -F /etc > $list
#3
ls -d /etc/ | wc -l >> $list
ls -a | grep '^\.' | wc -l >> $list
#4
mkdir $links
#5
cd $links
ln $list list_hlink
#6
ln -s $list list_slink
#7
stat --format=%h list_hlink # 2
stat --format=%h $HOME/test/list # 2
stat --format=%h list_slink # 1
#8
wc -l $list >> list_hlink
#9
cmp list_slink list_hlink && echo YES || echo NO 
# YES
#10
mv $list $test/list1
#11
cmp list_slink list_hlink && echo YES || echo NO
#12
cd $HOME
ln $test/list1 list_link
#13
listConf=$HOME/list_conf
sudo ls -R /etc | grep '\.conf$'> $listConf
#14
listd=$HOME/list_d
find /etc/ -maxdepth 1 -name "*.d" -type d > $listd
#15
listConfD=$HOME/list_conf_d
cat $listConf >> $listConfD && cat $listd >> $listConfD
#16
cd $test
mkdir .sub
#17
cp $listConfD $test/.sub/
#18
cp -b $listConfD $test/.sub/
#19
ls -aR $test
#20
man man > $HOME/man.txt
#21
split -b 1k  $HOME/man.txt "man.txt_"
#22
mkdir $HOME/man.dir
#23
mv $HOME/man.txt_* $HOME/man.dir
#24
cat $HOME/man.dir/man.txt_* > $HOME/man.dir/man.txt
#25
cmp $HOME/man.txt $HOME/man.dir/man.txt && echo YES || echo NO
#26
echo RANDOM-STR > $HOME/tmp.txt && cat $HOME/man.txt >> $HOME/tmp.txt && cat $HOME/tmp.txt > $HOME/man.txt 
&& rm $HOME/tmp.txt && echo nONsTR >> $HOME/man.txt
#27
diff man.txt man.dir/man.txt > diff.txt 2>/dev/null
#28
mv diff.txt man.dir/
#29
patch $HOME/man.dir/man.txt $HOME/man.dir/diff.txt
#30
cmp man.txt man.dir/man.txt && echo YES || echo NO