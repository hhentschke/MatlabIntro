% TOPIC: data import and export in Matlab

% 0. see what the Import Wizard can do: in the
% HOME tab of Matlab there is a button 'Import
% Data'. Click it and (try to) import
% d01.mat
% cow.wav
% ppm.txt
% lfp.asc
% lfp.i16

% Also, make sure you click on 'Import Selection' - 
% 'Generate Script' or Generate Function', which
% will produce a file containing the
% data-importing code. Inspect it, see whether you
% can make sense of it.

% Here, in the remainder of the demo script, let's
% do things systematically and programmatically:
% import data using a a variety of functions,
% depending on the file and number type

% 1. mat files
load d01
% the same as 
load d01.mat

clear 
% load just selected variables
load d01 a2

% how about this?
try
  load copy of d01.mat
catch MExc
  disp(MExc.message);
  % whenever there is trouble loading data (e.g.
  % because there are blanks in the file name, or
  % the file name is in a string)
  % -->  use the 'functional' form of load 
  load('copy of d01.mat');
  fn='copy of d01.mat';
  load(fn)
end
whos
clear

% a neat alternative to load/save: matfile, which
% can load and/or save only parts of variables,
% which is very useful when you're dealing with
% large variables
mfH=matfile('d01')
% this loads only the first ten rows of variable
% milk2 (and assigns it to variable d)
d=mfH.milk2(1:10,:)


% 2. numerical ascii files
% load data in two different ways
% a) load
load lfp.asc -ascii
load('lfp.asc','-ascii');
% load generates a variable whose name corresponds 
% to the file name (without extension)
whos
plot(lfp+repmat([0 -1000 -2000 -3000],size(lfp,1),1))
clear
close
% b) dlmread
help dlmread
% dlm = delimiter; dlmread infers it correctly
lfp=dlmread('lfp.asc');
whos
% caution: if the delimiter is inferred,
% consecutive occurrences of it are regarded as
% one (e.g. 4 consecutive whitespaces would be
% interpreted as one). However, this is different
% if the delimiter is explicitly specified:
lfp=dlmread('lfp.asc',' ');
whos
% variable lfp is messed up. More specifically, 
% zeroes are sprinkled  all over the place:
lfp(1:5,1:end)
% the reason is that in lfp.asc the numbers are in
% orderly columns, separated by one space if the
% numbers have a sign and by two if they don't.
% lfp_comma.asc contains the same data as lfp.asc,
% but separated by commas, so in this case
% specifying the delimiter explicitly is fine...
lfp=dlmread('lfp_comma.asc',',');
whos lfp
% ...and we can make use of the useful feature of 
% dlmread to read only a portion of the data
lfp=dlmread('lfp_comma.asc',',',4000,2);
plot(lfp+repmat([0 -1000],size(lfp,1),1))
close
% the counterparts to load and dlmread: 
% save and dlmwrite
help dlmwrite
help save
% *** watch out: there are serious version
% compatibility issues when it comes to saving
% data with the Matlab save function (and its
% menu-based counterpart). In Matlab V. 7.0-7.2,
% data saved using the save function will by
% default be compressed and use 'unicode'
% character encoding (they are thus unreadable for
% Matlab versions 6.x and lower, should that be a
% concern). A major change was implemented in
% Matlab v. 7.3: *.mat files may exceed 2 GB in
% size, are based on the so-called hdf5 format and
% variables may be partly loaded/saved via
% function matfile. In other words, they are not
% compatible with Matlab V. 7.2 and below.
% However, because many Matlab users still have
% their precious data in an earlier format,
% probably the V. 7.0-7.2 format, this is the
% default format even in the present Matlab
% version (Release 2018a).
% Confused? 
% -> you can control the degree of backwards
% compatibility in two ways: by selecting one of
% the three options in the preferences menu (go to
% 'General' - 'MAT files') or by setting a switch
% in the save command:
save nada lfp -v6
save nada lfp -v7
save nada lfp -v7.3

clear


% 3. mixed ascii files (numbers & characters)
% - using fgetl and fscanf
% Before reading from a file with these functions
% the file has to be explicitly opened using
% fopen. fopen returns a 'file identifier', a
% handle to the file, which is similar to a handle
% to a graphics object in that it 'points' to
% something.
fid=fopen('data\ppm.txt');
% fgetl reads the 'header', the first line 
header=fgetl(fid)
[score,nPts]=fscanf(fid,'%i %i %i',[3 inf]);
% the counterpart to fopen - should come right 
% after all read/write operations are finished
fclose(fid);
% let's take a look at the data
score
% score is transposed: fscanf works its way along
% the lines (=rows) of the text file but puts the
% numbers into columns. So, we have to
% re-transpose the data
score=score'
plot(score,'-d')

% - textscan:
fid=fopen('data\ppm2.txt');
% ppm2 has comments in each line which will be
% skipped (the  part '%*[^\n]' means literally:
% 'ignore everything until a newline character 
% is found')
ppm=textscan(fid,'%d%d%d%*[^\n]','headerlines',1);
fclose(fid);
% textscan ALWAYS returns a cell array, so we've 
% got to convert it to an array before plotting
plot(cat(2,ppm{:}),'-d')

% - readtable
% we could also decide to read the data directly
% into a table data type using readtable
ppm=readtable('ppm2.txt','readvariableNames',false,...
  'headerlines',1,'format','%d%d%d%s%*[^\n]')

% just in case you should stumble across function 
% fileread:
edit fileread
% fileread is just a wrapper function for function
% fread - easy to use but inflexible. In most
% cases you'll be better off using either any of
% the functions employed above or fread below)

% this is the function to produce ascii files
% of any sort:
help fprintf


% 4. binary files
% before dealing with binary file i/o we need to 
% - know the difference between floating point 
%   and integer numbers ('floats' and 'integers',
%   (respectively)
% - explore the different types of floats and 
%   integers
% numbers in Matlab are by default 'double', that
% is, floating point numbers taking up 8 bytes per
% number
a=1;
whos a 
% are there data types demanding less memory?
help datatypes
% numbers can be converted from one type to the 
% other (this is also called a 'type cast')
a_single=single(a)
a_uint8=uint8(a)
% this conversion is already known at this point
a_logical=logical(8)
% be aware that conversion to a lesser type 
% may cause trouble:
b=[0 -111 1e123];
b_single=single(b)
b_int8=int8(b)
b_uint8=uint8(b)

% let's see what happens if we perform arithmetics
% on a double and a lesser type?
b=single(5)+5
b=single(5)*5
b=uint8(2)+3
b=uint8(2)/3
% so, in each of the above cases the LESSER number
% type is preserved. HOWEVER:
b=logical(1)/3
whos b
% So, arithmetic involving logicals, the most
% inferior (least information-carrying) type
% results in a type cast to doubles

% *** lessons learned: *** 
% - think twice before converting numbers
% explicitly in your code. Try to make sure that
% extremes in your data will be converted
% reasonably
% - if you find that your code produces funny
% numbers, implicit type casts (e.g. like
% logical(1)/3 above) may be a good starting point
% for debugging

% the functions to use for writing and reading
% binary data: fwrite & fread
help fwrite
help fread

% 5. specialized formats
% xlsread
% imread
% audioread
% VideoReader
% ...
help iofun
