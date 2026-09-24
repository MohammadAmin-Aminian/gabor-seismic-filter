%RUNSYNTHETICEXAMPLE Reproducible demonstration without research data.
clear; close all; clc;

projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(projectRoot, 'src'));
addpath(fullfile(projectRoot, 'examples'));

[cleanSection, noisySection] = makeSyntheticSection();

% A reduced bank keeps the example quick. The research settings are the
% defaults in filterSeismicSection and require substantially more memory.
filteredSection = filterSeismicSection(noisySection, ...
    NumScales=5, NumOrientations=36, FilterSize=31, ...
    BinSize=3, SelectedBins=[1:3 10:12], Divisor=5);

figure('Color', 'white');
tiledlayout(1, 3, 'TileSpacing', 'compact');
nexttile; imagesc(cleanSection); axis tight; colormap gray; title('Clean synthetic');
nexttile; imagesc(noisySection); axis tight; title('With coherent noise');
nexttile; imagesc(filteredSection); axis tight; title('Gabor response sum');
exportgraphics(gcf, fullfile(projectRoot, 'figures', 'synthetic-example.png'), ...
    'Resolution', 180);
