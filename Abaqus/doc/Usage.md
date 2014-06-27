##### Interactive with CAE

To check the licences, run

	/share/easybuild/RHEL6.3/westmere/software/ABAQUS/6.13.2-linux-x86_64/6.13-2/code/bin/lmstat -a -c @abaqus.licenses.foe.auckland.ac.nz

You can run CAE in interactive mode on one of our build nodes. We suggest you only use this option to design large problems. The transfer of the Graphical User Interface is quite demanding for the connection. 

NOTE: If you want to test your model you must submit it as a job.

##### Instructions

Connect to the login node with X forwarding enabled.

    ssh -YC you@login.uoa.nesi.org.nz

Then connect to one of the build nodes:

    ssh -YC build-wm

Load the Abaqus module

    module load Abaqus

Start Abaqus CAE

    abaqus cae

NOTE: This doesn't seem to work with Mac OS X

