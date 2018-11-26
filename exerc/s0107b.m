% task: multiplication table up to n=10;
n=10;

% step by step
% 1. generate matrix tmp, an n by n matrix the lines of which look like 1 2 3 ..n
tmp1=repmat(1:n,n,1);
% 2. generate a clockwise rotated copy of this matrix 
tmp2=rot90(tmp1,-1);
% tmp2=repmat((1:n)',1,n); % would lead to the same result

% multiply matrices ELEMENT BY ELEMENT (mark the dot)
tmp1.*tmp2