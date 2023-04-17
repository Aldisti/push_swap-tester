#!/bin/sh

# DESCRIPTION
# this function changes the color of the number of moves
ft_set_color()
{
	# set variables
	local stack_size=$1
	local moves=$2

	if [ $stack_size -eq 100 ] && [ $moves -lt 701 ] || [ $stack_size -eq 500 ] && [ $moves -lt 5501 ]
	then
		MC=$GREEN
	elif [ $stack_size -eq 100 ] && [ $moves -lt 901 ] || [ $stack_size -eq 500 ] && [ $moves -lt 7001 ]
	then
		MC=$CYAN
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1101 ] || [ $stack_size -eq 500 ] && [ $moves -lt 8501 ]
	then
		MC=$YELLOW
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1301 ] || [ $stack_size -eq 500 ] && [ $moves -lt 10001 ]
	then
		MC=$ORANGE
	elif [ $stack_size -eq 100 ] && [ $moves -lt 1501 ] || [ $stack_size -eq 500 ] && [ $moves -lt 11501 ]
	then
		MC=$RED
	elif [ $stack_size -eq 3 ] && [ $moves -lt 3 ] || [ $stack_size -eq 5 ] && [ $moves -lt 13 ]
	then
		MC=$GREEN
	elif [ $stack_size -eq 3 ] || [ $stack_size -eq 5 ]
	then
		MC=$RED
	else
		MC=$WHITE
	fi
}

ft_check_mandatory()
{
	for i in 3 5 100 500
	do
		tests=0
		ok=0
		ko=0
		max=0
		for _ in $(seq 1 15)
		do
			abc=$(shuf -i 0-200000000 -n $i)
			output=$($P $abc | $C $abc)
			tests=$((tests + 1))
			if [ $output = "OK" ]
			then
				ok=$((ok + 1))
				moves=$($P $entries | wc -l)
				if [ $moves -gt $max ]
				then
					max=$moves
				fi
			elif [ $output = "KO" ]
			then
				ko=$((ko + 1))
			fi
		done
		if [ $ok -eq $tests ]
		then
			ft_set_color $i $max
		fi
		echo "$PURPLE Tests: $BLUE$tests$RESET$PURPLE Size: $CYAN$i$RESET$PURPLE	OK: $MC$ok$RESET$PURPLE KO: $RED$ko$RESET"
	done
}

