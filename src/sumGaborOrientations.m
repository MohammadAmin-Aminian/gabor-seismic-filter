function result = sumGaborOrientations(responses, binSize, selectedBins, divisor)
%SUMGABORORIENTATIONS Reproduce the response grouping in Gabor_6_1.m.
%   RESULT sums across scales, groups adjacent orientations into bins, then
%   sums SELECTEDBINS and divides by DIVISOR. The supplied experiment used
%   BINSize=5, SELECTEDBINS=[1:7 30:36], and DIVISOR=10.

arguments
    responses (:,:) cell
    binSize (1,1) double {mustBeInteger,mustBePositive} = 5
    selectedBins (1,:) double {mustBeInteger,mustBePositive} = [1:7 30:36]
    divisor (1,1) double {mustBePositive} = 10
end

numOrientations = size(responses, 2);
if mod(numOrientations, binSize) ~= 0
    error('The number of orientations must be divisible by binSize.');
end

numBins = numOrientations / binSize;
if any(selectedBins > numBins)
    error('selectedBins contains an index larger than the number of bins.');
end

sample = responses{1,1};
orientationSums = zeros([size(sample), numOrientations], 'like', sample);
for orientationIndex = 1:numOrientations
    for scaleIndex = 1:size(responses, 1)
        orientationSums(:,:,orientationIndex) = ...
            orientationSums(:,:,orientationIndex) + responses{scaleIndex,orientationIndex};
    end
end

binned = zeros([size(sample), numBins], 'like', sample);
for binIndex = 1:numBins
    indices = (binIndex - 1) * binSize + (1:binSize);
    binned(:,:,binIndex) = sum(orientationSums(:,:,indices), 3);
end

result = sum(binned(:,:,selectedBins), 3) / divisor;
end
