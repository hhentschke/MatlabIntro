% Matlab is short for Matrix Laboratory.
% Accordingly, Matlab has a large inventory of
% functions dealing with matrices, among them
% solvers of systems of linear equations. 
% Consider this:
%
% "Dad is ten times as old as his son Paul. 
% Paul's and Dad's ages combined and divided by two is 22.
% Can you find out their ages?"
% 
% This is a problem of the form
%   Ax=b
% where x is a 2 by 1 vector of the unknown
% variables (dad's age, Paul's age). Concretely, 
A=[1 -10; .5 .5]
b=[0; 22]

% There are several ways of solving
% such systems of linear equations. The most
% succint version makes use of matrix left divide
% (mldivide):
A\b

% which informs us that dad is aged 40 and Paul is
% 4.
% mldivide will return a least-squares solution in
% 'overdetermined systems', a fact we can exploit
% for linear regression (see demo11).