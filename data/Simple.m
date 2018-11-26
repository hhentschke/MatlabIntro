function y=Simple(x)
% ** function y=Simple(x)
% Simple.m is one of a set of functions intended
% to demonstrate the workings of functions in
% Matlab, particularly 
% - the existence of 'workspaces' ('reserved' 
%   parts of the memory which are separate from 
%   each other), and
% - the 'scope' of variables (=the workspace(s) in
%   which they can be seen)
% 
% See further comments in simple.m (note UPPER and
% lower case in the function names!

% ** To contrast this function with its close
% namesakes in other directories let's make it do
% sth. nasty

d=repmat('Simple..?? ',round(x))
b=exp(x);
y=sqrt(b);
