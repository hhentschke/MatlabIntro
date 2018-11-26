function y=simple(x)
% simple.m is one of a set of functions intended
% to demonstrate the workings of functions in
% Matlab, particularly 
% - the existence of 'workspaces' ('reserved' 
%   parts of the memory which are separate from 
%   each other), and
% - the 'scope' of variables (=the workspace(s) in
%   which they can be seen)
% 
% simple.m has one input argument and one output
% argument. These input and output arguments are
% the vehicles of data transfer between the 'base'
% workspace and the workspaces of individual
% functions.
% 
% As the name suggests simple.m performs less than
% hair-raising computations: it generates a char
% array d which is not used for anything but 
% display in the command window. Next, the
% function computes the square root of the
% exponential of input argument x, using
% intermediate variable b. Finally, the result is
% placed in output argument y. 
% To follow the evolution of workspaces place a
% break point on the line beginning with 'd=..',
% call the function from the command line (with a
% numerical input argument) and have an eye on the
% tab in the command window termed 'Workspace'.

d=['In the workspace of ' mfilename ', ''d'' is a string']
b=exp(x);
y=sqrt(b);
