#!/bin/bash

AC=$#
P="../push_swap"
MC="\033[37m"

# set checker name
if [ $(uname) = "Linux" ]
then
	C="./checker_linux"
else
	C="./checker_Mac"
fi

# check correct input arguments with case statement
case $AC in
	0)
		echo "You have to insert at least one argument"
		exit 0
	;;
	2)
		STACK=$1
		TESTS=$2
	;;
	3)
		STACK_START=$1
		STACK_END=$2
		TESTS=$3
	;;
	*)
		echo "You have to insert only 2 arguments"
		exit 0
	;;
esac


# DESCRIPTION
# this function changes the color of the number of moves
ft_set_color()
{
	# set variables
	local stack_size=$1
	local moves=$2

	if [ $stack_size -eq 100 ] && [ $moves -lt 701 ] || [ $stack_size -eq 500 ] && [ $moves -lt 5501 ]
	then
		MC="\033[38;5;21m"
	elif [ $stack_size -eq 100 ] && [ $moves -lt 901 ] || [ $stack_size -eq 500 ] && [ $moves -lt 7001 ]
	then
		MC="\033[38;5;81m"
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1101 ] || [ $stack_size -eq 500 ] && [ $moves -lt 8501 ]
	then
		MC="\033[38;5;226m"
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1301 ] || [ $stack_size -eq 500 ] && [ $moves -lt 10001 ]
	then
		MC="\033[38;5;202m"
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1501 ] || [ $stack_size -eq 500 ] && [ $moves -lt 11501 ]
	then
		MC="\033[38;5;124m"
	elif [ $stack_size -eq 3 ] && [ $moves -lt 3 ] || [ $stack_size -eq 5 ] && [ $moves -lt 13 ]
	then
		MC="\033[38;5;21m"
	elif [ $stack_size -eq 3 ] || [ $stack_size -eq 5 ]
	then
		MC="\033[38;5;124m"
	else
		MC="\033[38;5;231m"
	fi
}

ft_check()
{
	# set local variables
	local size=$1
	local moves=""

	entries=$(shuf -i 0-200000000 -n $size)
	output=$($P $entries | $C $entries)
	if [ $output = "OK" ]
	then
		output="\033[32mOK"
		moves=$($P $entries | wc -l)
		ft_set_color $size  $moves 
	elif [ $output = "KO" ]
	then
		output="\033[31mKO"
	else
		output="\033[38;5;226mError"
	fi
	echo "\033[38;5;147m$size $output $MC$moves\033[0m"
}

# blue       cyan       yellow      orange      red
# 38;5;21    38;5;81    38;5;226    38;5;202    31

if [ $AC -eq 2 ]
then
	for test in $(seq 1 $TESTS)
	do
		ft_check $STACK
	done
else
	for stack_size in $(seq $STACK_START $STACK_END)
	do
		for test in $(seq 1 $TESTS)
		do
			ft_check $stack_size
		done
	done
fi
