function mmixer(arr,nRuns,varargin)
% ** function mmixer(arr,nRuns,varargin) does some
% interesting dynamic exchange of corner elements
% on square matrix arr and plots the result using
% spy. nRuns is the number of corner exchanges and
% plots to be performed. A corner is defined as a
% square subset of matrix arr. By default, corners
% are 10 by 10; you may specify a different length
% of a corner edge (varargin). 
% Input argument arr must fulfil the following
% conditions:
% - it should neither contain only zeroes nor only 
%   non-zero values; if it does plotting it via 
%   spy is not really revealing
% - number of rows = number of columns of arr 
%   > number of rows/columns of corner

% Notes:
% 1. varargin lends some flexibility to the game
% 2. An output is not needed

% the number of rows/columns forming a 'corner'
crn=10;
% determine size
[r,c]=size(arr);

% check of input parameters (not comprehensive)
if r~=c
  error([mfilename ' works only with square matrices']);
end
% if additional input parameter is given, assign 
% its value to crn   
if nargin>2
  crn=varargin{1};
end
if crn>=r
  warning('the corners must be smaller than the matrix itself - setting corner edge length to matrix edge length -1');
  crn=r-1;
elseif crn<1
  warning('zero or negative corner edge length - setting to 1');
  crn=1;
end

% note on the side: animating graphics produced by
% the spy function efficiently using the set/get
% commands is not straightforward because in
% contrast to most other plotting functions, the
% spy function does not provide a handle to the
% graphics. As efficiency of graphics is not the
% focus of the current task, we'll keep things
% simple and call spy in each loop iteration
spy(arr,'k')
spyHandle=get(gca,'children');
for i=1:nRuns
  % this results in the 'corners' being shifted by 
  % one row upwards before each loop execution
  rIdx1=[r-crn+1 r]-mod(i,r-crn)+1;
  arr(rIdx1(1):rIdx1(2),[1:crn c-crn+1:c])=...
    arr(r-crn+1:r,[c-crn+1:c 1:crn]);
  % clockwise rotation:
  arr=rot90(arr,-1);
  spy(arr,'k');
  drawnow;
end