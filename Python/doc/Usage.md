#### Activate the right version of Python

Activation of Python versions is done by using the module command, e.g., 

    module load Python/2.7.8-goolf-1.5.14

This command will only work on one of the build nodes, or on the compute nodes if you use it in your SLURM script. 

To deactivate the activated Python environment:

    module unload Python/2.7.8-goolf-1.5.14

To see which Python packages are available:

    pip freeze

or for Python 3, 

    pip3 freeze

#### Set up your own environment

**For Python 2:**

    module load Python/2.7.8-goolf-1.5.14
    virtualenv --system-site-packages ~/mypython

The output reads: 

New python executable in /home/mfel395/mypython/bin/python
Installing setuptools, pip...done.

**For Python 3:**

    module load Python/3.4.1-goolf-1.5.14
    pyvenv --system-site-packages ~/mypython
 
Unfortunately, pip is NOT installed into the virtual environment. Add it now

    source ~/mypython/bin/activate
    curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | python

Not that under Python3 virtualenv is called pyvenv.

#### Activate the environment and install packages

    module load Python/2.7.8-goolf-1.5.14 )
    source ~/mypython/bin/activate

Note how the system prompt changed to indicate that you are using your new environment
You can now install additional packages into this environment as follows:

    pip install cogent

To deactivate this environment:

     deactivate

#### Run Python interactively on a build node using IPython

 
