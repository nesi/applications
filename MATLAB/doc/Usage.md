$H$H$H$H Licensing

University of Auckland, Faculty of Science: all versions with FoS 

University of Auckland, Faculty of Engineering: all versions with FoE

If you get an error message indicating that no licenses are available for a certain feature, you can use the following command to check the licensing situation. The output will show you the licensing situation for individual features.

As member of the Faculty of Science:

	/share/apps/MATLAB/prod/UoA-FoS/R2012a/etc/glnxa64/lmutil lmstat -c /share/apps/MATLAB/prod/UoA-FoS/R2012a/licenses/network.lic -a

As member of the Faculty of Engineering:

	/share/apps/MATLAB/prod/UoA-FoE/R2012b/etc/glnxa64/lmutil lmstat -c /share/apps/MATLAB/prod/UoA-FoE/R2012b/licenses/network.lic -a

$H$H$H$H Single and Multi-core usage

Matlab runs by default in multi-core mode. However, it does not allow to control to amount of CPUs used. This makes that your job may interfere with other users jobs. Therefore, you have have two options:

+ run Matlab with the '-singleCompThread' flag.
+ reserve a whole node, by adding '#@ node_usage=not_shared' to the submission script. 
