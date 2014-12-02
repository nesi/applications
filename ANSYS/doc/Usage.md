$H$H$H$H Connecting to the build node

You can use the graphical interfaces of Ansys on the build nodes. Be aware that there are limitations for processes running on the build nodes, e.g., run time is limited. 

First connect to the login node with X forwarding enabled:

    ssh -YC <login>@login.uoa.nesi.org.nz

Then connect to one of the build nodes:

    ssh -YC build-wm

Load the Abaqus module:

    module load ANSYS

Run e.g.
	
	fluent

or	

	cfx5post

and the GUI will appear. If you are connecting from a Windows machine, you may need to use:

	cfx5post -gr mesa 

$H$H$H$H Running compute jobs

See the example jobs below. You can submit them to the compute nodes by running
	
	sbatch job.sl
