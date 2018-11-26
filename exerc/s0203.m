% don't include any 'clear' commands in this script
n=8000;
clc
% ************************************************
% This is an exemplary case of a loop construct 
% versus 'vectorized' code:
% ************************************************

% a) vectorized - the best original solution to 
% exercise 1.7
disp('vectorized:');
tic
mtable=(1:n)'*(1:n);
toc
pause(.1)
% This way of computing numbers is termed
% 'vectorized' because it uses fast built-in
% routines dealing with vectors (if the matlab
% folks had followed their terminology more
% strictly, they would have termed it
% 'arrayrized')

% b) loop 1 (inner loop fills the rows)
disp('for loop 1:');
tic
for r=1:n
  for c=1:n
    mtable(r,c)=r*c;
  end
end
toc
pause(.1)

% c) loop 2 (now the inner loop fills the columns)
disp('for loop 2 (columns filled first):');
tic
for c=1:n
  for r=1:n
    mtable(r,c)=r*c;
  end
end
toc

% The outcome should be that the vectorized
% version is fastest, next is loop 2, then loop 1
% (it depends somewhat on the computer and the
% size of mtable)

% Let's untangle things step by step.

% i. In current versions of Matlab the
% computaional 'core' is so good that EXTREMELY
% SIMPLE computations can be accomplished about as
% fast in loops as in vectorized code IF VARIABLE
% SIZES ARE SMALL. However, if 'more complicated'
% computations than the simple multiplications
% above have to be performed, vectorized code is
% always faster, and often dramatically so.
% Understanding what 'more complicated' means
% requires knowledge about Matlab topics that we
% have not yet dealt with (take a look at
% mcourse\doc\matlab_jitAccel.pdf for
% comprehensive information on this topic). Still,
% here is an example: modify the code above such
% that e.g. the exponential of the product is
% computed to see the advantage of vectorized
% code.

% ii. The difference in speed between loop 1 and
% loop 2 above has to do with the way Matlab
% stores variables in memory (the exact
% explanation is a little technical). Anyways, the
% fact that filling the columns of arrays is
% faster is yet another impressive demonstration
% that Matlab 'rests on columns'.


% ************************************************
% To sum up:
%  + always try to produce vectorized code, as it
%    is efficient and elegant, but a 'lazy' use of
%    loops is fine (in terms of performance) if
%    only simple scalar operations are performed
%    in the loop and the resulting variables are
%    small in size
%  + if a loop is inevitable and you fill 2- or
%    N-dimensional arrays within loops make sure
%    to fill them column-wise
% ************************************************

