% ** Which code is fastest? ** 
% a case structure illustrating different
% execution speeds of exemplary 'code'
% (!script has to be run as a whole!)

% compute 40 million values
n=40000000;
x=1:n;
% pre-generate variable a 
a=zeros(size(x));

algor='for'
algor='while'
algor='vectorized'

tic
switch algor
  case 'for'
    for i=1:n
      a(i)=sqrt(x(i));
    end
  case 'while'
    i=1;
    while i<=n
      a(i)=sqrt(x(i));
      i=i+1;
    end
  case 'vectorized'
    a=sqrt(x);
end
toc

% Observations:

% 1. The vectorized code executes fastest. The
% difference to the loops is about an order of
% magnitude. However, if loop computations involve
% no function calls and deal only with simple
% scalar operations, the difference in execution
% time between vectorized code and loops fades
% into insignificance in modern Matlab versions.
% More information on the topic of vectorization
% is to be found at (as of April 2018)
% http://de.mathworks.com/help/matlab/matlab_prog/vectorization.html 
% (If the page moved, search the MathWorks sites
% for 'Vectorization Guide') 

% 2. The while and for loops are about equally
% fast, the exact results depending on the type of
% computer, among other things. As the while loop
% has one more code line (i=i+1;) and does a
% comparison (i<=n) at each loop run it is in most
% cases a trifle slower. Also, it is the more
% complicated construct. So, if the number of loop
% runs is known beforehand, use for loops.