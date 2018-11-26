% This seemingly senseless exercise is of practical relevance:
% imagine you start a very time-consuming computation
% at the end of which some operation between two of the resulting
% variables must be performed. Now imagine variable 'd'
% 1. does not exist because you lost track of it somewhere in your code
% 2. exists, but is empty because your code is not yet perfect,
%    erroneously assigning to it the empty matrix []
% 3. exists, is not empty, but has the wrong dimension.
% In either case, you would really like to know whether variable 'd' 
% is OK BEFORE using it so as to prevent loss of data due to an error 
% (which always entails termination of the function/script that is 
% being executed). Slightly more elaborate variants of the 
% code below can very well handle this situation.

if exist('d','var')
  if isempty(d)
    warning('d is empty');
  else
    % once again: if we hadn't tested for the content of variable d
    % using isempty above the code lines below testing for the 
    % dimensionality of variable d would be a potential pitfall 
    % (see demo03, a propos isempty)
    [r,c,s]=size(d)
    if (s~=1) 
      disp('d is three-dimensional');
      % in a real application some computation might happen in this place
    else
      disp('d is not three-dimensional - have a nice day');
    end
  end
else
  error('d does not exist');
end