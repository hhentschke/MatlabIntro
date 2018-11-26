% ------- unit 6: functions vs scripts

% demo09.m is a script: 
% - the commands in it can be evoked by typing 
%   the name of the script file on the command
%   line
% - it shares the same workspace as anything 
%   that is entered on the command line

edit simple
% 'simple.m' is a function:
% - in the first line the keyword 'function' occurs
% - the code in it can be evoked by typing the
%   name of the function file on the command line
% - input arguments can be given, output variables 
%   are usually produced
% - the block of commented text below the first 
%   line will be put out on screen if help for 
%   this function is invoked (this is the
%   so-called H1 'line'
% - *** it has a workspace of its own! ***

help simple
% locate the file
which simple
% any file/variable with the same name anywhere?
which simple -all

% **********************************************
% it is a very bad idea to give functions 
% names of functions that exist already
% **********************************************

% we know that variable names are cAsE SensitivE -
% are function names case sensitive, too?
which Simple

% **********************************************
% it is a very good idea to be consistent with 
% upper and lower case letters in function names
% **********************************************

% what if function name and file name are not 
% identical?
ernie
bert
edit ernie
% ************************************************
% nobody likes being taken for someone else - 
% Matlab functions don't, either 
% ************************************************


% mfilename returns the name of the m-file
% within which it is called. This m-file may
% be a function or a script like the one
% you're dealing with now
disp(['this string was proudly produced by: ' mfilename]);

% ---- m-files vs. 'built-in' code
edit dlmread;  % fine
edit reshape;  % not so fine
% trying to open built-in functions 'works' but is
% to no avail because the code is not in the
% m-file

%% ---- workspaces
% 'local' vs. persistent vs. global variables

edit simple
% place a breakpoint on the first line of simple..
% .. step through it and pay attention to 
%    variables in the workspace(s)
d=11;
simple(d)

%%
% now do the same thing with 'd' being declared 
% 'persistent' in function simple2
d=11;
% simple2.m is similar to simple.m 
% except for the line saying 'persistent d'
edit simple2
simple2(d)
whos d
% as before, variable 'd' has not changed outside 
% function simple2. What happens if we call 
% simple2 again?
simple2(d)
whos d
% So, as the term suggests, the value of 'd'
% really persists (in function simple2).

%%
% finally, repeat the simple business with 'd'
% being global (we have to clear it before
% declaring it global)
clear d;
global d;
% now, d can be accessed by all functions. So far,
% it is by default empty. Let's assign a vale to
% it
d=11;

% the major new thing in simple3.m is the line 
% saying 'global d'
edit simple3
simple3(d)
whos d
% now d is a char array because it had been 
% declared global in both the base workspace and
% the function workspace: any operation performed
% on it within 'simple3.m' will be permanent

%%
% once you don't need a global variable anymore,
% get rid of it via
clear global
% or that one
clear all

% What are global and persistent variables good
% for? 
% It may be advantageous making a variable global 
% if 
% 1. the exchange of variables between functions 
%    of a complex project is cumbersome (which may
%    be the case with graphical user interfaces)
% 2. it is a huge variable which will be modified 
%    in at least one function (see exercise 6.5)
% Persistent variables may be useful with
% graphical user interfaces for reasons to be
% explained later.
% 
% ************************************************
% NOTE: global and persistent variables should be
% used sparingly. Most Matlab code that is around
% can and should do without them: the whole point, 
% or at least one of the points of having
% functions is that they provide a means to
% compartmentalize your code. No matter how
% complicated the computations and how plentiful
% the variables inside it, once a function is done
% its workspace implodes, leaving us with freed
% memory to run the next task. Persistent and even
% more so global variables counteract this
% principle by sticking around all the time unless
% we delete them explicitly, thus taking up
% computer resources.
% ************************************************

% ---- subfunctions
edit tplot
load lfp
tplot(d,2000);
clf

% ---- nested functions
edit tplot_nested
load lfp
tplot_nested(d,2000);
clf

% ---- varargin,-out
% varargin
edit tplot2
% the same as before..
tplot2(d,2000)
clf
% now with ylabel
tplot2(d,2000,'\muV');

% varargout
edit moments
x=randn(100,1);
m1=moments(x)
[m1,m2,m3]=moments(x)

% a Matlab function where a variable number
% of output arguments makes sense 
help ind2sub


% ---- assignin, evalin
% there may be situations where you would like to
% incorporate some flexibility into your code in
% terms of the NAMES of variables generated. E.g.
% you may want to generate a variable whose name
% corresponds to a string stored in another 
% variable
load d03.mat
whos
spx
spx.name
% we would like to generate variable tsl_xxx, 
% where xxx shall correspond to the name of the 
% last channel (the last row in spx.name).
% Function assignin will let us do that
help assignin
% This is how we would construct the variable's 
% name:
['tsl_' deblank(spx.name(end,:))]
% That variable shall contain the time stamps of 
% the channel. So, 
assignin('base',['tsl_' deblank(spx.name(end,:))],...
  spx.data{end});
% voila variable tsl_001a
whos

% a word of caution: this method of generating
% variables is potentially confusing because the
% variable name does not occur explicitly in your
% code, so you cannot e.g. search for that
% variable. Use it sparingly.

% the evalin function is even more general than
% assignin: any string passed to it will be
% evaluated in a workspace of your choice
% ('caller' or 'base'). Let's see what that means.
clear all
edit pizza_service
edit call_pizza_service
% place a break point at the single command line
% in function call_pizza_service, run and step
% through it, at each step observing what's going
% on in each of the workspaces that unfold before
% you (which is best done by opening the workspace
% window)
call_pizza_service;
% evalin is a frequently used tool in code for
% graphical user interfaces