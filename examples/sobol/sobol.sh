#!/bin/bash

# Example: generating samples from the command line
salib sample saltelli \
  -n 1000 \
  -p ../../src/SALib/test_functions/params/Ishigami.txt \
  -o ../data/model_input.txt \
  --delimiter=' ' \
  --precision=8 \
  --max-order=2 \
  --seed=100

# You can also use the module directly through Python
# python -m SALib.sample.saltelli \
#      -n 1000 \
#      -p ../../src/SALib/test_functions/params/Ishigami.txt \
#      -o ../data/model_input.txt \
#      --delimiter=' ' \
#      --precision=8 \
#      --max-order=2 \
#      --seed=100

# Options:
# -p, --paramfile: Your parameter range file (3 columns: parameter name, lower bound, upper bound)
#
# -n, --samples: Sample size.
#				 Number of model runs is N(2D + 2) if calculating second-order indices (default)
#        or N(D + 2) otherwise.
#
# -o, --output: File to output your samples into.
#
# --delimiter (optional): Output file delimiter.
#
# --precision (optional): Digits of precision in the output file. Default is 8.
#
# --max-order (optional): Maximum order of indices to calculate. Choose 1 or 2, default is 2.
#								   Choosing 1 will reduce total model runs from N(2D + 2) to N(D + 2)
#								   Must use the same value (either 1 or 2) for both sampling and analysis.
#
# -s, --seed (optional): Seed value for random number generation

# Run the model using the inputs sampled above, and save outputs
python -c "from SALib.test_functions import Ishigami; import numpy as np; np.savetxt('../data/model_output.txt', Ishigami.evaluate(np.loadtxt('../data/model_input.txt')))"

# Then use the output to run the analysis.
# Sensitivity indices will print to command line. Use ">" to write to file.

salib analyze sobol \
  -p ../../src/SALib/test_functions/params/Ishigami.txt \
  -Y ../data/model_output.txt \
  -c 0 \
  --max-order=2 \
  -r 1000 \
  --seed=100

# python -m SALib.analyze.sobol \
#   -p ../../src/SALib/test_functions/params/Ishigami.txt \
#   -Y ../data/model_output.txt \
#   -c 0 \
#   --max-order=2 \
#   -r 1000 \
#   --seed=100

# Options:
# -p, --paramfile: Your parameter range file (3 columns: parameter name, lower bound, upper bound)
#
# -Y, --model-output-file: File of model output values to analyze
#
# -c, --column (optional): Column of model output file to analyze.
#                If the file only has one column, this argument will be ignored.
#
# --delimiter (optional): Model output file delimiter.
#
# --max-order (optional): Maximum order of indices to calculate.
#               This must match the value chosen during sampling.
#
# -r, --resamples (optional): Number of bootstrap resamples used to calculate confidence intervals on indices. Default 1000.
#
#
# -s, --seed (optional): Seed value for random number generation
#
# --parallel (optional): Flag to enable parallel execution with multiprocessing
#
# --processors (optional, int): Number of processors to be used with the parallel option

# First-order indices expected with Saltelli sampling:
# x1: 0.3139
# x2: 0.4424
# x3: 0.0
