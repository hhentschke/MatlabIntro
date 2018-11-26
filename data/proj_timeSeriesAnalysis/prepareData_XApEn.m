% The code in this file performs preliminary treatment of the data required
% for analysis with cross approximate entropy (XApEn)

% ** modify according to your paths
load d:\hh\teaching\course_matlab\2010_GradSchoolMasters\data\proj_timeSeriesAnalysis\r06enf.mat

% pick any two channels (here, channels 1 and 2)
d=d(:,1:2);

% for an overview, plot the first 2 seconds of the first two channels
figure(1), clf, hold on
excerpt=[0 2];
excerptPts=(excerpt(1)*1e6/si+1:excerpt(2)*1e6/si)';
plot(excerptPts*si/1e6,d(excerptPts,:)+[zeros(size(excerptPts)) -600*ones(size(excerptPts))],'k');
axis tight
xlabel('time (s)');
ylabel('{\mu}V');

% next, lowpass filter the data (-3dB cutoff at 200 Hz)
d=lofi(d,si,200);

% the most important thing to do next (in terms of efficiency): downsample
% the data. The original data had been sampled at 2000 Hz and we know that
% due to our filtering above the signals do not contain a lot of power
% beyond 200 Hz. According to the sampling theorem 400 Hz sampling
% frequency should suffice. However, as the filter used above does not have
% a steep rolloff, let's opt for a sampling rate of 500 Hz. This means we
% have to pick every 4th data point:
d=d(1:4:end,:);
% don't forget to ajust the sampling interval si
si=si*4;

% plot the filtered data as well (in same subplot as raw data; we need a 
% new time axis because we downsampled the data)
excerptPts=excerptPts(1:4:end);
plot(excerptPts*si/1e6,d(excerptPts,:)+[zeros(size(excerptPts)) -600*ones(size(excerptPts))],'m');

% data array d is now in a shape to be submitted to XApEn