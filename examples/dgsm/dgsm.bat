@echo off

REM Example: generating samples from the command line
salib sample finite_diff ^
  -n 1000 ^
  -p ../../src/SALib/test_functions/params/Ishigami.txt ^
  -o ../data/model_input.txt ^
  -d 0.001 ^
  --delimiter=" " ^
  --precision=8 ^
  --seed=100

REM You can also use the module directly through Python
REM python -m SALib.sample.finite_diff ^
REM      -n 1000 ^
REM      -p ../../src/SALib/test_functions/params/Ishigami.txt ^
REM      -o ../data/model_input.txt ^
REM      -d 0.001 ^
REM      --delimiter=' ' ^
REM      --precision=8 ^
REM      --seed=100

REM Options:
REM -p, --paramfile: Your parameter range file (3 columns: parameter name, lower bound, upper bound)
REM
REM -n, --samples: Sample size.
REM				 Number of model runs is N(2D + 2) if calculating second-order indices (default)
REM        or N(D + 2) otherwise.
REM
REM -o, --output: File to output your samples into.
REM
REM -d, --delta (optional): Finite difference step size (percent). Default is 0.01.
REM
REM --delimiter (optional): Output file delimiter.
REM
REM --precision (optional): Digits of precision in the output file. Default is 8.
REM
REM -s, --seed (optional): Seed value for random number generation

REM Run the model using the inputs sampled above, and save outputs
python -c "from SALib.test_functions import Ishigami; import numpy as np; np.savetxt('../data/model_output.txt', Ishigami.evaluate(np.loadtxt('../data/model_input.txt')))"

REM Then use the output to run the analysis.
REM Sensitivity indices will print to command line. Use ">" to write to file.
salib analyze dgsm ^
  -p ../../src/SALib/test_functions/params/Ishigami.txt ^
  -X ../data/model_input.txt ^
  -Y ../data/model_output.txt ^
  -c 0 ^
  -r 1000 ^
  --seed=100

REM python -m SALib.analyze.dgsm ^
REM      -p ../../src/SALib/test_functions/params/Ishigami.txt ^
REM      -X ../data/model_input.txt ^
REM      -Y ../data/model_output.txt ^
REM      -c 0 ^
REM      -r 1000 ^
REM      --seed=100

REM Options:
REM -p, --paramfile: Your parameter range file (3 columns: parameter name, lower bound, upper bound)
REM
REM -Y, --model-output-file: File of model output values to analyze
REM
REM -X, --model-input-file: File of model input values
REM
REM -c, --column (optional): Column of model output file to analyze.
REM                If the file only has one column, this argument will be ignored.
REM
REM --delimiter (optional): Model output file delimiter.
REM
REM -r, --resamples (optional): Number of bootstrap resamples used to calculate confidence intervals on indices. Default 1000.
REM
REM -s, --seed (optional): Seed value for random number generation
