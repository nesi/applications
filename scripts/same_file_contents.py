#!/usr/bin/python

import sys
import difflib


filename_1 = sys.argv[1]
filename_2 = sys.argv[2]

f1 = open(filename_1, 'r')
f2 = open(filename_2, 'r')


f1content = f1.read()
f2content = f2.read()

print type(f1content)

if f1content == f2content:
    print "'File contents (%s, %s) are equal'" % (filename_1, filename_2)
    f1.close()
    f2.close()
    sys.exit(0)
else:
    print "'File contents (%s, %s) are not equal'" % (filename_1, filename_2)
    result = difflib.unified_diff(f1content.split('\n'), f2content.split('\n'), lineterm='')
    print '\n'.join(list(result))
    f1.close()
    f2.close()
    sys.exit(1)
