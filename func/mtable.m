function mt=mtable(n)
% ** function mt=mtable(n) generates multiplication
% table of all integers from 1 up to n
if n<=0
  warning('n is negative or zero - setting to 1');
  n=1;
end
mt=(1:n)'*(1:n);

