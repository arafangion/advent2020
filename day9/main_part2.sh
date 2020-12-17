#!/bin/sh

#input=`cat example.data`
input=`cat input.data`

invalid=10884537
#invalid=127

idx=1

count () {
	local idx=0
	for word in $1; do
		idx=`expr $idx + 1`
	done;
	echo $idx
}

sum() {
	local idx=0
	for word in $1; do
		idx=`expr $idx + $word`
	done;
	echo $idx
}

for word in $input; do
	echo -n .
	last="$last $word"
	num=`count "$last"`;
	if [ $num -gt 1 ];
	then
		:
	else
		continue
	fi

	everything=`sum "$last"`
	while [ $everything -gt $invalid ]
	do
		last=`echo $last | cut -d' ' -f 2-`
		everything=`sum "$last"`
	done

	if [ $everything = $invalid ]
	then
		nums=`echo $last | sed 's- -\n-g' | sort -n`
		fst=`echo $nums | sed 's- -\n-g' | head -n 1`
		lst=`echo $nums | sed 's- -\n-g' | tail -n 1`
		echo "Day 9, Part 2: " $nums producing $fst and $lst and resulting in `expr $fst + $lst`
		exit
	fi
done;
