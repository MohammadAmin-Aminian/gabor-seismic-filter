function responses = applyGaborFilterBank(section, bank)
%APPLYGABORFILTERBANK Filter a 2-D seismic section with every bank member.
%   RESPONSES has the same cell-array shape as BANK. Each response preserves
%   the complex phase. MATLAB's IMFILTER defaults (correlation, same size,
%   zero padding) match the supplied research scripts.

arguments
    section (:,:) {mustBeNumeric,mustBeFinite}
    bank (:,:) cell
end

section = double(section);
responses = cell(size(bank));
for scaleIndex = 1:size(bank, 1)
    for orientationIndex = 1:size(bank, 2)
        responses{scaleIndex, orientationIndex} = ...
            imfilter(section, bank{scaleIndex, orientationIndex});
    end
end
end
