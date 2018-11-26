% Read file:
% - first, open it
fid=fopen('data\limerick.txt');
% - read as multiple strings, each of which is terminated by a newline:
% this way is good for ouputting the poetry on screen
limericks=textscan(fid,'%s','delimiter','\n','commentstyle','matlab');
% - close the file (important!)
fclose(fid);
% note that textscan always places its output into a cell array, even if
% the result of its reading operation is already a cell array, as in this
% case (specifically, limericks is a cell array of a cell array of 329
% elements), so we have to do some unwrapping to get access to the
% contents; also, the char() conversion results in the limericks being
% placed in a readily readable way on screen
char(limericks{1})

% For the task of determining frequencies of characters it is much more
% straightforward to read the whole text file into one large char array
% (because if limericks were a cell array we would have to access the
% elements within a foor loop or using cellfun)
% - open it again
fid=fopen('data\limerick.txt');
% read single characters, as many as there are, and stuff them into a char
% array, including any delimiter (newline, tab, etc.) but ignoring their
% potential function as structural elements
limericks=textscan(fid,'%c','commentstyle','matlab');
% - close file again
fclose(fid);
% convert from cell array to array
limericks=limericks{1};

% determine the number of 'a's and 'e's
% limericks has to be transposed, otherwise findstr won't like it
numE=length(findstr(lower(limericks'),'e'));
numA=length(findstr(lower(limericks'),'a'));

% the result
disp(['found ' int2str(numE) ' letters ''e'' and ' int2str(numA) ' letters ''a''']);
if numE>numA
  disp('Ernie is right');
elseif numE<numA
  disp('Bert is right');
else
  disp('the matter is unsettled');  
end