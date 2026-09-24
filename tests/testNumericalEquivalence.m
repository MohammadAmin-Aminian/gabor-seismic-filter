function tests = testNumericalEquivalence
%TESTNUMERICALEQUIVALENCE Compare cleaned routines with supplied originals.
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root, 'src'));
addpath(fullfile(root, 'original'));
testCase.TestData.Root = root;
end

function testFilterBankMatchesOriginal(testCase)
expected = gaborFilterBank(3, 8, 15, 17);
actual = createGaborFilterBank(3, 8, [15 17]);
for index = 1:numel(expected)
    verifyEqual(testCase, actual{index}, expected{index}, 'AbsTol', 5e-15);
end
end

function testAggregationMatchesOriginalLoops(testCase)
rng(11, 'twister');
responses = cell(2, 12);
for index = 1:numel(responses)
    responses{index} = randn(7, 6) + 1i * randn(7, 6);
end

orientationSums = zeros(7, 6, 12);
for j = 1:12
    for i = 1:2
        orientationSums(:,:,j) = orientationSums(:,:,j) + responses{i,j};
    end
end
bins = zeros(7, 6, 4);
for ii = 1:4
    for kk = (ii * 3) - 2:(ii * 3)
        bins(:,:,ii) = bins(:,:,ii) + orientationSums(:,:,kk);
    end
end
expected = (sum(bins(:,:,1:2),3) + sum(bins(:,:,4),3)) / 2;
actual = sumGaborOrientations(responses, 3, [1 2 4], 2);
verifyEqual(testCase, actual, expected, 'AbsTol', 5e-15);
end

function testSyntheticExampleIsDeterministic(testCase)
addpath(fullfile(testCase.TestData.Root, 'examples'));
[cleanA, noisyA] = makeSyntheticSection(120, 30, 4);
[cleanB, noisyB] = makeSyntheticSection(120, 30, 4);
verifyEqual(testCase, cleanA, cleanB);
verifyEqual(testCase, noisyA, noisyB);
verifySize(testCase, cleanA, [120 30]);
end
