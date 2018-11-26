% Task: multiplication table up to n=10;
n=10;

% i. An intuitive solution making use of
% transposition and the .* operator (element-wise
% multiplication)
m=repmat(1:n,n,1);
mtable=m.*m'
% In Matlab R2016b and up, due to automatic array
% expansion in arithmetics we don't even need
% repmat:
mtable=(1:n)'.*(1:n)

% The two solutions presented below are based on
% MATRIX multiplication: 

% ii. The most elegant way
mtable=(1:n)'*(1:n)

% iii. A more roundabout way making use of a matrix with the
% integers of 1 to n along its main diagonal and zeroes in
% other positions
mtable=repmat((1:n)',1,n)*diag(1:n)
% or
mtable=repmat(rot90(1:n,-1),1,n)*diag(1:n)
% Note: (1:n)' is shorter than rot90((1:n),-1) which does
% the same (1:n is a row vector and the transposition of a
% row vector is equal to its clockwise rotation). Be aware
% that this does not hold for column vectors and matrices! 

% **********************************************
% Even if this is redundant, in face of the
% changes in Matlab R2016b it is important to
% emphasize again the difference between the code
% lines above involving a row and a column vector:

% i. Matlab here first AUTOMATICALLY EXPANDS both
% vectors to 10 by 10 arrays and then does
% ELEMENT-WISE MULTIPLICATION (R2016b and up) or
% issues an error (prior releases)
mtable=(1:n)'.*(1:n);

% ii. MATRIX MULTIPLICATION 
% Remember that the product C of two matrices A
% and B, C=A*B, is defined by
% C(i,k) = <sum over j> A(i,j)*B(j,k)
mtable=(1:n)'*(1:n);
% Due to its conciseness and the fact that it
% works with all Releases this is the best
% solution
% **********************************************