ft_check_bonus()
{
	local tests=0
	local ok=0
	local ko=0

	#	TEST 1
	out1=$($C ciao come stai > out.log 2>&1; cat out.log)
	out2=$($CP ciao come stai > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 1 fail:$RESET '$CP ciao come stai'"
	fi
	tests=$((tests + 1))
	#	TEST 2
	out1=$($C 1 2 3 "4 1 6" > out.log 2>&1; cat out.log)
	out2=$($CP 1 2 3 "4 1 6" > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 2 fail:$RESET '$CP 1 2 3 "4 1 6"'"
	fi
	tests=$((tests + 1))
	#	TEST 3
	out1=$(echo "ra" | $C 3 1 2 > out.log 2>&1; cat out.log)
	out2=$(echo "ra" | $CP 3 1 2 > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 3 fail:$RESET 'echo "ra" | $CP 3 1 2'"
	fi
	tests=$((tests + 1))
	#	TEST 4
	out1=$(echo "sa" | $C 3 1 2 > out.log 2>&1; cat out.log)
	out2=$(echo "sa" | $CP 3 1 2 > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 4 fail:$RESET '"sa" | $CP 3 1 2'"
	fi
	tests=$((tests + 1))
	#	TEST 5
	out1=$($C > out.log 2>&1; cat out.log)
	out2=$($CP > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 5 fail:$RESET '$CP'"
	fi
	tests=$((tests + 1))
	#	TEST 6
	out1=$(echo -n "" | $C 1 2 3 > out.log 2>&1; cat out.log)
	out2=$(echo -n "" | $CP 1 2 3 > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 6 fail:$RESET 'echo -n \"\" | $CP 1 2 3'"
	fi
	tests=$((tests + 1))
	#	TEST 7
	out1=$(echo -n "" | $C 3 1 2 > out.log 2>&1; cat out.log)
	out2=$(echo -n "" | $CP 3 1 2 > out.log 2>&1; cat out.log | head -c 5)
	if [ $out1 = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 7 fail:$RESET 'echo -n \"\" | $CP 3 1 2'"
	fi
	tests=$((tests + 1))
	#	TEST 8
	out1=$(echo -n "" | $C "" 1 > out.log 2>&1; cat out.log)
	out2=$(echo -n "" | $CP "" 1 > out.log 2>&1; cat out.log | head -c 5)
	if [ "$out1" = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 8 fail:$RESET 'echo -n \"\" | $CP \"\" 1'"
	fi
	tests=$((tests + 1))
	#	TEST 9
	out1=$($P 3 1 2 | $C 3 1 2 > out.log 2>&1; cat out.log)
	out2=$($P 3 1 2 | $CP 3 1 2 > out.log 2>&1; cat out.log | head -c 5)
	if [ "$out1" = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 9 fail:$RESET '$P 3 1 2 | $CP 3 1 2'"
	fi
	tests=$((tests + 1))
	#	TEST 10
	out1=$($P 3 1 2 4 6 5 7 9 8 | $C 3 1 2 4 6 5 7 9 8 > out.log 2>&1; cat out.log)
	out2=$($P 3 1 2 4 6 5 7 9 8 | $CP 3 1 2 4 6 5 7 9 8 > out.log 2>&1; cat out.log | head -c 5)
	if [ "$out1" = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 10 fail:$RESET '$P 3 1 2 4 6 5 7 9 8 | $CP 3 1 2 4 6 5 7 9 8'"
	fi
	tests=$((tests + 1))
	#	TEST 11
	out1=$($P 3 1 2 4 6 5 7 8 9 | $C 3 1 2 4 6 5 7 9 8 > out.log 2>&1; cat out.log)
	out2=$($P 3 1 2 4 6 5 7 8 9 | $CP 3 1 2 4 6 5 7 9 8 > out.log 2>&1; cat out.log | head -c 5)
	if [ "$out1" = $out2 ]
	then
		ok=$((ok + 1))
		rm out.log
	else
		ko=$((ko + 1))
		echo "$RED TEST 11 fail:$RESET '$P 3 1 2 4 6 5 7 8 9 | $CP 3 1 2 4 6 5 7 9 8'"
	fi
	tests=$((tests + 1))
	echo "$PURPLE Tests: $BLUE$tests$PURPLE ok: $GREEN$ok$PURPLE ko: $RED$ko$RESET"
}

ft_check_custom()
{
	local stack_size=$1
	local test=$2

	tests=0
	ok=0
	ko=0
	max=0
	rm data.log 2>/dev/null
	for _ in $(seq 1 $test)
	do
		abc=$(shuf -i 0-200000000 -n $stack_size)
		echo "$abc\n" >> data.log
		output=$($P $abc | $C $abc)
		tests=$((tests + 1))
		if [ $output = "OK" ]
		then
			ok=$((ok + 1))
			move=$($P $abc | wc -l)
			if [ $move -gt $max ]
			then
				max=$move
			fi
		elif [ $output = "KO" ]
		then
			ko=$((ko + 1))
		fi
	done
	if [ $ok -eq $tests ]
	then
		ft_set_color $stack_size $max
	fi
	echo "$PURPLE Tests: $BLUE$tests$RESET$PURPLE Size: $CYAN$stack_size$RESET$PURPLE	OK: $MC$ok$RESET$PURPLE KO: $RED$ko$PURPLE Max: $WHITE$max$RESET"
}

ft_check_executables()
{
	# check executables existence
	if ! [ -e $P ]
	then
		echo "'$P' executable not found"
		echo "Try with 'make -C ..'"
		exit 1
	elif ! [ -e $C ]
	then
		echo "'$C' executable not found"
		echo "Try cloning the repository again"
		exit 1
	elif [ $1 -eq 2 ] && ! [ -e $CP ]
	then
		echo "'$CP' executable not found"
		echo "Try with 'make bonus -C ..'"
		exit 1
	fi
	# check executables permissions
	if ! [ $(stat -c %A $P | tr -cd x | wc -c) -eq 3 ]
	then
		echo "'$P' executable must have execution permissions"
		echo "Try with 'chmod +x $P'"
		exit 1
	elif ! [ $(stat -c %A $C | tr -cd x | wc -c) -eq 3 ]
	then
		echo "'$C' executable must have execution permissions"
		echo "Try with 'chmod +x $C'"
		exit 1
	elif [ $1 -eq 2 ] && ! [ $(stat -c %A $CP | tr -cd x | wc -c) -eq 3 ]
	then
		echo "'$CP' executable must have execution permissions"
		echo "Try with 'chmod +x $CP'"
		exit 1
	fi
}

# blue       cyan       yellow      orange      red
# 38;5;21    38;5;81    38;5;226    38;5;202    38;5;124

# set colors
BLUE="\033[38;5;21m"
CYAN="\033[38;5;81m"
GREEN="\033[38;5;40m"
ORANGE="\033[38;5;202m"
PURPLE="\033[38;5;105m"
RED="\033[38;5;124m"
WHITE="\033[38;5;231m"
YELLOW="\033[38;5;226m"
RESET="\033[0m"

P="./../push_swap"
MC="\033[37m"

# set checker name
if [ $(uname) = "Linux" ]
then
	C="./checker_linux"
else
	C="./checker_Mac"
fi

CP="./../checker"

# check flags
case $1 in
	-h|--help)
		echo "DESCRIPTION"
		echo "  -m		check the mandatory part"
		echo "  -b		check the bonus part"
		echo "  -a		check both, mandatory and bonus"
		echo "  -p		allow you to do custom tests"
		echo "  -h, --help	display this help and exit"
		exit 0
	;;
	-m)
		shift
		if ! [ $# -eq 0 ]
		then
			echo "'-m' option doesn't expect any arguments"
			exit 1
		fi
		ft_check_executables 1
		# do mandatory
		ft_check_mandatory
	;;
	-b)
		shift
		if ! [ $# -eq 0 ]
		then
			echo "'-b' option doesn't expect any arguments"
			exit 1
		fi
		ft_check_executables 2
		# do bonus
		ft_check_bonus
	;;
	-a)
		shift
		if ! [ $# -eq 0 ]
		then
			echo "'-a' option doesn't expect any arguments"
			exit 1
		fi
		# do both
		ft_check_executables 2
		ft_check_mandatory
		ft_check_bonus
	;;
	-p)
		shift
		if ! [ $# -eq 2 ]
		then
			echo "'-p' option expects only 2 arguments"
			exit 1
		fi
		if [ "$1" = "" ] || [ "$2" = "" ]
		then
			echo "You have to insert 2 numbers as argument"
			echo "Command sould be of this type:"
			echo "./script.sh -p [stack_size] [number_of_tests]"
			exit 1
		fi
		[ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null
		if ! [ $? -eq 0 ]
		then
			echo "Input arguments must be integers"
			exit 1
		fi
		[ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null
		if ! [ $? -eq 0 ]
		then
			echo "Input arguments must be integers"
			exit 1
		fi
		# do custom
		ft_check_custom $1 $2
	;;
	-*)
		echo "'$1': invalid option"
		echo "Try with './script.sh --help' for more information"
		exit 1
	;;
	"")
		echo "Try with './script.sh --help' for more information"
		exit 1
	;;
	*)
		echo "'$1': bad argument"
		echo "Try with './script.sh --help' for more information"
		exit 1
	;;
esac
