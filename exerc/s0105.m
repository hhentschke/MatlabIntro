clear
load d01

% try to delete the upper right corner..
a1(1:2,end-1:end)=[];
% .. does not work
% In an array, you can delete whole rows or columns, but not
% subsets of rows or columns unless you accept a 'reshaped'
% result. Let's explore the possibilities. If you want to
% get rid of the upper right corner, you may (depending on
% what you mean by 'getting rid of')

% 1. replace the elements by e.g. NaN (Not a Number, a very
% useful non-number)..
a1(1:2,end-1:end)=nan;

% 2. break down the array into subarrays..
a1_sub1=a1(1:2,1:end-2);
a1_sub2=a1(3:end,:);

% 3. delete the rows and/or columns associated with the
% corner (resulting of course in the loss of more than just
% the 4 upper right corner elements)..
a1(1:2,:)=[];

% or, finally, 4. really eliminate only the elements from
% the array and have the remainder of the array in a
% single-column array. The line below displays a reshaped
% version of array a1 on the screen: the columns are orderly
% concatenated
load d01
a1(:)
% we see that the original corner corresponds to elements in
% position 25, 26, 31 and 32. So, let's make a new variable
% and eliminate these elements
a1_new=a1(:)
a1_new([25 26 31 32])=[]
% an alternative way, making use of set operation function
% 'setdiff' (and our knowledge of the number of elements in
% a1):
a1_new=a1(:)
a1_new=a1(setdiff(1:numel(a1),[25 26 31 32]))
% note that this results in a ROW vector

% if, at this stage, you are a perfectionist, you will want
% to generalize the task of identifying the upper right
% corner (in the same sense defined so far) to 2D arrays of
% any size. Function sub2ind gives you a hand. We need to
% know the size of a1 first.
[r,c]=size(a1);
% ix contains the LINEAR index into a1 for the four elements
% we're after
ix=sub2ind([r c],[1 2 1 2],[c-1 c-1 c c])
% there is also function ind2sub, which will convert linear
% indexes back into multiple subscripts