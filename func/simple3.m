function y=simple3(x)
% ** function y=simple3(x)
% simple3.m is one of a set of functions intended
% to demonstrate the workings of functions in
% Matlab, particularly 
% - the existence of 'workspaces' ('reserved' 
%   parts of the memory which are separate from 
%   each other), and
% - the 'scope' of variables (=the workspace(s) in
%   which they can be seen)
%
% simple3.m illustrates the nature of global
% variables. Before running it declare variable d
% global in the base workspace. Then, place a
% break point on the line below saying 'global d'.
% Call simple3.m from the command line (with a
% numerical input argument) and step through it,
% at all times having an eye on the functions's
% workspace and the value of d.

global d;

if isempty(d)
  disp('''d'' is empty');
elseif ischar(d)
  disp(['global variable ''d'' is the string ''' d '''']) ;
elseif isnumeric(d)
  disp(['global variable ''d'' is the number ' num2str(d)]) ;
else
  disp('''d'' is neither number nor char nor []');
end

% now set d to a string 
d='think global';

b=exp(x);
y=sqrt(b);
