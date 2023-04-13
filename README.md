# push_swap_tester

### Usage

First, go to the root of your repository (which is where you can find your
Makefile) and do:

```git clone https://github.com/Aldisti/push_swap_tester.git```

after this you have to compile your push_swap and if you have done the bonus
part then you have to compile it too. Next just go inside the tester folder
with this command:

```cd push_swap_tester```

now you can run the tester. If you don't now how to use it just run:

```python3 tester.py```

You can run this tester in 4 different ways.
1) to check if your push_swap works correctly do:
```python3 tester.py m```
2) to check if your checker works correctly do:
```python3 tester.py b```
3) to check both just do:
```python3 tester.py a```
4) to do a custom number of tests with a custom stack size do:
```python3 tester.py [how_many_tests] [stack_size]```

#### Pro tip

If you want to launch the tester with a particular checker executable you can
add the path of the executable as second or third flag when running the tester:

```python3 tester.py m [path_to_the_checker_you_want_to_use]```

## Bug report

If you find some bugs or errors of any type, please, report them to me. You can
contact me on slack: adi-stef