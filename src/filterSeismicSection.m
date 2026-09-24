function [filtered, responses, bank] = filterSeismicSection(section, options)
%FILTERSEISMICSECTION Run the supplied Gabor seismic filtering workflow.
%   [FILTERED, RESPONSES, BANK] = FILTERSEISMICSECTION(SECTION) uses the
%   original experiment's 10 scales, 180 orientations, 39-by-39 filters,
%   groups of five orientations, selected bins 1:7 and 30:36, and divisor
%   10. Pass name-value options to make smaller experiments practical.

arguments
    section (:,:) {mustBeNumeric,mustBeFinite}
    options.NumScales (1,1) double {mustBeInteger,mustBePositive} = 10
    options.NumOrientations (1,1) double {mustBeInteger,mustBePositive} = 180
    options.FilterSize (1,:) double {mustBeInteger,mustBePositive} = [39 39]
    options.BinSize (1,1) double {mustBeInteger,mustBePositive} = 5
    options.SelectedBins (1,:) double {mustBeInteger,mustBePositive} = [1:7 30:36]
    options.Divisor (1,1) double {mustBePositive} = 10
end

bank = createGaborFilterBank(options.NumScales, ...
    options.NumOrientations, options.FilterSize);
responses = applyGaborFilterBank(section, bank);
filtered = real(sumGaborOrientations(responses, options.BinSize, ...
    options.SelectedBins, options.Divisor));
end
