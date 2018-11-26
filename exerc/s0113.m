stripes=repmat([zeros(1,10) ones(1,10)],80,4);
% the most elegant way of solving task 1.4 makes use of the logical data type
spy(xor(stripes,rot90(stripes)))
