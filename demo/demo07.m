% ---------------- unit 4: data types --------------------

% ---- data types known so far
% our good old friend, the double
a=1
% the logical
b=5<1

% ---- data type half-known so far: char(acter),
% char arrays 
c='hallo'
% some functions for dealing with character arrays
ischar(c)
c='Mama ate a banana grown in Panama'
strfind(c,'ma')
strfind(c,'Ma')
% we can perform the usual array manipulations
fliplr('risotto sir?')
flipud(['cat  ';'eats ';'mouse'])

% what are character arrays needed for?

% 1. e.g. for titles, labels, etc
x=0:.1:10;
y3=randn(size(x));
plot(x,y3,'k-');
title(['largest value: ' num2str(max(y3))]);

% 2. e.g. for building file names with ascending
% numbers as part of the file name 
fIndex=[8:20];
numOfFiles=length(fIndex);
% from the array of integers generate a char array 
% with four columns, namely the zero-padded file
% indices
for i=1:numOfFiles
  fName(i,:)=['dataFile_' sprintf('%.4i',fIndex(i)) '.mcd']; 
end
fName
% this list could then be used e.g. to load all
% the files in it from disk and perform some
% computation on the data in them:
try
  for i=1:numOfFiles
    load(fName(i,:));
    % perform some computation on the data..
  end
catch MExc
  disp(MExc.message);
end


%  ------- NEW data types
% ** 1. struct(ure) arrays **
animal.name='cow';
whos animal
animal.numberOfFeet=4;
animal.sound='moooh';
whos animal

% we can have structure arrays
animal(2).name= 'swordfish';
animal(2).numberOfFeet=nan;     
animal(2).sound='';             % empty char

% note the automatic expansion of the 
% struct array
animal(10).name='centipede';
animal(10).numberOfFeet=100;
animal(10).sound='krrz';
whos animal
animal
animal(3)
animal.numberOfFeet

% access to the fields:
% assuming all animals are bilaterally symmetric
% let's 'compute' the number of feet on either
% side of the rostrocaudal axis
a=animal(1).numberOfFeet/2

% can we compute this for all elements whithout a
% loop?? --> yes, but only by concatenation of
% values via []
[animal([1:2 10]).numberOfFeet]/2

% the inverse problem: setting values of all
% fields: it won't work like this
animal(1:end).planet='earth'
% we have to use the 'deal' function on the right
% hand side and square brackets on the left hand
% side
[animal(1:end).planet]=deal('earth');
% or just
[animal.planet]=deal('earth');

% structure arrays may be n-dimensional
animal(1,1,2).name='goldfish'

% here is an example of a structure used in real
% life:
edit dset_04708001

% A potentially useful example of 'batch
% processing': the output of function dir is a
% struct array. The four fields of this struct
% array allow you to e.g. generate a list of files
% in the current directory
% - all files in the data subdirectory:
s=dir('data');
s
s.name
% since this will include directories as well, we
% have to make use of field isdir to get rid of
% them:
[s.isdir]
s(~[s.isdir]).name
% using function char, we can thus generate a file
% list
fList=char(s(~[s.isdir]).name)
% we can also determine the largest file
[~,mIx]=max([s.bytes]);
s(mIx).name
% - all files in the data subdir ending in *.asc:
s=dir('data\*.asc')


% ** 2. Cell arrays **
% like struct arrays, cell arrays allow you to
% keep data of largely different type and size
% together in one variable
% -->> see ill2.jpg for an example of a usage of
% cell arrays
% a single cell
c={3}
% this does not work: 
c+3
% but this
c{1}+3
% as promised, we may combine variables of 
% different classes in a cell array:
c{2}='cow'
% equivalent:
c(2)={'cow'}

% ***********************************************
% *  {} = reference to the 'content' of a cell  *
% *  () = reference to a cell                   *
% ***********************************************

% cell arrays may hold any type of data
c(3)={ones(10)}
% access to the elements:
c{3}(5,1:2)
% cell arrays may be n-dim
c(1,1,2)={123}

