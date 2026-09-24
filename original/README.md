# Preserved source files

These files are byte-for-byte copies of the supplied MATLAB sources used by
the seismic workflow and its filter-bank dependency. They are retained for
provenance and numerical comparison.

- `Gabor_6_1.m` and `Plots_6_1.m`: supplied research scripts. They require the
  unavailable `Data_Section.mat` file and also refer to variables not defined
  in the supplied files.
- `gaborFilterBank.m` and `gaborFeatures.m`: third-party routines attributed
  to Mohammad Haghighat. See `THIRD_PARTY_NOTICES.md`.

Two unrelated Gabor-bank demo files (`gabor.m` and `run.m`) were inspected but
are not redistributed because their supplied headers did not identify a
redistribution license. Their absence does not affect this workflow.
