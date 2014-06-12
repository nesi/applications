$H$H$H$H Plots and graphics

Plots usually require interactive operations/windows to be commenced. To avoid this and to capture graphical output redirection can be used. Below is an example of redirecting plots to an external png file:

	png(filename="plot.png")  # This line is added to redirect plots below to plot.png file
	par(mfrow=c(2,1))
	plot(dispersed,type="l",ylab="dispersed")
	plot(nondispersed,type="l",ylab="nondispersed")

$H$H$H$H Installing libraries

If you can see the list of available libraries in by typing library() at the R prompt.
	
	R
	...
	> library()

To install more libraries use install.packages("package_name"). It's best to do this from one of the build nodes, for example, to install the sampling library:

	ssh build-gpu-p
	R
	...
	> install.packages("sampling")

You may be asked to select a directory for installing libraries. The default location is recommended.
If you are installing several packages, you may be asked to choose a download mirror. New Zealand should be listed.

You can confirm the library has been installed by using the library() command:
	
	> library(package_name)

At the R command prompt when you want to quit R type quit(). You will be asked "Save workspace image? [y/n/c]".  Type n. 
If you have any issues or questions about installing R libraries, please contact us.

$H$H$H$H Compiling Libraries

You can compile custom C libraries for use with R using the R shared library compiler. It is best to do this from one of the build nodes:

	ssh build-gpu-p
	R CMD SHLIB mylib.c

This will create the shared object mylib.so. You can then reference the library in your R script

	dyn.load("~/R/lib64/mylib.so")
