function y=simple2(x)
% ** function y=simple2(x)
% simple2.m is one of a set of functions intended
% to demonstrate the workings of functions in
% Matlab, particularly 
% - the existence of 'workspaces' ('reserved' 
%   parts of the memory which are separate from 
%   each other), and
% - the 'scope' of variables (=the workspace(s) in
%   which they can be seen)
%
% simple2.m illustrates the nature of persistent
% variables. Place a break point on the line
% saying 'persistent d'. Then, call the function
% from the command line (with a numerical input
% argument) and step through it, at all times
% having an eye on the functions's workspace and
% the value of d. Do this at least twice.

persistent d

clc
if isempty(d)
  % persistent variable d was initialized with the
  % empty matrix ([]) and will be assigned a value 
  % here 
  disp('persistent variable ''d'' was empty');
  d='variables declared persistent will stick around';
else
  disp(['persistent variable ''d'' is the string ''' d '''']) ;
end
b=exp(x);
y=sqrt(b);
