function sq(n)
% ** function sq(n)
% a simple function illustrating the use of function eval
for i=n
  eval(['s' int2str(i) '=i^2;']);
end
whos

