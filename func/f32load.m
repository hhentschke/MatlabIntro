function d=f32load(file,startPt,nPts)
% ** function d=f32load(file,startPt,nPts)
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
if verbose
  disp(['opening file ' file '..']);
end
fid=fopen(file,'r',byteOrd);
if lastPos~=inf
  if fseek(fid,lastPos,'bof')~=0
    message=ferror(fid);
    fclose(fid);    
    error(['check startPt and/or nPts (' message ')']);
  end
end
% rewind 
fseek(fid,(startPt-1)*bytePP,'bof');
disp('reading data..');
d=fread(fid,nPts,'float32');
fclose(fid);

