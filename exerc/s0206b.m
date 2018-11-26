% full blown test of array x on all expressions listed in 
% exercise 1.12

% examples:
x=logical([89 98 1 -3]); % does it
x=[89 98 1 -3]; % does not fulfill expression 4

% which expression shall be tested?
express=1;

try
  switch express
  case 1
    y=x(x);
  case 2
    y=x(logical(x));
  case 3
    y=x(~x);
  case 4
    y=logical(x);
  case 5
    y=~x;
  otherwise
    error('bad choice of express');
  end
  % note the use of function 'all'
  if all(y==x)
    % test for number type 
    if (islogical(x) & islogical(y)) 
      disp(['x = ' int2str(x) '  (x LOGICAL) fulfils expression ' int2str(express)]);
    elseif (~islogical(x) & ~islogical(y))
      disp(['x = ' int2str(x) '  fulfils expression ' int2str(express)]);      
    else
      disp(['x = ' int2str(x) ' does NOT fulfil expression ' int2str(express) ' due to change of number type']);
    end
  else
    disp(['x = ' int2str(x) ' does NOT fulfil expression ' int2str(express) ' due to change of element values']);
  end
catch
  disp('the current x is so badly guessed that it produced an error that was caught by try..catch');
end
