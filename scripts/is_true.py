#!/usr/bin/python

import sys

string = sys.argv[1]

if string.lower() == "true":
    print "'String "+string+" equals 'true'"
    sys.exit(0)
else:
    print "'String "+string+" does not equal 'true'"
    sys.exit(1)