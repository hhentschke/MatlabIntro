function d=f32load_x(file,startPt,nPtsPC,nChan)
% ** function d=f32load_x(file,startPt,nPtsPC,nChan)
% Reads file, interpreting contents as binary 4-byte floating point numbers
% NOTE: if data from more than one channel is present in the file it is assumed
% that they are MULTIPLEXED

% ********************************************************************************
% * note the differences to f32load_a in the input parameters: 
%  1. an additional input parameter (nChan) is specified
%  2. nPts changed to nPtsPC (PC=per channel)
% ********************************************************************************
%
%                         >>> INPUT VARIABLES >>>
%
% NAME             TYPE/DEFAULT          DESCRIPTION
% file             string                file name
% startPt          scalar, 1             reading starts at this point (for each channel)
% nPtsPC           scalar, inf           number of points to read per channel (inf=all)
% nChan            scalar,1              number of channels
%                     
%                         <<< OUTPUT VARIABLES <<<
%
% NAME             TYPE/DEFAULT          DESCRIPTION
%
% d                1d-array              data

% default values/precomputation
verbose=0;
% 4 bytes/data point
bytePP=4;
% byte order
byteOrd='ieee-le';
% TOTAL number of points
nPts=nPtsPC*nChan;

% the last position the file pointer can move to according to user's specification
lastPos=nChan*bytePP*(startPt-1+nPtsPC);
if verbose, disp(['opening file ' file '..']); end;
fid=fopen(file,'r',byteOrd);
if lastPos~=inf
  if fseek(fid,lastPos,'bof')~=0,		
    message=ferror(fid);
    fclose(fid);
    error(['check startPt and/or nPtsPC (' message ')']);
  end;
end
% rewind 
fseek(fid,(startPt-1)*bytePP*nChan,'bof');
disp('reading data..');

% **** change in this variant: read data into an array with as many
%      rows as there are channels
[d,count]=fread(fid,[nChan nPtsPC],'float32');
fclose(fid);

% ****** variant x: 
% reshape

% Variable nPtsPC cannot be used without check because if its 
% value is inf (which is legal) reshape will complain.
% However, we need no elaborate check because if nPtsPC does
% not evaluate to the correct value reshape will produce an
% error informing us that either the number of channels or the 
% number of data points given as input arguments were not correct
nPtsPC=count/nChan;
try
  d=reshape(d,nChan,nPtsPC);
  % don't forget to transpose
  d=d';
catch MExc
  warning(['data could not be reshaped: ' MExc.message]);
end

% this variant is flexible because
% - the number of channels is variable (it is an input parameter)
% - it works fine with different numbers of points (per channel)

 
