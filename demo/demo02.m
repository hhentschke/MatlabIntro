% ------ roundup of & addition to demo01/unit 1a

% 1. The dual/multiple uses of :;
a=magic(3)
% : means 'take all rows as there are' in 
% expressions like
a(:,1)
% : here means 'generate integers in increments 
% of 1'
10:18
% or in any increment you want
10:3.2:18
% ; at the end of a assignment prevents the result
% from being displayed on the screen 
a=zeros(100,30);
% whereas in square brackets it means stacking 
% things (putting the second below the first, etc.)
a=[1;2]


% 2. Ways to generate arrays by concatenating 
% numbers
1:3
% The same, but brackets are not needed here
(1:3)
% Ditto, ditto
[1:3]
% The same, and here the brackets are definitely 
% needed
[1 2 3] 
% The same, but the commas are not needed
[1,2,3] 
% NOT the same
[1;2;3] 
% Does not work
(1 2 3) 
% Does not work either
(1,2,3) 
% Nor this
(1;2;3) 


% 3. Ways of accessing arrays
a=[1 2 3;4 5 6;7 8 9]
% The usual method of accessing specific elements:
% via subscripts, that is, by specifying row and
% column indices
a(3,2)
% We can achieve exactly the same by using a
% so-called linear (or single) index:
a(6)
% However, note that linear indexing will not heed
% the original architecture of the array,
% returning a row array. As an example let's pick
% the middle column of array a. First, the
% subscript version:
a(1:3,2)
% The linear indices of the elements in the middle
% column are 4, 5 and 6 
a(4:6)
% Now look at that:
a((4:6)')
% So, when you use linear indexing, the dimension
% of the indexing array counts. Accessing all
% elements via linear indexing puts them in a
% column array
a(:)
% Question: can we use a 2d-array for accessing an
% array??
a([1 3; 2 1],:)
% Answer: yes, but a 1d-array would have sufficed
% - here, the result does not depend on the
% dimensionality of the index array; the line
% below does the same
a([1 2 3 1],:)

% Big question at this point: what do we need
% these myriad and confusing ways of accessing
% arrays for? Answer: in most cases, you will
% probably use subscripts for accessing arrays
% because this is the most intuitive way of doing
% it. However, it is important to know that the
% flexibility of indexing in Matlab is a potential
% source of bugs that are hard to track. Imagine
% somewhere in a piece of code you inadvertently
% use a 2-dim array for accessing portions of
% another array where in fact you should have used
% a 1-dim one. The output of that operation will
% most likely not correspond to what you wanted to
% get, but Matlab does not produce an error! So,
% checking indices to arrays is always a good
% starting point when debugging.


% 4. Ways of manipulating the shape of arrays 
% The transpose operator (2d only) = exchange row
% and column index
a=magic(4)
a'
% Figuratively speaking, you are flipping the
% array along one of its diagonals. The same:
% rotating 90 degrees counterclockwise & flipping
% up/down
flipud(rot90(a))


% 5. Automatic expansion of arrays
d=[1 22 3 -5 6]
% This will result in an error because the 10th
% element does not exist
d(10)
% In an assignment, however, setting the value of
% an element that does not exist yet is fine:
% Matlab will fill the missing values with zeroes
d(10)=12
% Yet, this is illegal...
d(11:13)=[8 7 11 12]
% ...because the number of elements on the right
% and left hand side of the assignment don't match


% 6. Scalar vs matrix operations
% Consider a small 2 by 2 matrix (the three dots
% are a 'line break' for code)
m=[1 2;...
  3 4]
% Not being familiar with all Matlab operators we
% may assume that the multiplication of m with
% itself will result in the elementwise products,
% that is, the squares of numbers 1, 2, 3 and 4:
%          [1  4;
%           9 16]
% Let's see:
m*m
% or 
m^2
% Obviously, this is not so!
% A dot (.) makes all the difference in operators
%         ^ * / \
% We obtain the sqares of the elements in matrix m 
% via
m.*m
% or
m.^2
% Here is why: the operators ^ * by default
% perform MATRIX MULTIPLICATION! Consider
%         C=A*B
% if both A and B are matrices, the elements of
% new matrix C will be computed according to
%       Cik=[sum over j] Aij*Bjk
% (Does not sound familiar? Pick any book on
% linear algebra, or look up the Matlab help for
% the division or multiplication operators (/ and
% *, respectively) for more information).
% So, this results in a single number (termed the
% inner or dot product of two vectors):
[10 11]*[1; 2]
% And this is a 2 by 2 array
[1; 2]*[10 11]
% Once again: for elementwise products etc. use
% operators .* etc. For example:
[1 2].*[5 3]
% However, be aware that the dimensions of the
% arrays and/or the number of elements in them
% must match:
[1 2].*[5 3 7]
% results in an error because the number of
% elements differ.

% ***********************************************
% ************** ATTENTION PLEASE ***************
% ***********************************************
% By a similar reasoning, 
[1 2].*[5 3 7]'
% should also result in an error because the
% number of elements differ and, even worse, the
% dimensions don't match (1 by 2 array multiplied
% by a 3 by 1 array). And indeed, in Matlab
% versions up to R2016a this results in the error
% message
%       Error using  .* 
%       Matrix dimensions must agree.
% However, starting in Release 2016b, the rules
% changed. In cases like the one above, Matlab
% automatically expands the arrays. The pros and
% cons of this "implicit expansion behavior of
% Matlab arithmetic operators" have been discussed
% extensively within The Mathworks and by the user
% community (if you're curious, see e.g. 
% http://blogs.mathworks.com/loren/2016/10/24/matlab-arithmetic-expands-in-r2016b/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+mathworks%2Floren+%28Loren+on+the+Art+of+MATLAB%29
%
% The disadvantages are:
% - one more rule to keep in mind, or one more
% potential pitfall when developing code
% - danger of silent bugs in old code (for an
% enlightening account of such an instance, see 
% http://undocumentedmatlab.com/blog/afterthoughts-on-implicit-expansion#more-6750
%
% The advantage is that routine programming chores
% like e.g. subtracting the means of the columns
% of an array can now be accomplished much more
% succinctly and, according to The Mathworks, at
% least as efficiently as with the techniques that
% had to be used previously (repmat, bsxfun).
% ***********************************************
% ***********************************************

% 7. n-dimensional arrays
a=magic(4)
b=a+2
% array c shall contain arrays a and b in its
% 'slices'
c=a
c(:,:,2)=b
% the same:
c=cat(3,a,b)
% as in 1 or 2 dimensions, specifying the value of
% an element in an nd-array may expand the size &
% dimension of the array 
d(2,1,1,2)=99
% there are numerous ways to change the shape of
% 3D (and higher-dimensional) arrys. Here is one
% useful function:
d=flip(c,1)
