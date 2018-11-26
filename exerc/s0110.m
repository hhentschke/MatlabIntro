% The differences in data type make all the difference:
% Array x is of type double. If it is used as an index into array a,
% the assignment
%     b=a(x)
% translates into 
%     'in array a, look at elements at position 1, position 0, 
%     and again position 1 and place copies of them, in this order, 
%     into array b'
% This leads to an error because in matlab (as opposed to C, for example)
% the elements in arrays have positive, nonzero indices (1,2,3,...) - there
% is never an element at position 0 (or -1 and so on)
%
% By contrast, y is a logical variable. A single logical number in matlab is
% either 1 or 0, nothing else. However, we're not talking about quantities here; 
% in a sense, logical 1 and logical 0 represent 'yes' and 'no', respectively.
% If a logical array is used as an index into another array, the zeroes and ones 
% determine whether the numbers in the latter shall or shall not be fished out. 
% For example, 
%      c=a(logical([0 1])) 
% may be translated as 
%      'c shall be not the first, but, yes, the second element of a'
% 
% Thus, the expression
%     b=a(y)
% is interpreted as
%     'for each number in array a, see wether the element at the 
%     corresponding position in y is nonzero; if that is so, copy 
%     that number from a and append it to b, otherwise do nothing'
% which is perfectly OK given the sizes of a and y.

% A historical note: 
% Logical variables are in essence boolean variables and in matlab need 1 byte 
% of memory per number (although 1 bit should suffice). That had not always 
% been so. In versions 6.0 and below (or was it 6.1?) logical numbers were 
% allowed to have the same numerical values as doubles (sth. like 
%     c=logical([99 0]) 
% would leave you with logical array [99 0]) and, for that matter, took up 
% the same amount of memory, namely 8 bytes per number. Good that they fixed it!

