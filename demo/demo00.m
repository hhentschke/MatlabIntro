% ****************************************
% optional unit: the very basics
% ****************************************

% 5 windows +help +editor
helpwin
edit demo00

% --------------- handling variables variables in
% workspace (=data in spreadsheet)
a=1;
whos

% simple numeric operations
b=2;
c=a+b;
c=b*b;
% the equal sign is an assignment: - on the left
% hand side is a variable name (a new one or one
% which exists already) - on the right hand side
% we may have
%  -- numbers 
%  -- combinations/modifications/etc.
%     of variables already in existence
%  -- data generating expressions

% omit semicolon:
c=a+b
c

% arrays & access to their elements all numbers
% from 1 to 25 in increments of 2:
d=1:2:25;
whos
% the second element
d(2)
% the last
d(end)
% 3rd to 7th
d(3:7)
% the 10th, 3rd and last, in this order
d([10 3 end])
% the twentieth..?
d(20)
% assigning value to a non-existing element
% extends the array, filling gaps with zeros
d(20)=111;
d

% change/create single elements
d(20)=11;
d(19)=d(20)/d(3);
% delete elements
d(1)=[]
% change whole array
d=d+2;

% 2D
e=magic(5)
% access to elements: first index=ROW, second
% index=COLUMN
e(3,5)
e(1:4,5)
e(:,2:4)

% concatenating arrays 5 rows, 10 columns
ee=[e e]
% a semicolon in between: 10 rows, 5 columns
ee=[e;e]
% this produces an error because the number of
% lines of ee and e do not match
eee=[ee e]

% --------------- deleting things from workspace
% clean up delete contents of a variable
d=[];
whos;
% delete variable completely
clear a;
whos;
clear e*;
whos;
clear;
whos;

% clear variables in workspace window
