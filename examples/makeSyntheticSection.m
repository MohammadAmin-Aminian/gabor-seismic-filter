function [cleanSection, noisySection] = makeSyntheticSection(numSamples, numTraces, seed)
%MAKESYNTHETICSECTION Create a small reproducible seismic-style section.
%   The example contains five gently curved Ricker-wavelet reflectors and
%   coherent dipping noise. It is synthetic and carries no research data.

arguments
    numSamples (1,1) double {mustBeInteger,mustBePositive} = 320
    numTraces (1,1) double {mustBeInteger,mustBePositive} = 80
    seed (1,1) double {mustBeInteger,mustBeNonnegative} = 7
end

rng(seed, 'twister');
cleanSection = zeros(numSamples, numTraces);
traceCoordinate = linspace(-1, 1, numTraces);
centers = [65, 115, 175, 235, 275];
curvatures = [8, -5, 11, -7, 4];
amplitudes = [1, -0.8, 0.9, -0.7, 0.75];

halfWidth = 10;
sampleOffsets = (-halfWidth:halfWidth)';
wavelet = (1 - 2 * (sampleOffsets / 3).^2) .* exp(-(sampleOffsets / 3).^2);
for reflectorIndex = 1:numel(centers)
    path = round(centers(reflectorIndex) + ...
        curvatures(reflectorIndex) * traceCoordinate.^2);
    for traceIndex = 1:numTraces
        rows = path(traceIndex) + sampleOffsets;
        valid = rows >= 1 & rows <= numSamples;
        cleanSection(rows(valid), traceIndex) = ...
            cleanSection(rows(valid), traceIndex) + ...
            amplitudes(reflectorIndex) * wavelet(valid);
    end
end

[sampleGrid, traceGrid] = ndgrid(1:numSamples, 1:numTraces);
coherentNoise = 0.22 * sin(2*pi*(sampleGrid/18 - traceGrid/28));
noisySection = cleanSection + coherentNoise + 0.08 * randn(size(cleanSection));
end
