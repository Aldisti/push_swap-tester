# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.py                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adi-stef <adi-stef@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/10 15:55:16 by adi-stef          #+#    #+#              #
#    Updated: 2023/04/13 18:15:58 by adi-stef         ###   ########.fr        #
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
P = "./../push_swap"
C = "./../checker_linux"
CB = "./../checker"

g = "\033[32m"
r = "\033[31m"
b = "\033[34m"
p = "\033[35m"
e = "\033[0m"

def ft_check(ntests, nargv, tosave, checker=C):
    comb = []
    moves = [1, 2, 3]
    ok = 0
    ko = 0
    tests = 0
    start = perf_counter()
    while (True):
        if (len(comb) >= ntests or (nargv < 15 and len(comb) == factorial(nargv))): break
        abc = ' '.join([str(i) for i in sample(range(MIN, MAX), nargv)])
        if (abc in comb): continue
        comb.append(abc)
        out = getoutput(f'{P} {abc} | {checker} {abc}')
        tests += 1
        if (out == "OK"):
            moves.append(int(getoutput(f'{P} {abc} | wc -l | grep -o "[0-9]\+"')))
            ok += 1
        elif (out == "KO"): ko += 1
        else: print(f"Got this output: [{out}] with this input: [{abc}]"); break
    time = round(perf_counter() - start, 2)
    if (tosave == 1):
        with open('test.out', 'w') as f:
            f.write(f"tests: {tests}\nok: {ok}\nko: {ko}\nnumbers: {nargv}\nmax: {max(moves)}\nmin: {min(moves)}\navg: {sum(moves) // len(moves)}\ntime: {time}\n")
    elif (tosave == -1):
        return ([tests, ok, ko, time, nargv, moves])
    print(f"tests: {b}{tests}{e} - ok: {g}{ok}{e} - ko: {r}{ko}{e} - numbers: {nargv} - max: {max(moves)} - min: {min(moves)} - avg: {sum(moves) // len(moves)} - time: {time}")

def ft_check_m():
    ft_check(6, 3, 0)
    ft_check(120, 5, 0)
    ft_check(50, 100, 0)
    ft_check(10, 500, 0)



def ft_check_b():
    if (getoutput(f"{P} | {C}") != getoutput(f"{P} | {CB}")):
        print(f"{r}[{CB[2:]}] does not work without numbers{e}"); exit(0)
    if (getoutput(f"{P} {range(-5, 15)} | {C} {range(-5, 15)}") != getoutput(f"{P} {range(-5, 15)} | {CB} {range(-5, 15)}")):
        print(f"{r}[{CB[2:]}] does not work with ordered numbers{e}"); exit(0)
    if (getoutput(f"{P} {range(-5, 15)} | {C} {range(15, -5, -1)}") == getoutput(f"{P} {range(-5, 15)} | {CB} {range(15, -5, -1)}")):
        print(f"{r}[{CB[2:]}] does not check if the stack is ordered{e}"); exit(0)
    out1 = ft_check(6, 3, -1)
    out2 = ft_check(6, 3, -1, CB)
    if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB[2:]}] does not work with 3 numbers{e}"); exit(0)
    out1 = ft_check(120, 5, -1)
    out2 = ft_check(120, 5, -1, CB)
    if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB[2:]}] does not work with 5 numbers{e}"); exit(0)
    out1 = ft_check(50, 100, -1)
    out2 = ft_check(50, 100, -1, CB)
    if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB[2:]}] does not work with 100 numbers{e}"); exit(0)
    ft_check(10, 500, -1)
    ft_check(10, 500, -1, CB)
    if (out1[1] != out2[1] or out1[2] != out2[2]): print(f"{r}[{CB[2:]}] does not work with 500 numbers{e}"); exit(0)
    print(f"{g}[{CB[2:]}] does work correctly{e}")



tests = 0
error = 0
ok = 0
lko = []
comb = []

if (__name__ == '__main__'):
    if (not access(P, X_OK)): print(f"{b}Error{e}\n{r}[{P[2:]}] executable must be present in this dir and must have permissions{e}"); exit(1)
    if (not access(C, X_OK)): print(f"{b}Error{e}\n{r}[{C[2:]}] executable must be present in this dir and must have permissions{e}"); exit(1)
    if (len(argv) == 1):
        print(f"""by {p}Aldisti{e} with love and something else...\nThis is a simple python tester for {b}push_swap{e} a project of the 42Cursus
You can run this script in 2 different ways:
{b}python3 tester.py{e} {g}m{e} -> this will test your algo with 3, 5, 100 and 500 numbers
{b}python3 tester.py{e} {g}b{e} -> this will do some tests with your checker
{b}python3 tester.py{e} {g}a{e} -> this will do both m and b
{b}python3 tester.py{e} {g}[number_of_tests] [length_of_stack]{e}"""); exit(0)
    elif (len(argv) == 2):
        if (argv[1] == 'm'):
            ft_check_m()
        elif (argv[1] == 'b'):
            if (not access(CB, X_OK)): print(f"{b}Error\n{e}{r}[{CB[2:]}] executable must be present in this dir and must have permissions{e}"); exit(1)
            ft_check_b()
        elif (argv[1] == 'a'):
            ft_check_m()
            ft_check_b()
        else:
            print(f"{b}Error{e}\n{r}Accepted parameters:{e}\n{g}m{e}: mandatory tests\n{g}b{e}: bonus tests\n{g}a{e}: tests both\n")
    elif (len(argv) == 3):
        try:
            av = [int(argv[1]), int(argv[2])]
        except ValueError:
            print(f"{b}Error{e}\n{r}Command should be:{e} {g}python3 tester.py [number_of_tests] [length_of_stack]{e}"); exit(1)
        ft_check(av[0], av[1], 0)
