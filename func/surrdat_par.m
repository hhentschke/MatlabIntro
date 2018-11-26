function sd=surrdat_par(d,fs,n)
% ** function sd=surrdat_par(d,fs,n)
% generates n instances of iAAFT surrogate data
% for single-column input data d and places them
% in output sd. Variant of surrdat.m using parfor loop.
%
%                       >>> INPUT VARIABLES >>>
%
% NAME          TYPE/DEFAULT        DESCRIPTION
% d             column array        data for which surrogate data is to be 
%                                   generated
% fs            scalar              sampling frequency (Hz)
% n             scalar              number of surrogate data instances
% 
%                     
%                       <<< OUTPUT VARIABLES <<<
%
% NAME          TYPE/DEFAULT         DESCRIPTION
% sd            array                surrogate data 

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
sd=nan([n1 n]);
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
isDivergent=true(n,1);
ct=zeros(n,1);
parfor g=1:n
  curD=sd(:,g);
  % start with AAFT2
  curD=real(ifft(fdAbs.*exp(1i*fdPha(randperm(n1)))));
  % rescale by replacing amplitudes
  [~,tmpIx]=sort(curD);
  curD(tmpIx)=dSort;

  while isDivergent(g)
    % - compute fft
    tmpft=fft(curD);
    % - quantify to what degree fft magnitudes diverge (sum of
    % deviations divided by sum of original DFT)
    % diverge_mag=sum(abs((abs(tmpft)-fdAbs)))/sum_fdAbs;
    % - implant original magnitudes, keep phases, transform to time domain
    curD=real(ifft(fdAbs.*exp(1i*angle(tmpft))));
    % - compute sorted series
    [tmpd,tmpIx]=sort(curD);
    % - rescale by replacing amplitudes
    curD(tmpIx)=dSort;
    ct(g)=ct(g)+1;
    % - define divergence of distributions of time series as stop
    % criterion
    isDivergent(g)=sum(abs(tmpd-dSort))/sum_d>.005 && ct(g)<maxIter;
  end
  sd(:,g)=curD;
end

