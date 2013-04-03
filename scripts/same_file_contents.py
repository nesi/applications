#!/usr/bin/python

import sys

filename_1 = sys.argv[1]
filename_2 = sys.argv[2]

f1 = open(filename_1, 'r')
f2 = open(filename_2, 'r')

if f1.read() == f2.read():
    print "'File contents (%s, %s) are equal'" % (filename_1, filename_2)
    f1.close()
    f2.close()
    sys.exit(0)
else:
    print "'File contents (%s, %s) are not equal'" % (filename_1, filename_2)
    f1.close()
    f2.close()
    sys.exit(1)
