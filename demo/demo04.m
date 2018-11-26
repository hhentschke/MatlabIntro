% -------- unit 2 ----------------
% ------ if, messages, warnings, errors
% the 'if' construct is used to control the
% execution of code, in this case the message
% displayed
clear

%% if construct
if 1+1~=2
  disp('someone broke the foundations of mathematics');
elseif 1+1==2
  disp('everything is good');
else
  disp('someone broke the computer');
end

%% if, warning, error
% Often, critical conditions like the existence of
% a variable or its contents are checked, and in
% cases failure to fulfil a condition justifies a
% warning message or even a program break
if exist('d','var')
  if isequal(d,22)
    d=d^2
  else
    warning(['d is not 22 but '   num2str(d) ]);
  end
else
  error('variable d does not exist')
end

% note that 
% 1. 'if' must always be terminated by 'end' 
% 2. 'if' statements can be nested (one is within 
% the other) 
% 3. the argument given to the 'if' construct 
% should be a SCALAR LOGICAL (a single-element 
% array), otherwise the problem is ill-defined:
% consider the following

%% ill-posed problem
m=[-22 10]
if m<0
  clc
  disp('Matlab believes that ''Yes, no'' means ''yes'''); 
else
  clc
  disp('Matlab believes that ''Yes, no'' means ''no'''); 
end
% in the past, the code above behaved differently
% in different Matlab versions (and may do so
% again!)

%% any, all
% depending on what you'd like to test use 'any'
% or 'all
if any([0 0 5]>1)
  clc
  disp('at least one of the elements is larger than 1');
end
if all([21 12])
  clc
  disp('all elements are different from 0'); 
end

%% short-circuit logical operators
% what if you want to test for several conditions
% at once?
if exist('d','var') && isequal(d,22)
  d=d^2
end
% logical AND and OR operations on SCALARS
% (=single numbers) should be done with the
% operators && and ||, respectively. They allow
% 'short-circuiting': in the expression above, the
% second condition (the question whether variable
% d has value 22) is never tested in case the
% first (existence of variable d) is not
% fulfilled. If you used the operator & instead of
% &&, the behavior of Matlab is undefined. && and
% || don't work on arrays:
[0 0] && [0 1]


%% switch 
% when numerous alternatives exist the 'switch'
% statement may be preferred over the 'if'
% construct
number=randi(11,1)-1
clc
switch number
  case 1
    disp('the number is 1');
  case 2
    disp('the number is 2');
  case 3
    disp('the number is 3');
    % note the CURLY brackets below
  case {4,5,6,7,8,9}
    disp('the number is between 4 and 9')
  case 4
    % ** note that this case will never be reached
    % because it is already caught by the case
    % above
    disp('the number is 4');
  otherwise
    disp('the number must be 0 or 10');
end

%% try-catch 
% Then, there are certainly situations which
% should be 'caught': Test an array x with
% expression 1 in task 1.12
x=[1 1 1 0];
try
  x=x(x)
  disp('the current x did well when subjected to x=x(x)');
catch MExc
  disp('x, subjected to x=x(x), resulted in an error that was caught');
end
% the line 
%    catch MExc 
% instructs Matlab to place information on the
% mishap into variable MExc, which is of a data
% type made for allowing you to deal in
% sophisticated ways with errors. We'll use it
% here just to display what (mis-) happened:
disp(MExc.message)

%% catch me if you can
% try-catch statements are very useful in
% situations where the potentially harmful outcome
% of a certain operation cannot be predicted
% easily or at all (like the one above) or errors
% are made voluntarily, e.g. for demonstration
% purposes (like in some demo files to follow!)
% However, the try-catch construct is not the
% ultimate savior: certain syntactical errors like
% incomplete expressions will not be caught
try
  d=
catch MExc
  % this code line will never be executed
  % (luckily...)
  exit
end


%% for and while loops
% our task now: compute the squares of all integer
% values from -10 to 10

%% a for loop
x= -10:10;
for i=1:length(x)
  d(i)=x(i)^2;
end
d
  
%% the same task as a while loop
d=[];
i=1;
while i<=length(x)
  d(i)=x(i)^2;
  i=i+1;
end  
d

%% the same task 'vectorized' (=accomplished
% without resorting to one of the two loop
% constructs)
d=x.^2

% ************************************************
% ************************************************
%  many tasks that can only be solved in loops in
%  programming languages like C can and should be
%  solved in the 'vectorized' way in matlab for a
%  reason illustrated in demo05.m
% ************************************************
% ************************************************

edit demo05
