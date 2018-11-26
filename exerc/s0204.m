clear
clc
n=8000;

% mtable MUST NOT exist at this point
disp('** no preallocation:');
tic
for c=1:n
  for r=1:n
    % upon the first run, variable mtable is generated.
    % Whenever r is increased by 1 mtable expands; more 
    % precisely, the number of rows in mtable grows by 1.
    mtable(r,c)=r*c;
  end
end
toc
pause(.1)

% we could just leave the mtable computed above as it is
% (i.e. do nothing) or, more realistically in a real
% application (where you would hardly compute one and the
% same thing twice) pre-fabricate array mtable, overwriting
% its values generated above
disp('** variable mtable preallocated:');
mtable=zeros(n,n);
tic
for c=1:n
  for r=1:n
    % upon the first run, variable mtable is already
    % present. Whenever r is increased by 1 mtable does NOT
    % expand because it contains already the correct number
    % of rows and columns. The only thing that happens here
    % with mtable is that the element at row r and column c
    % is overwritten.
    mtable(r,c)=r*c;
  end
end
toc


% Pre-fabrication of arrays is termed 'preallocation' (of
% memory). Preallocation makes computation in loops faster
% because it frees matlab of the need to expand the size of
% the array (mtable in the example above) frequently. Think
% of your next dinner party: would you unseat the whole
% party, move the plates and stuff, lift the tablecloth,
% expand the table, etc. each time a guest arrives, or
% rather make up your mind from the start as to how many
% seats will be needed...?
%
% Ergo:
%
% **********************************************************
%  + When loop constructs (for,while) cannot be avoided
%    make them faster by preallocating variables written to
%    in the loop. Failure to preallocate large arrays is a 
%    TREMENDOUS WASTE OF COMPUTER RESOURCES!
% **********************************************************