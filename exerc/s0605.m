% --- preparatory work:
% the current computer's RAM in MB (approximate)
ram=8000;
% the array generated should occupy this fraction
% of the computer's ram
ramFrac=.3;
% so, a square double array should have approx.
% this number of rows/columns:
n=round(sqrt(ram*ramFrac*2^20/8));
% generate it
arr=ones(n);
% take a look at function copycheck
edit copycheck

%% matrix arr will just be read in copycheck
copycheck(arr,'read');
% observation: memory demand does not change, so
% obviously Matlab did not generate an additional
% copy in RAM

%% matrix arr will be read and modified in copycheck
copycheck(arr,'change');
% observation: an additional copy is temporarily
% generated in RAM, straining the ressources of
% the computer. In fact, if the array is too
% large, you will get an out of memory error here!

%% clear arr & generate GLOBAL version of it
clear arr;
% generate global variable ARR with the same
% content
global ARR
ARR=ones(n);

%% modify global variable in function copycheck
% observation: changing a value within a global
% variable does NOT result in an additional copy
copycheck(1,'globchange');

%% 
clear all

% ************************************************
% Ergo: If you need to access and change a very
% large variable within functions make this
% variable global - it is generally faster, and in
% extreme cases may allow computations which would
% not be possible with local variables due to lack
% of memory
% ************************************************
doc global