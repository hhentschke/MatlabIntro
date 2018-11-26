clear
people.name='Harald';
people.shoe_size=11.5;
people.favourite_color='blue'

people(2).name='Ernie';
people(2).shoe_size=8;
people(2).favourite_color='orange'

people(3).name='Bert';
people(3).shoe_size=13;
people(3).favourite_color='flashy green'

% An alternative way of generating a struct array
% (only useful if we're dealing with just a
% handful of entries):
people=struct('name',{'Harald','Ernie','Bert'},...
  'shoe_size',{11.5,8,13},...
  'favourite_color',{'blue','orange','flashy green'})

% Understand that this is a horizontal 
% concatenation of three scalars..
[people.shoe_size]
% ..so this is a logical array..
tmp=[people.shoe_size]<12
% ..which we can use to access elements of 
% structure 'people'
people(tmp).name
% So, the one-line version:
people([people.shoe_size]<12).name
% To put the strings in different rows of a single
% array:
char(people(tmp).name)
% We could also place the strings into a cell
% array using a syntax that even experienced
% Matlab users have a hard time memorizing. A
% reason for doing so may be efficiency (function
% char may be slow compared to building cell
% arrays). First, determine how many there are
nbigFootPeople=numel(find(tmp));
% Then, do it using 'deal'
[bigFootPeople{1:nbigFootPeople}]=deal(people(tmp).name);


% Not part of the task, but also interesting: how
% can we determine Ernie's shoe size without
% scrolling through the elements of 'people'
% manually? Generally speaking, how to identify in
% a struct array an element of which one field
% matches a certain value?

% This is useless
[people.name]
% That's at least readable
char(people.name)
% But this is ideal for easy usage with strcmp
{people.name}
% Localize Ernie
tmp=strcmp('Ernie',{people.name})
% Here is his shoe size
people(tmp).shoe_size
