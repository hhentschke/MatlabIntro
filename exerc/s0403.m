clear
clc
n=2000;

% mtable does not exist at this point
disp('** no preallocation:');
tic
for c=1:n
  for r=1:n
    mtable{r,c}=r*c;
  end
end
toc

% pre-fabricate cell array mtable 
disp('** cell array mtable preallocated:');
mtable=cell(n,n);
tic
for c=1:n
  for r=1:n
    mtable{r,c}=r*c;
  end
end
toc

% Preallocation of cell arrays is worth the effort
% (again, depending on a number of factors,
% including Matlab version, computer, size of
% variables, etc.), but not as efficient as
% preallocation of regular arrays because before
% each cell is actually filled with a value there
% is no way matlab can find out about the size
% (not even the type) of the variable put into the
% cell. Consequently, not all the memory needed to
% hold each cell's content is allocated upon a
% line like
%         mtable=cell(n,n);
% but just the 'skeleton' of the cell (with 4
% bytes per cell).
%
% Usage of a cell array in this particular task is
% not helpful: it takes up much more memory, it is
% slower, and we gain nothing from the flexibility
% of cell arrays as compared to an array.