function sd=surrdat(d,fs,n,quietMode)
% ** function sd=surrdat(d,fs,n,quietMode)
% generates n instances of iAAFT surrogate data
% for single-column input data d and places them
% in output sd
%
%                       >>> INPUT VARIABLES >>>
%
% NAME          TYPE/DEFAULT        DESCRIPTION
% d             column array        data for which surrogate data is to be 
%                                   generated
% fs            scalar              sampling frequency (Hz)
% n             scalar              number of surrogate data instances
% quietMode     logical, false      optional: if true, no info will be 
%                                   displayed in the command window 
%                     
%                       <<< OUTPUT VARIABLES <<<
%
% NAME          TYPE/DEFAULT         DESCRIPTION
% sd            array                surrogate data 

if nargin<4
  quietMode=false;
end

maxIter=400;
rSeed=0;
% initialize random number generator
rng(rSeed);

[n1,n2,n3]=size(d);

if sum([n1 n2 n3]==1)==2 && n1==1
  warning('reshaping d into column array');
  d=d(:);
  [n1,n2,n3]=size(d);
end

if sum([n1 n2 n3]>1)>1 
  error('input array d must be 1D');
end

if n<1
  error('zero or negative number of shuffled data requested');
end

% preallocate
if isa(d,'gpuArray')
  sd=nan([n1 n],'gpuArray');
elseif isa(d,'single')
  sd=nan([n1 n],'single');
else
  sd=nan([n1 n]);
end
% sorted amplitude of original
dSort=sort(d);
% abs of sum of original
sum_d=sum(abs(d));
% DFT of original
fd=fft(d);
% magnitude of DFT of original and its sum
fdAbs=abs(fd);
% sum_fdAbs=sum(fdAbs);
% phase of DFT of original
fdPha=angle(fd);
% generate vector of frequencies of DFT series:
% - a is 0 for odd values, 1 for even
a=mod(n1+1,2);
% - frequency vector of one-sided spectrum
f=fs/2*linspace(0,1,floor(n1/2)+1);
% - append those for second half 
ix=floor(n1/2)+1-a:-1:2;
f=[f f(ix)];

% from here on do everything column by column in order to save memory
for g=1:n
  % start with AAFT2
  sd(:,g)=real(ifft(fdAbs.*exp(1i*fdPha(randperm(n1)))));
  % rescale by replacing amplitudes
  [~,tmpIx]=sort(sd(:,g));
  sd(tmpIx,g)=dSort;
  isDivergent=true;
  ct=0;
  while isDivergent
    % - compute fft
    tmpft=fft(sd(:,g));
    % - quantify to what degree fft magnitudes diverge (sum of
    % deviations divided by sum of original DFT)
    % diverge_mag=sum(abs((abs(tmpft)-fdAbs)))/sum_fdAbs;
    % - implant original magnitudes, keep phases, transform to time domain
    sd(:,g)=real(ifft(fdAbs.*exp(1i*angle(tmpft))));
    % - compute sorted series
    [tmpd,tmpIx]=sort(sd(:,g));
    % - quantify to what degree time series amplitudes diverge
    diverge_amp=sum(abs(tmpd-dSort))/sum_d;
    % - rescale by replacing amplitudes
    sd(tmpIx,g)=dSort;
    ct=ct+1;
    % - define divergence of distributions of time series as stop
    % criterion
    isDivergent=diverge_amp>.005 && ct<maxIter;
  end
  if ~quietMode
    disp([int2str(ct) ' iterations, divergence ' num2str(diverge_amp)]);
  end
end

