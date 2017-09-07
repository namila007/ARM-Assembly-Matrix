#!/bin/bash


#removing previous result
rm -rf result.txt

##compiling
 arm-linux-gnueabi-gcc -Wall Main.s 

##checking cases if there is diff o/p for result
for (( i = 1; i < 11; i++ )); do
	filename="TestCases/case"$i".txt"
	output="TestCases/result"$i".txt"
	expec="TestCases/output"$i".txt"
	cat $filename | qemu-arm -L /usr/arm-linux-gnueabi a.out >> $output
	echo $filename>>result.txt
	diff $expec $output >>result.txt
	echo "" >>result.txt
	rm $output
done

