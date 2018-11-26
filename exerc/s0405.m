clear
% read file
load d03.mat

% spx.name is a 2d char array with the channel names in rows;
% data is a 1d cell array

% channel 001a is the last (of 16) channels, so to access the time stamps
% of this channel, we have to extract the corresponding element in data
tsl=spx.data{16};

% here is way of identifying the channel of interest given just its name
% (we have to convert the char array spx.name to a cell array for strcmp
% to work):
channelIndex=strcmp(cellstr(spx.name),'001a')
tsl=spx.data{channelIndex};

% inter-spike-interval: compute the differences in time
isi=diff(tsl);

% generate the histogram data with a resolution of 1 ms in the range of 0
% to 200 ms
binWidth=1;
binEdges=0:binWidth:200;
binCenters=binEdges(1:end-1)+binWidth/2;
n=histcounts(isi,binEdges);

% plot
figure(1), clf
bar(binCenters,n,1.0,'k');
xlabel('ms');
ylabel('N');
title('ISI channel 001a');

% instead of computing the histogram and plotting it in separate steps we
% can do it in one step; however, in this case we don't have the
% distribution available as a variable for further computation
figure(2), clf
hh=histogram(isi,binEdges);
% in order to get the same 'look', we need to change the default
% 'facecolor' and transparency
set(hh,'FaceColor','k','FaceAlpha',1)
xlabel('ms');
ylabel('N');
title('ISI channel 001a');


% Although generating histograms is not the major topic here, some notes on
% the histogram/histcounts functions are in order:
% 1. histogram and histcounts are relatively new and pretty versatile
%    functions which are sorely needed replacements of the antiquated hist
%    and histc functions (which are still available, though). Check out
%    their many input arguments.
% 2. Note that histogram/histcounts expect bin edges, whereas for plotting
%    here we prefer bin CENTERS as abscissa values
% 3. For computational tasks to do with binning data, particularly in
%    higher dimensions, check out the following functions: discretize,
%    histogram2, histcounts2, accumarray