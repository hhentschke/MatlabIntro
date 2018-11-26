stripes=repmat([zeros(1,10) ones(1,10)],80,4);
% subtract a rotated version of stripes from stripes itself
spy(stripes-rot90(stripes));