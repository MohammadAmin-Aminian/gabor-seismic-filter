%RUNTESTS Run the repository's numerical equivalence tests.
root = fileparts(mfilename('fullpath'));
results = runtests(fullfile(root, 'tests'));
disp(table(results));
assert(all([results.Passed]), 'At least one test failed.');
