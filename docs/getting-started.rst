===============
Getting Started
===============


Installing SALib
----------------

To install the latest stable version of SALib using pip, together with all the 
dependencies, run the following command:

::

    pip install SALib
    
To install the latest development version of SALib, run the following
commands.  Note that the development version may be unstable and include bugs.
We encourage users use the latest stable version.

::

    git clone https://github.com/SALib/SALib.git
    cd SALib
    python setup.py develop


Installing Prerequisite Software
--------------------------------

SALib requires `NumPy <http://www.numpy.org/>`_, `SciPy <http://www.scipy.org/>`_,
and `matplotlib <http://matplotlib.org/>`_ installed on your computer.  Using
`pip <https://pip.pypa.io/en/stable/installing/>`_, these libraries can be
installed with the following command:

::

    pip install numpy
    pip install scipy
    pip install matplotlib

The packages are normally included with most Python bundles, such as Anaconda and Canopy.
In any case, they are installed automatically when using pip or setuptools to install
SALib.    


Testing Installation
--------------------

To test your installation of SALib, run the following command

::

    python setup.py test

Alternatively, if you’d like also like a taste of what SALib provides,
start a new interactive Python session
and copy/paste the code below.

.. code:: python

    from SALib.sample import saltelli
    from SALib.analyze import sobol
    from SALib.test_functions import Ishigami
    import numpy as np

    # Define the model inputs
    problem = {
        'num_vars': 3, 
        'names': ['x1', 'x2', 'x3'], 
        'bounds': [[-3.14159265359, 3.14159265359], 
                   [-3.14159265359, 3.14159265359], 
                   [-3.14159265359, 3.14159265359]]
    }

    # Generate samples
    param_values = saltelli.sample(problem, 1000)

    # Run model (example)
    Y = Ishigami.evaluate(param_values)

    # Perform analysis
    Si = sobol.analyze(problem, Y, print_to_console=True)

    # Print the first-order sensitivity indices
    print Si['S1']

If installed correctly, the last line above will print three values, similar
to :code:`[ 0.30644324  0.44776661 -0.00104936]`.