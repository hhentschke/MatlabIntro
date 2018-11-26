function res=isschnapszahl(a)
% ** function res=isschnapszahl(a)
% returns logical 1 if number a is of the sort 777 or 1111 
% (integer with repetitions of a single digit, max 15 digits)

% The main task here is to create a function returning a logical variable.

% check whether a is an integer or not
if a==fix(a)
  % convert to character array. This would be one solution:
  % s=num2str(a);
  % however, sprintf is better to convert the number into a string 
  % of precisely controlled format:
  s=sprintf('%-15.0f',a);
  % get rid of blanks (whitespace, the invisible character)
  s=deblank(s);
  if length(s)>15
    error('input argument ''a'' must have no more than 15 digits')
  end
  % see whether the first character (element) in string s is found as 
  % many times as the string has elements
  res=length(strfind(s,s(1)))==length(s);
else
  res=false;
end