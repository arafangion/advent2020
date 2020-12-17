#!/bin/sh

pre_length=`expr 25 + 1`
#input=`cat example.data`
input=`cat input.data`

combinations_1() {
	local combinations=""
	for item in $@; do
		if [ $item != $1 ]
		then
			combinations="$combinations `expr $item + $1`"
		fi
	done;
	echo $combinations
}

combinations() {
	for item in $@; do
		echo `combinations_1 $item $@`
	done;
}

matched() {
	local word="$1"
	local pot="$2"
	for item in $pot; do
		if [ $item = $word ]
		then
			echo "MATCH"
			return 0;
		fi
	done;
	echo "INVALID";
	return 1;
}

idx=1

for word in $input; do
	echo -n .
	last=`echo "$word $last" | cut -d' ' -f 1-$pre_length`
 	idx=`expr $idx + 1`
	potential=`combinations $last`
	if matched $word "$potential" > /dev/null
	then
		:
	else
		if [ $idx -gt $pre_length ]
		then
			echo
			echo Day 9 Part 1 "->" $word
			exit
		fi
	fi 
done;
