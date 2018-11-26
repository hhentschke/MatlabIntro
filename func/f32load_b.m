function d=f32load(file,startPt,nPtsPC,nChan)
% ** function d=f32load(file,startPt,nPtsPC,nChan)
% Reads file, interpreting contents as binary 4-byte floating point numbers
% NOTE: if data from more than one channel is present in the file it is assumed
% that they are in contiguous blocks of equal length, one after the other
%
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
% nPtsPC           scalar, inf           number of points to read in per channel (inf=all)
% nChan            scalar,1              number of channels the data represents
%                     
%                         <<< OUTPUT VARIABLES <<<
%
% NAME             TYPE/DEFAULT          DESCRIPTION
%
% d                1d-array              data
%
% 

% default values/precomputation
verbose=0;
% 4 bytes/data point
bytePP=4;
% byte order
byteOrd='ieee-le';
% number of points for all channels
nPts=nPtsPC*nChan;

if verbose, disp(['opening file ' file '..']); end;
fid=fopen(file,'r',byteOrd);

% determine max number of points in file
fseek(fid,0,'eof');
maxnPts=ftell(fid)/bytePP;
maxnPtsPC=maxnPts/nChan;
if (maxnPtsPC<0) | (nPtsPC ~= fix(nPtsPC))
  fclose(fid);
  error(['number of channels or number of points per channel not correctly specified (' mfilename ')']);
end

% convert inf values to the real maximum number of points in file
if isinf(nPtsPC)
  nPtsPC=maxnPtsPC;
  nPts=maxnPts;
end

% rewind to beginning of file
fseek(fid,0,'bof');
disp('reading data..');

% change in this variant: read data blockwise into an array with as many
% columns as there are channels
for i=1:nChan
  fseek(fid,((i-1)*maxnPtsPC+startPt-1)*bytePP,'bof');  
  d(:,i)=fread(fid,nPtsPC,'float32');
end

fclose(fid);

% ****** variant b: 
% reshaping is not necessary
% this variant is more flexible because
% - the number of channels is variable (it is an input parameter)
% - it works fine with numbers of points (per channel) different from inf (=all)

% The organization of data in lfp.f32 is not ideal in case we need to access 
% only parts of it. Assume we needed just the very last data point of each channel.
% We would have to 'fread' those data points individually, using fseek and fread 
% as many times as there are channels, or read a whole lot of data points in 
% between and get rid of them. Both options are not satisfying because they are 
% slow and/or error-prone. A better way of organizing the data in the file would 
% be a 'multiplexed' fashion, in which individual data points from the different 
% channels are written alternately:
%  [ch1 ch2 ch3 ch1 ch2 ch3 ...]
% Importantly, this is how multi-channel electrophysiological data (voltage or
% current traces) acquired with an AD converter are generally organized, for example
% data in the abf (Axon Binary File) format). This way one can load up excerpts 
% of data in a contiguous block. Data can be written in a multiplexed way, using 
% the fread function, by transposing the data before writing it (see corresponding 
% passage in demo08.m). See f32load_x for a variant of the f32load functions which 
% reads multiplexed data.