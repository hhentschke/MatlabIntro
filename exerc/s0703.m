% if not yet done, initialize parallel pool
ppool=gcp;
% ppool.NumWorkers gives you the number of workers, 
% which gcp automatically displays on the command line

% load data
m=matfile('data\proj_timeSeriesAnalysis\wrat04_enf0004.mat');
d=m.d;
% - sampling frequency in Hz (inverse of sampling
% interval)
fs=1e6/m.si;
% size of things
[n1,n2]=size(d);

% number of requested surrogate data instances
nSurrD=40;

% i) sequential code
tic
surrD=surrdat(d,fs,nSurrD,true);
seqT=toc

% ii) parallel code
tic
% note that the number of requested surrogate data instances is divided by
% the number of workers
surrFu=parfevalOnAll(@surrdat,1,d,fs,floor(nSurrD/ppool.NumWorkers),true);
wait(surrFu);
% the timer is stopped once the computations are finished, - it is
% debatable whether the time required for 'fetching' the output should be
% included 
parT=toc
% retrieve the output and delete the parallel object
surrD2=fetchOutputs(surrFu);
clear surrFu

% hmmm: comparing surrD and surrD2...
whos 
% ...we see that the outputs of the workers were concatenated in the first
% dim. So,
surrD2=reshape(surrD2,[n1 nSurrD]);

disp(['sequential code: ' num2str(seqT) ' s']);
disp(['parallel code: ' num2str(parT) ' s']);