% another example of usage of a cell array:
% the output of an analysis of variance (the
% function computing it is available at the matlab
% file exchange).
% Let's load some data
load d05
% do the computations
stats=rm_anova2(ds(:,2),indv,groupTag(:,1),groupTag(:,2),groupTagName)
% The function's author decided to place the 
% results into a cell array which allows for 
% both an acceptable display of and easy access 
% to the results. E.g., you may want to compute a
% measure of effect size called partial eta
% squared, which is computed from the summed
% squares terms in the table:
partialEta2=stats{2,2}/(stats{2,2}+stats{5,2})

% ** 3. tables **
% In R2013b, new data type 'table' was introduced.
% After cursory reading about tables we may be
% tempted to create our database of animals as a
% table like this (note the transpose operators):
animals=table({'cow','swordfish','centipede'}',...
  [4 nan 100]',{'mooh','','krrz'}')
whos animals

% Fine, we have a table, but with nondescript
% column headers 'Var1' and so on. We can do
% better by assigning concrete names to the
% columns = variables
animals=table({'cow','swordfish','centipede'}',...
  [4 nan 100]',{'mooh','','krrz'}',...
  'VariableNames',{'name','numFeet','sound'})

% Now, we can use syntax we know from struct
% arrays to access the table's columns
animals.name
animals.numFeet/2
% So, major lesson learned: columns = variables
% are an essential concept of tables. Variables
% can be logical arrays, numerical arrays (like
% the column quantifying the number of feet), cell
% arrays or any other array, the only requirement
% being that all variables have the same number of
% rows.
% Let's look at this:
animals=table([4 nan 100]',{'mooh','','krrz'}',...
'RowNames',{'cow','swordfish','centipede'},...
'VariableNames',{'numFeet','sound'})
% So, we can obviously also specify row names.
% We'll get back to this further below.

% Access to the elements of the table follows a
% similar logic as that of cell arrays:
% - this is a (mini-) table
animals(3,1) 
% - this is the content of the table in that
% position, a single number
animals{3,1} 
% Be aware that accessing elements of a variable
% that is a cell array requires double
% 'unwrapping':
% - this is a cell array
animals{3,2}
% - this is a char array
animals{3,2}{1}

% Let's now assign values and see whether there is
% automatic expansion of tables, too
animals{5,1}=6
animals{5,2}={'sss-sss'}
% or 
animals(5,:)={6,{'sss-sss'}}
% Yes, there is automatic expansion, the rules
% being those we know already from numerical
% arrays (gaps are filled with zeros) and cell
% arrays (gaps are filled with []). However, the
% new row names are nondescript. We can change
% this:
animals.Properties
animals.Properties.RowNames{5}='blowfly'

% Q: can we have higher-dimensional tables?
animals{5,1,1}=4
% A: No. Tables are by design 2D.

% There are a number of function pairs which
% convert data to and from tables, e.g.
% array2table and table2array, cell2table and
% table2cell, etc.

% Summary and additional notes in connection with
% data type table:
% 1. Tables are a high-level, specialized data
% type that is useful for many kinds of data that
% are best stored or assembled in tabular format.
% 2. Compared to struct arrays and cell arrays
% tables have the advantage of some built-in
% checking of data consistency, thus minimizing
% errors when large data sets are assembled. See
% exercise 4.7. However, specialization comes at a
% price, namely, the loss of universality (tables
% cannot be higher-dimensional).
% 3. Dealing with tables requires solid knowledge
% of cell arrays and struct arrays/dot notation
% syntax, in other words, is not straightforward.
% 4. Backward compatibility of code is an issue.
% Any code relying on this data type will
% obviously not run on Matlab releases prior to
% the introduction of tables (R2013b). 
% 5. The Mathworks state that tables will be here
% to stay in Matlab, and right now there is no
% reason to suspect otherwise. A range of newly
% added functions produce tables as an output,
% including those reading data from files (see the
% next demo). However, generally think twice
% before you jump on the bandwagon immediately
% after a new data type has been introduced. For
% example, data type 'dataset', introduced not too
% long ago, will be slowly phased out (in favor of
% tables). Anyone who used the dataset type are
% therefore forced to modify their code, at least
% in the long run.