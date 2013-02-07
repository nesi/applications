#!/usr/bin/python

import sys

content = sys.argv[1]


if 'ISBN' in content:
    print 'String "ISBN" found in output, all good...'
    sys.exit(0)
else:
    print 'String "ISBN" not found in output, check failed...' 
    sys.exit(1)