# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.py                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adi-stef <adi-stef@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/10 15:55:16 by adi-stef          #+#    #+#              #
#    Updated: 2023/04/14 23:43:13 by adi-stef         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

from subprocess import getoutput
from time import perf_counter
from os import access, X_OK
from random import sample
from sys import argv
from math import factorial

MAX = 2147483647
MIN = -2147483648
P = "../push_swap"
C = "./checker_linux"
CB = "../checker"

g = "\033[32m"
gb = "\033[1;32m"
r = "\033[31m"
rb = "\033[1;31m"
b = "\033[34m"
bb = "\033[1;34m"
p = "\033[35m"
pb = "\033[1;35m"
e = "\033[0m"

def ft_getvote(stack_size, max_moves, tests, ok):
    if (tests != ok):
        grade = r + "failed" + e
    elif (stack_size == 3):
        if (max_moves > 3):
            grade = r + "failed" + e
        else: grade = g + "succeed" + e
    elif (stack_size == 5):
        if (max_moves > 12):
            grade = r + "failed" + e
        else: grade = g + "succeed" + e
    elif (stack_size == 100):
        if (max_moves <= 700):
            grade = g + "succeed with 5" + e
        elif (max_moves <= 900):
            grade = g + "succeed with 4" + e
        elif (max_moves <= 1100):
            grade = g + "succeed with 3" + e
        elif (max_moves <= 1300):
            grade = r + "failed with 2" + e
        elif (max_moves <= 1500):
            grade = r + "failed with 1" + e
        else: grade = r + "failed with 0" + e
    elif (stack_size == 500):
        if (max_moves <= 5500):
            grade = g + "succeed with 5" + e
        elif (max_moves <= 7000):
            grade = g + "succeed with 4" + e
        elif (max_moves <= 8500):
            grade = g + "succeed with 3" + e
        elif (max_moves <= 10000):
            grade = r + "failed with 2" + e
        elif (max_moves <= 11500):
            grade = r + "failed with 1" + e
        else: grade = r + "failed with 0" + e
    else: grade = grade = g + "succeed" + e

    return (grade)

def ft_tester(num_test, stack_size, view=0, checker=C):
    moves = []
    tests = 0
    
    with open("data.trace", "w") as f:
        while (True):
            if (tests == num_test): break
            abc = ' '.join([str(i) for i in sample(range(MIN, MAX), stack_size)])
            if (abc == sorted(abc)): continue
            tests += 1
            out = getoutput(f'{P} {abc} | {checker} {abc}')
            if (out == 'OK'):
                moves.append(int(getoutput(f'{P} {abc} | wc -l')))
            f.write(f"{abc}\n")

    grade = ft_getvote(stack_size, max(moves), tests, len(moves))
    if (view == 0):
        print(f"Tests:    {p}{tests}{e}\n"
            f"Size:     {b}{stack_size}{e}\n"
            f"OK:       {g}{len(moves)}{e}\n"
            f"KO:       {r}{tests - len(moves)}{e}\n"
            f"Max:      {rb}{max(moves)}{e}\n"
            f"Min:      {gb}{min(moves)}{e}\n"
            f"Avg:      {pb}{sum(moves) / len(moves)}{e}\n"
            f"Defense:  {grade}\n")
    elif (view == 1):
        print(f"Tests:    {p}{tests}{e}\n"
            f"Size:     {b}{stack_size}{e}\n"
            f"Defense:  {grade}\n")



def ft_check_m(view=0):
    ft_tester(200, 3, view)
    ft_tester(150, 5, view)
    ft_tester(100, 100, view)
    ft_tester(10, 500, view)



def ft_check_b():
    if (getoutput(f"{P} | {C}") != getoutput(f"{P} | {CB}")):
        print(f"{r}[{CB}] does not work without numbers{e}")
        exit(0)
    if (getoutput(f"{P} {range(-5, 15)} | {C} {range(-5, 15)}") != getoutput(f"{P} {range(-5, 15)} | {CB} {range(-5, 15)}")):
        print(f"{r}[{CB}] does not work with ordered numbers{e}")
        exit(0)
    if (getoutput(f"{P} {range(-5, 15)} | {C} {range(15, -5, -1)}") == getoutput(f"{P} {range(-5, 15)} | {CB} {range(15, -5, -1)}")):
        print(f"{r}[{CB}] does not check if the stack is ordered{e}")
        exit(0)
    # out1 = ft_check(6, 3, -1)
    # out2 = ft_check(6, 3, -1, CB)
    # if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB}] does not work with 3 numbers{e}"); exit(0)
    # out1 = ft_check(120, 5, -1)
    # out2 = ft_check(120, 5, -1, CB)
    # if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB}] does not work with 5 numbers{e}"); exit(0)
    # out1 = ft_check(50, 100, -1)
    # out2 = ft_check(50, 100, -1, CB)
    # if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB}] does not work with 100 numbers{e}"); exit(0)
    # ft_check(10, 500, -1)
    # ft_check(10, 500, -1, CB)
    # if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB}] does not work with 500 numbers{e}"); exit(0)
    # print(f"{g}[{CB}] does work correctly{e}")



if (__name__ == '__main__'):
    if (len(argv) == 1):
        print(f"by {p}Aldisti{e} with love and something else...\nThis is a"
              f"simple python tester for {b}push_swap{e} a project of the"
              f"42Cursus\nYou can run this script in 2 different ways:\n"
              f"{b}python3 tester.py{e} {g}m{e} -> this will test your algo"
              f"with 3, 5, 100 and 500 numbers\n{b}python3 tester.py{e} {g}b"
              f"{e} -> this will do some tests with your checker\n{b}python3"
              f"tester.py{e} {g}a{e} -> this will do both m and b\n{b}python3"
              f"tester.py{e} {g}[number_of_tests] [stack_size]{e}")
        exit(0)

    if (getoutput("uname") == "Linux"): C = "./checker_linux"
    else: C = "./checker_Mac"

    if (not access(P, X_OK)):
        print(f"{rb}Error{e}\n{r}Path '{P}' not found or doesn't have permissions{e}")
        exit(1)
    if (not access(C, X_OK)):
        print(f"{rb}Error{e}\n{r}Path '{C}' not found or doesn't have permissions{e}")
        exit(1)

    if (len(argv) >= 2 and argv[1] in ["m", "b", "a"]):
        if (len(argv) > 2 and argv[2] == "slim"):
            view = 1
        else: view = 0
        if (argv[1] == "m"):
            ft_check_m(view)
        elif (argv[1] == "b"):
            ft_check_b()
        elif (argv[1] == "a"):
            pass
    elif (len(argv) >= 3 and argv[1].isdigit() and argv[2].isdigit()):
        if (len(argv) > 3 and argv[3] == "slim"):
            view = 1
        else: view = 0
        ft_tester(int(argv[1]), int(argv[2]), view)
