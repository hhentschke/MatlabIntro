load IPSC

whos
% let's place all graphs into one figure with
% subplots
figure(1), clf, orient tall

% - rise times
subplot(3,2,1)
% a histogram with 20 equally spaced and
% automatically determined bins
histogram(tRise,20);
% set the axis limits 'tight' 
axis tight
ylabel('N');
xlabel('log rise time (ms)');
% alternative: define the bins using
% linspace
bin=linspace(min(tRise),max(tRise),30);
histogram(tRise,bin);
axis tight
% or we could use the predefined bins
histogram(tRise,binRise)
axis tight
% however, in the bar plot we don't want the
% uppermost bar to 'touch the ceiling', so let's
% scale the y axis manually
set(gca,'ylim',[0 1350]);
ylabel('N');
xlabel('log rise time (ms)');

% - decay times
subplot(3,2,2)
histogram(tDecay,20);
axis tight
% again, scale the y axis. We could do it manually
% again. However, this is tiresome if many plots
% are to be generated. Here is an automatic
% version which expands the upper limit by one
% tenth and sets the lower one to zero:
yl=get(gca,'ylim');
set(gca,'ylim',[0 yl(2)*1.1]);
ylabel('N');
xlabel('log decay time (ms)');

% - scatter plot of decay time versus rise time
subplot(3,2,3)
plot(tRise,tDecay,'o');
% scaling: manual again, using the axis command
axis([-2.5 3.8 -.8 5.4])
xlabel('log rise time (ms)');
ylabel('log decay time (ms)');
% this plot reveals the existence of two
% populations of IPSCs: one with fast rise and
% decay times and a smaller one with slower
% dynamics. Let's see how frequently they occur in
% the following plots

% - surface plot of 2D histogram
subplot(3,2,4)
surf(binRise,binDecay,h2)
% in this plot and the ones below a tight axis
% looks alright
axis tight
xlabel('log rise time (ms)');
ylabel('log decay time (ms)');
zlabel('N');
% if the perspective is suboptimal, change it by
% clicking on the 'Rotate 3D' button in the
% figure's toolbar (you'll recognize it) or
% programmatically by first retrieving the values
% for azimuth and elevation (to get an idea of
% what the current values are)...
get(gca,'view')
% ...and then changing them via
set(gca,'view',[-50 25]);
% or 
view([-50 25]);


% - contour plot of 2D histogram
subplot(3,2,5)
% contour is a little tricky: we have to instruct
% it to use more than the default number of
% contour lines, otherwise the small population of
% IPSCs with long rise and decay times will be
% missed
contour(binRise,binDecay,h2,50)
axis tight
xlabel('log rise time (ms)');
ylabel('log decay time (ms)');

% - 3D bar plot
subplot(3,2,6)
bar3(binRise,h2)
axis tight
ylabel('log rise time (ms)');
zlabel('N');


