from random import sample
from sys import argv

print(" ".join([str(i) for i in sample(range(0, 20000000), int(argv[1]))]))