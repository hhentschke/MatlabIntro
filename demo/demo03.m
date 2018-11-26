% ----- unit 1b: logical arrays

% a deep philosophical question: is 1 and 1 
% really 2?
1+1=2
% this is not the way to put it in matlab, 
% because:

% ************************************************
% =  is an assignment                            *
% == is a statement (which may be true or false) *
% ************************************************

1+1==2
% the answer is a logical array
answer=(1+1==2)
whos 

% there are exactly two values a logical variable
% can have:
a=true
b=false
% which is identical to
a=logical(1)
b=logical(0)

% on to not-so-obvious questions: 
% which is bigger for fixed n & varying x, 
% x^n or n^x?
n=5;
x=100;
x^n > n^x

% which of some random numbers uniformly 
% distributed in the interval [0 1] are above a 
% certain threshold?
a=rand(10,3)
b=a>0.75
spy(b)

% we can manipulate, reshape, rotate etc. logical 
% arrays in the same way as double arrays (for
% visualization using spy let's make a somewhat
% bigger logical array)
a=rand(50);
b=a>0.75;
% this fills the upper left corner with logical
% ones
b(1:10,1:10)=true;
whos b
% the lines between the for and end are executed 
% repeatedly (see unit 2)
for i=1:5
  b=rot90(b);
  spy(b)
  pause(1)
end

% matlab will convert doubles to logicals in 
% assignments like this one
b(1:10,1:10)=133214;
whos b
% watch out, the == operator does not care about 
% data types
true==1

% what if some kind of arithmetics is performed 
% on a logical?
b=b/4;
% now b is double
whos b


% Q: what are logical arrays good for?
% A1: if they come as scalars, for decisions/flow
% control
% for example, the 'if' statement expects a
% logical scalar (see unit 2)
if b(1,1)<1
  disp('the first element of variable b is smaller than one');
end

% A2: as an indexing tool into arrays
a=[123 0.89 -4];
b=logical([0 1 1]);
% the line below means: 
% 'Q: take elements 1,2,3 from a? A: no, yes, yes'
a(b)

% as soon as we mess with a logical variable in
% ways that change its type we are very likely in
% trouble
b=b*3;
a(b)

% other relational and logical operators: 
help relop

% functions returning logical data type:
a=[0 1 nan -22 inf 9 -inf]
isnan(a)
isfinite(a)
isinf(a)
% it may be important to know what exactly matlab 
% defines as (in)finite:
% i) besides positive infinity there is also 
% negative infinity
isinf(a)
% ii) NaN is, by definition, neither finite nor 
% infinite
isfinite(a)
% why are inf and -inf such a big deal? 
% because e.g. divisions by zero may creep into  
% your code inadvertently
bigNumber=123/0
anotherBigNumber=123/-0

% note that the functions above may put out
% logical arrays whereas isempty always puts out a
% SCALAR logical (i.e., a single logical 1 or 0)
isempty(a)

% a propos isempty: 
% +++++ a short interlude concerning the size 
% of variables +++++
% the combination of the two lines below generates 
% a variable of size 1 by 0
e=44;
e(1)=[]
size(e)
% which is different from this 
e=44;
e=[]
size(e)
% still, e seemingly has a third dimension..
[n1,n2,n3]=size(e)
% therefore, when checking whether a variable is
% empty or not, refrain from relying on the output
% of size...
if n3>0
  disp('e contains something')
end
% and instead use 
isempty(e)
% or
numel(e)
% ++++++++ end of interlude ++++++++++++++++++

% our variable a again
a=[0 1 nan -22 inf 9 -inf]
% using logical operators to identify elements 
% which fulfill more than one condition
a<0 | a>4
a<0 & isfinite(a)

% the function find - a useful tool in conjunction
% with relational/logical operators and is* 
% functions
d=[1  0 -7 2;...
   0 -2 -9 8;...
   6  1 12 1]

% output: a logical array the same size as d
d<0

% output: two column vectors representing row and 
% column indexes into array d to elements smaller 
% than 0
[r,c]=find(d<0)

% now we can use variable r to delete all rows in
% which there are negative elements
d(unique(r),:)=[];
% same with columns: d(:,unique(c))=[];

% note the 'unique' function: both r and c contain
% repetitive values, which the unique function
% gets rid of
% also note that the find function has many
% different syntax variants - look up the help for
% it

% ---- set operations
% set operations are very useful for indexing 
% arrays: let's grow 16 flowers...
flowerLen=rand(4)
flowerRedness=rand(4)
flowerpower(flowerLen,flowerRedness);

% ..and pick only those fulfilling two criteria:
% this is the linear index to all flowers which 
% are at least 3/4 meters tall
ind1=find(flowerLen>0.75)

% linear index to all flowers whose red component
% is at least 0.6
ind2=find(flowerRedness>=0.6)

% linear index to all flowers fulfilling BOTH 
% conditions
ind=intersect(ind1,ind2)

% linear index to all flowers fulfilling EITHER 
% condition or BOTH
ind=union(ind1,ind2)

% the black beauties: linear index to all tall 
% flowers which are not particularly red
ind=setdiff(ind1,ind2)

% for converting the linear indexes back to row
% and column indexes use function ind2sub:
[r,c]=ind2sub(size(flowerLen),ind)