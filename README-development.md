Development notes
=================

## Step 1: Checkout the source code

The file [``resources.yaml``](resources.yaml) lists all necessary repositories. 
Note that you need a specific branch for each repository
(the ``env_dvs`` branch). This ensures that this code continues
to run even as the dependences are changed.

If you installed ``patience`` (``sudo pip install patience``) then this should suffice:
    
    $ pat checkout -s -v
    
Otherwise, you can just use ``git`` manually.

## Step 2: Initialize the environment

Use the script ``initialize_environment.sh`` to install a virtual environment in ``deploy/``:

    $ ./initialize_environment.sh
    
This creates the file ``environment.sh`` with all necessary configuration. From now on, you need to activate the environment:

    $ source environment.sh

## Step 3: Install the Python packages in the environment

Using ``patience`` you can do:

    $ pat develop -s -v
   
Otherwise, go through the repositories in the order they are listed in ``resources.yaml`` 
and run:

    $ python setup.py develop
