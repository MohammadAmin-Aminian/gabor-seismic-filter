function bank = createGaborFilterBank(numScales, numOrientations, filterSize)
%CREATEGABORFILTERBANK Construct the complex 2-D Gabor filters used here.
%   BANK = CREATEGABORFILTERBANK(NUMSCALES, NUMORIENTATIONS, FILTERSIZE)
%   returns a NUMSCALES-by-NUMORIENTATIONS cell array. FILTERSIZE may be a
%   scalar or [rows columns]. The implementation preserves the equations
%   and indexing of the supplied gaborFilterBank.m routine.

arguments
    numScales (1,1) double {mustBeInteger,mustBePositive}
    numOrientations (1,1) double {mustBeInteger,mustBePositive}
    filterSize (1,:) double {mustBeInteger,mustBePositive}
end

if isscalar(filterSize)
    filterSize = [filterSize filterSize];
elseif numel(filterSize) ~= 2
    error('filterSize must be a scalar or [rows columns].');
end

numRows = filterSize(1);
numColumns = filterSize(2);
[columnGrid, rowGrid] = meshgrid(1:numColumns, 1:numRows);
rowGrid = rowGrid - (numRows + 1) / 2;
columnGrid = columnGrid - (numColumns + 1) / 2;

maximumFrequency = 0.25;
aspectRatio = sqrt(2);
bank = cell(numScales, numOrientations);

for scaleIndex = 1:numScales
    frequency = maximumFrequency / sqrt(2)^(scaleIndex - 1);
    sharpness = frequency / aspectRatio;

    for orientationIndex = 1:numOrientations
        theta = (orientationIndex - 1) * pi / numOrientations;
        xPrime = rowGrid .* cos(theta) + columnGrid .* sin(theta);
        yPrime = -rowGrid .* sin(theta) + columnGrid .* cos(theta);

        envelope = exp(-sharpness^2 .* (xPrime.^2 + yPrime.^2));
        carrier = exp(1i * 2 * pi * frequency .* xPrime);
        bank{scaleIndex, orientationIndex} = ...
            frequency^2 / (2 * pi) .* envelope .* carrier;
    end
end
end
