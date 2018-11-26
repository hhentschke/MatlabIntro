% expression 1: x=x(x)
% some examples
[1 2 3 4]
[1 1 1 1]
[2 2 2 2]
[3 3 3 3]
[4 4 4 4]
[1 2 2 1]
[1 3 3 1]
[4 2 2 4]
[4 3 3 4]
[1 2 1 2]
[1 4 1 4]
[3 2 3 2]
[3 4 3 4]
[2 2 4 4]
[1 1 3 3]
% -----------------------------------------------------------------------------
% just for entertainment, here is a possibility to generate all solutions
[i1 i2 i3 i4]=ind2sub([4 4 4 4],1:4^4);
x=[i1' i2' i3' i4'];
% we have to do the comparison line by line;
% sth like x==x(x) will not lead to success
for i=1:size(x,1)
  ind(i)=i*all(x(i,:)==x(i,x(i,:)));
end
x(ind(find(ind)),:)
% -----------------------------------------------------------------------------

% expression 2: x=x(logical(x))
% if any 4-element-array with nonzero entries will do, like 
[12 0.1 -2 pi];
% in theory there are infinitely many, in practice this number is limited by 
% the limited representation of numbers in computers (which is still quite many)

% expression 3: x=x(~x)
[0 0 0 0];

% expression 4: x=logical(x)
% combinations of LOGICAL zeroes and ones pass the test:
logical([1 1 1 1])
logical([0 1 1 1])
% .... etc.


% expression 5: x=~x
% no solution exists
% (While 'to be or not to be' is a philosophical question, to be AND not to be 
% is a computational impossibility)

% Note that the standard empty matrix passes all expressions:
[]
% However, this is really a pathological case; also, it is not a valid solution
% because 4-element arrays were requested
