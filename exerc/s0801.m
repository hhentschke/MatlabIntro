%% Load & inspect data
load('data\IPSCRawData.mat');
% Sampling frequency in Hz (inverse of sampling
% interval)
fs=1e6/si;
% Size of things
[n1,n2]=size(ipsc);
% Let's inspect the IPSCs individually
figure(1), clf
for k=1:n2
  subplot(4,5,k)
  plot(ipsc(:,k))
  grid on
  axis tight
end
% ...linking their axes
linkaxes(get(gcf,'children'))
set(gca,'ylim',[-220 -70])
% #5 looks nice

%% Prepare data for fitting
d=ipsc(:,5);
% Subtract the base line and invert in one step:
d=mean(d(1:90))-d;
% Plot in separate figure
figure(2), clf
plot(d)
axis tight
grid on
% Now, let's extract just the decaying phase,
% which starts around the 112th data point
d=d(112:end);
% plot again to make sure
plot(d)

%% Curve fitting
% Call the curve fitting tool 
cftool

% Visual inspection of the data and the fit
% suggests that the double exponential is a better
% fit. A look at the adjusted R squared values
% confirms this impression, although the
% difference is not dramatic at all
% (mono: 0.982; double: 0.987)

% The decay time constant for the monoexponential
% is the inverse of coefficient b; it is about
% 245... strange! Oh, wait, this is the decay time
% constant in points! We have to convert it to
% milliseconds. The sampling interval of the data
% is 100 µs (see variable si), which is 0.1 ms, so
% we have to multiply the value by 0.1 and thus
% obtain an entirely reasonable 24.5 ms. Similarly
% for the fast and slow decay components of the
% double exponential fit.

%% Exported code
% I exported the code for the double exponential
% fit into function IPSCFit_double_exported. To
% verify that things work as promised, let's close
% cftool and call IPSCFit_double_exported with
% IPSC #5 as the input argument. The results
% should be identical
IPSCFit_double_exported(d)

% Dang! The function produces an error! After some
% investigation it was clear that the initial
% values for our four parameters were set to funny
% values. I corrected for this by
% estimating/remembering their values: the
% amplitudes (a1 and a2) must sum to about 120, so
% I set them to 20 and 100, respectively. I
% remembered that the decay time constants in
% points were about 20 and 200. Now at least the
% code runs through without errors, but it may
% still produce strange results. Consequently, I
% define lower bounds for all four parameters,
% setting them all to zero. After this step, the
% fitting function works fine
[fitresult, gof]=IPSCFit_double_exported(d)

%% Test code on other IPSCs:
% Do transformations in one step:
ipscTransformed=mean(ipsc(1:90,:))-ipsc(112:end,:);
for k=1:n2
  [fitresult, gof]=IPSCFit_double_exported(ipscTransformed(:,k))
  pause
end
% We see that in a serious data analysis task we
% should adapt the cutouts for each IPSC
% individually, as some IPSCs start their decay
% phase late, or have additional IPSCs riding on
% their back.
% So, lesson learned: fitting functions to data
% can get a bit tricky and requires attention to
% detail.