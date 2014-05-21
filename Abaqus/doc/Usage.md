##### Interactive with CAE

You can run CAE in interactive mode on one of our build nodes. This is only for design purposes.

NOTE: If you want to test your model you must submit it as a job.

##### Instructions

Connect to the login node with X forwarding enabled.

    ssh -Y you@login.uoa.nesi.org.nz

Then connect to one of the build nodes:

    ssh -Y build-gpu-p

Load the Abaqus module

    module load Abaqus

Start Abaqus CAE

    abaqus cae

NOTE: This doesn't seem to work with Mac OS X
