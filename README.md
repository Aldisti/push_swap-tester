# push_swap_tester

### Installation

First, go to the root of your repository (which is where you can find your
Makefile) and do:

```bash
git clone https://github.com/Aldisti/push_swap_tester.git
```

after this you have to compile your push_swap and if you have done the bonus
part then you have to compile it too. If your Makefile is correct you can do:

```bash
make all
```

next just go inside the tester folder with this command:

```bash
cd push_swap_tester
```

now you can test your push_swap with a bash script, it's easy to use so don't
be scared by this long README. Enjoy the tester!

## Usage

The bash script is an executable file, so you can run it just by typing
```./tester```. But to use it you have to add an option, at the moment there
are 4 different options. You can see them doing:

```bash
./tester --help
```

the output you'd get should be like this:
```
 ./tester m	checks for the mandatory part
 ./tester b	checks for the bonus part
 ./tester a	checks for both, mandatory and bonus
 ./tester c	allows you to do custom tests
 ./tester r	allows you to do custom tests in a range of numbers
  -h, --help	display this help and exit
```

now if you want to test the mandatory part of the project just run:
```bash
./tester m
```

it's the same with the options 'b' and 'a', but if you want to do a custom test
you can use the option 'p' with 2 arguments: the stack size and the number of
tests to perform.

e.g. if you want to perform 15 tests with a stack size of 500 integers you can do:

```bash
./tester p 500 15
```

#### Output

After running the test you'll get an output like this:
```Tests: 15 Size: 500	OK: 15 KO: 0```
If all tests are ok then the number after 'OK:' will be colored accordingly
to the maximum number of moves made (the grade will be based on the evaluation
sheet).

Colors table:

```
🟩 is for grade 5/5
🟦 is for grade 4/5
🟨 is for grade 3/5
🟧 is for grade 2/5
🟥 is for grade 1/5
```

## Bug report

If you find some bugs or errors of any type, please, report them to me. You can
contact me on slack: @adi-stef