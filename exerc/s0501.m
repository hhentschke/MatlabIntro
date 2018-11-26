load d01 milk2;
% Let's make a temporary directory
mkdir('tmpData');
% Let's be explicit about the version using the -v
% flag
save tmpData\tmpfile1 milk2 -v6
save tmpData\tmpfile2 milk2 -v7
save tmpData\tmpfile3 milk2 -v7.3
save tmpData\tmpfile4.asc milk2 -ascii
save tmpData\tmpfile5.asc milk2 -ascii -double

% Collect information on the files just produced
s=dir('tmpData')

% milk2 contains 730 * 3 values
nEle=prod(size(milk2));
% Here is the approximate disk space needed, in
% bytes per number, for milk2 (to verify the
% numbers below you can look up the size of the
% files, e.g. by right mouse click-properties in
% the windows explorer):

clc
disp('Number of bytes per element (730*3 double values) for the different file formats:')
disp('- mat file, uncompressed (matlab version 6.x, see demo08:')
disp(s(strcmp({s.name},'tmpfile1.mat')).bytes/nEle)

disp('- mat file, compressed (default for matlab version 7.x):')
disp(s(strcmp({s.name},'tmpfile2.mat')).bytes/nEle)

disp('- mat file, hdf5 format allowing file sizes > 2 GB:')
disp(s(strcmp({s.name},'tmpfile3.mat')).bytes/nEle)

disp('- ascii, 8 digits:')
disp(s(strcmp({s.name},'tmpfile4.asc')).bytes/nEle)

disp('- ascii, 16 digits:')
disp(s(strcmp({s.name},'tmpfile5.asc')).bytes/nEle)

% Explanation of the size of the files: In matlab,
% numbers are by default represented as 'floating
% point' numbers with double precision (dubbed
% 'doubles') taking up 8 bytes per number. Since
% in Matlab V. 6 numbers are written into *.mat
% files with that precision we would principally
% expect 8*730*3 bytes. The actual file is larger
% because of the 'header', a variably sized piece
% of information matlab needs to put the variables
% together again upon loading. The files produced
% with 'save ... -v7' are substantially smaller
% because Matlab compresses them. Files produced
% with 'save ... -v7.3' are in between, larger
% than the V. 7 ones, because the data are stored
% in the hdf5 format (which is a
% platform-independent, information-rich format).
% The ascii files take up vastly more space. Why
% is that so? To see this, open a new file in any
% editor, write 'Bert' into it and save it on disk
% as PLAIN TEXT (and do not insert a space, new
% line etc.). Determine the size of the file
% (right mouse click - properties) - it should be
% 4 bytes. In an ascii file, each character takes
% up exactly one byte no matter whether the
% character is a number or not; this applies even
% to blanks, new lines, tabs, etc. In the ascii
% files produced by the save command each number
% has a fixed appearance; the number 1 for example
% reads 1.0000000e+001. This is a number with 8
% digits of precision; however, the number of
% characters needed for this notation is 8 +1(the
% decimal point) +1 (the e) +1 (the plus or minus
% sign) +3 (the exponent) +2 (the blanks
% separating the numbers within a line), amounting
% to a total of 16. Additionally, after each line
% both the newline character and the linefeed
% characters are needed, hence the value of 16.67
% bytes per number for this particular variable
% with three columns. An according calculation can
% be done for the ascii with 16 digits of
% precision.

% Generally, storing variable milk2 in either of 
% the ways done here is
% 1. convenient (the command is a one-liner, not
%    too much pondering about the details is 
%    needed)
% 2. in the case of ASCIIs, possibly the only way
%    to get the data from matlab into other
%    programs (because most analysis programs
%    offer the option to read data as plain text,
%    that is, ASCII or unicode);
% 3. by the same reasoning, in the case of the
%    *.mat format, no good choice if these data 
%    shall be read by other programs
% 4. particularly in the case of the ASCIIs an
%    outrageous waste of disk space!
 
% Why?
% We know that the numbers in milk2 are within
% narrow limits, say between 0 and 50. We could
% therefore convert the numbers to a different,
% smaller data type without loss of information
% and save them using less disk space. 
% HOWEVER:
% a) make sure you know what happens with your
%    data upon conversion - integers for example 
%    cannot be nan or inf.
% b) in earlier matlab versions (V.6 and first
%    V.7 ones) arithmetic computation between data
%    types other than double may be limited - they
%    will have to be reconverted to double
% c) converting and re-converting data takes time
%    and is potentially error-prone

% Nonetheless, an example of a more
% memory-efficient storage: save milk2 with single
% precision
milk2_single=single(milk2);
save tmpData\tmpfile6 milk2_single -v6;
save tmpData\tmpfile7 milk2_single -v7;

s=dir('tmpData');
% Size now: less than the above (it is not
% necessarily half because the mat files have
% headers)
disp('- mat file, SINGLE, uncompressed (matlab version 6.x:')
disp(s(strcmp({s.name},'tmpfile6.mat')).bytes/nEle)

disp('- mat file, SINGLE, compressed (matlab version 7.x:')
disp(s(strcmp({s.name},'tmpfile7.mat')).bytes/nEle)