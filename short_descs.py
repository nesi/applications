#!/bin/env python
import os

for line in open('whatis2.txt'):
	line = line.strip()
	if not line: continue
	(app, desc) = line.split(None, 1)
	if not os.path.exists(app):
		os.mkdir(app)
	doc = os.path.join(app, 'doc')
	if not os.path.exists(doc):
		os.mkdir(doc)
	props = os.path.join(doc, 'app.properties')
	if not os.path.exists(props):
		f = open(props, 'w')
		f.write('short_description = {0}\n'.format(desc))
	else:
		print "EXISTANT", props