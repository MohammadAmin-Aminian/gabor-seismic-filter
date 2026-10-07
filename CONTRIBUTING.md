# Contributing

Contributions that improve numerical correctness, validation, documentation or
reproducibility are welcome.

## Local checks

Requirements:

- MATLAB R2021a or newer
- Image Processing Toolbox

From the repository root:

```matlab
addpath('src')
runTests
```

Before proposing a change:

1. keep the preserved files under `original/` unchanged unless correcting
   provenance or attribution;
2. add or update a numerical regression test for algorithmic changes;
3. document changes to filter-bank equations, orientation conventions,
   padding or aggregation;
4. keep examples runnable without private seismic data;
5. do not claim general denoising or resolution improvement from the supplied
   qualitative examples alone.

Scientific changes should explain the expected effect on a seismic section and
distinguish implementation fidelity from validation on field data.

GitHub Actions runs the MATLAB test suite for pushes and pull requests.
