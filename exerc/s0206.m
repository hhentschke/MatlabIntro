x=[1 2 3 4]; % does it
x=[2 2 1 2]; % does not do it
x=[89 98 1 -3]; % is really bad

try
  % expression 1
  % assign original value of x to y, otherwise we can't 
%   compare original to new value
  y=x(x);
  % note the use of function 'all'
  if all(y==x)
    disp(['x = ' int2str(x) ' fulfils x=x(x)']);
  else
    disp(['x = ' int2str(x) ' does NOT fulfil x=x(x)']);
  end
catch
  disp('the current x is so badly guessed that it produced an error which was caught by try..catch');
end

% The try catch construct is really helpful for this task
% because how should we find out whether x fulfils a
% condition without actually trying it? If the try catch
% statement did not exist we would either have to accept an
% error (that is, a program break) with each 'really bad'
% choice of x or come up with an algorithm which avoids
% errors to check for the condition.

% Note a potential pitfall, related to the way the '=='
% operator works, in code comparing variables: logical and
% double (or other truly numerical) variables are considered
% equal if their values are the same even though they are of
% different types. To see this, try 
true==double(1)
% or 
isequal(true,double(1))
% See s0206b for a full-fledged test of all expressions