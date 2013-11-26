Recommended usage is to load the Gaussian module into your environment:

    module load Gaussian/D.01

Or, for the older version:

    module load Gaussian/C.01

You should then be able to run g09 from the command line or a LoadLeveler script:

    g09 < gaussian_input.gjf

If you want Gaussian's temporary files (*.inp, *.d2e, *.int, *.rwf and *.scr) to be written to a particular directory, you can achieve this by setting the GAUSS_SCRDIR environment variable in your LoadLeveler script. For example, if you want to put your scratch data on gpfs1m, this should go in your LoadLeveler script before invoking the g09 command:
export GAUSS_SCRDIR=/gpfs1m/<directory>

In its own input file, Gaussian has flags you can set relating to number of processors (%NProcShared) and memory (%Mem). These will ideally be set as follows:

    %NProcShared=<np> (where <np> is the number of cores to be used)
    %Mem=<number><units>. See the Gaussian manual or online help pages for instructions on how to set %Mem. It is good practice to set %Mem to somewhere between 80% and 90% of the memory specification in the node_resources directive of your LoadLeveler file. Setting %Mem this way ensures that, if Gaussian should go marginally out of its own bounds (as I've seen happen from time to time), it won't be killed with extreme prejudice by the queueing system
