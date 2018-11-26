% The code in this file performs preliminary treatment of the data 
% which is required for detrended fluctuation analysis (DFA)

% load d:\hh\teaching\course_matlab\2009_GradSchoolMasters\data\proj_timeSeriesAnalysis\wrat04_enf0004
load d:\hh\teaching\course_matlab\2009_GradSchoolMasters\data\proj_timeSeriesAnalysis\wrat04_halo0006


% for test purposes cut down the data to a length of 5 min = 600000 data
% points (because the sampling interval is 2000 Hz)
d=d(1:600000);

% for an overview, plot the first 3 seconds of the original data
figure(1)
subplot(2,1,1)
excerpt=[0 3];
excerptPts=excerpt(1)*1e6/si+1:excerpt(2)*1e6/si;
plot(excerptPts*si/1e6,d(excerptPts),'k');
axis tight
xlabel('time (s)');
ylabel('{\mu}V');

% compute & plot power spectrum for an overview
[P,F,avP]=fspecp(d,si,'meth','fft','win',[4000 8000],'limFreq',[0 20]);
figure(1),
subplot(2,1,2)
plot(F,P);
xlabel('freq (Hz)');
ylabel('power spectral density');

% we can see in the power spectrum of the **halothane** data that there is a 
% prominent peak at 4 Hz
% So, band pass filter the data around 4 Hz
d=bafi(d,si,[2.5 5.5]);

% the most important thing to do next (in terms of efficiency): downsample
% the data. The original data had been sampled at 2000 Hz and we know that
% due to our filtering above the signals are not faster than 10 Hz.
% According to the sampling theorem 20 Hz sampling frequency should
% suffice. However, maybe we want to test higher frequencies too, and to be
% on the safe side let's say we want to have a sampling rate of 200 Hz.
% This means we can pick every 10th data point:
d=d(1:10:end);
% don't forget to ajust the sampling interval si
si=si*10;

% plot the filtered data as well (in same subplot as raw data; we need a 
% new time axis because we downsampled the data)
figure(1)
subplot(2,1,1)
hold on
excerptPts=excerpt(1)*1e6/si+1:excerpt(2)*1e6/si;
plot(excerptPts*si/1e6,d(excerptPts),'m');

% next, we need to compute the envelope of the data: we can do this using
% matlab function hilbert (which needs the signal processing toolbox)
d=abs(hilbert(d));

% plot the envelope as well (in same subplot as raw & filtered data)
figure(1)
subplot(2,1,1)
hold on
plot(excerptPts*si/1e6,d(excerptPts),'b');


% data array d is now in a shape to be submitted to DFA