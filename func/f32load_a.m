function d=f32load_a(file,startPt,nPts)
% ** function d=f32load_a(file,startPt,nPts)
% Reads file, interpreting contents as binary 4-byte floating point numbers
%
%                         >>> INPUT VARIABLES >>>
%
% NAME             TYPE/DEFAULT          DESCRIPTION
% file             string                file name
% startPt          scalar, 1             reading starts at this point
% nPts             scalar, inf           number of points to read (inf=all)
%                     
%                         <<< OUTPUT VARIABLES <<<
%
% NAME             TYPE/DEFAULT          DESCRIPTION
%
% d                1d-array              data

% default values
verbose=0;
% 4 bytes/data point
bytePP=4;
% byte order
byteOrd='ieee-le';

% the last position the file pointer can move to according to user's specification
lastPos=bytePP*(startPt-1+nPts);
if verbose, disp(['opening file ' file '..']); end;
fid=fopen(file,'r',byteOrd);
if lastPos~=inf
  if fseek(fid,lastPos,'bof')~=0,		
    message=ferror(fid);
    fclose(fid);    
    error(['check startPt and/or nPts (' message ')']);
  end;
end
% rewind 
fseek(fid,(startPt-1)*bytePP,'bof');
disp('reading data..');
d=fread(fid,nPts,'float32');
fclose(fid);

% ------------------ variant a: a 'quick and dirty' solution
% the number of channels in lfp.f32:
nChan=4;
% assuming that the whole data file had been read, i.e. the number of
% data points is identical for each channel, a simple reshape 
% suffices because the data in d is a vertical concatenation
% of the channels
d=reshape(d,length(d)/nChan,nChan);

% all in all, this variant is not flexible because
% - the number of channels is fixed
% and highly problematic because
% - it may fail or at least not work in the desired way if not
%   all data points were read
% See f32load_b for a version improved on both counts
 
