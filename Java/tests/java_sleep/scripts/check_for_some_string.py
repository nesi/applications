#!/usr/bin/python

import sys

matcher = sys.argv[1]
content = sys.argv[2]


if matcher in content:
    print 'String '+matcher+' found in output, all good...'
    sys.exit(0)
else:
    print 'String '+matcher+' not found in output, check failed...' 
    sys.exit(1)