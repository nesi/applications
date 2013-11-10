CC=gcc
CFLAGS=-I/opt/ibmll/LoadL/scheduler/full/include/ -I/opt/ibmll/LoadL/resmgr/full/include -g -m64
LFLAGS=-L/usr/lib64 -L/opt/ibmll/LoadL/scheduler/full/lib64 -L/opt/ibmll/LoadL/resmgr/full/lib64
LIBS=-lllapi -lllrapi


all: llwait

llwait: llwait.c
	$(CC) $(CFLAGS) $(LFLAGS) $(LIBS) llwait.c -o $@

clean:
	rm -f *~ *.o llwait

