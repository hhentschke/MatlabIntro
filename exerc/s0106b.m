clear
load d01
spy(a2)
% you may copy & paste the lines below into the workspace
% and execute them repeatedly 

% to do things step by step let's first determine the size of a2
[rows,cols]=size(a2);
% put the original lower left corner in a temporary variable lole
lole=a2(rows-9:rows,1:10);
% put the original lower right corner in a temporary variable lori
lori=a2(rows-9:rows,cols-9:cols);
% put lole in lower right corner of a2..
a2(rows-9:rows,cols-9:cols)=lole;
% ..and lori in lower left corner of a2.
a2(rows-9:rows,1:10)=lori;

% clockwise rotation:
a2=rot90(a2,-1);
spy(a2);
