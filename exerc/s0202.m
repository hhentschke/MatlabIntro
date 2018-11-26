clear 
load d01.mat
a1=a1+1;
try 
  % try to save on read-only or nonexistent drive
  save v:\tmp.mat
catch MExc
  save tmp.mat
  warning('Could not save to destined directory - saved file in local directory');
  disp('The following problem occurred:')
  disp(MExc.message);
  % an alternative to the lines after save tmp.mat would be 
  %   rethrow(MExc);
  % which 'reissues' the error after critical steps (saving the data in the
  % current directory) have been performed. However, if you want to keep
  % code running, just display the error message.
end

% This exercise depicts one of the cases in which the try catch statement
% is a useful construct: some operation shall be carried out; anticipating
% the outcome is impossible or very cumbersome, and failure of the
% operation results in an error. The pitfall alluded to here is the
% existence of a directory which cannot be written to. Other pitfalls are
% thinkable: temporarily unavailable network directories, unavailability of
% a specific Matlab toolbox in an environment different from the one where
% the code had been developed, etc. 
% Also see exercise 2.6.


  