% entering the numbers, let's create variable x:
x=[2 3 9 3 8 0 1]
% equivalent: x=[2,3,9,3,8,0,1] NOT equivalent:
% x=[2;3;9;3;8;0;1]

% the sum:
sum_x=sum(x);

% the mean:
mean_x=sum_x/numel(x)
% equivalent and shorter:
mean_x=mean(x)

% transposing arrays is one of the most important
% and short commands in Matlab:
x=x'
% note that we can 're-use' variable name x 

% generating a copy in the neighboring right
% column: there are (at least) three ways to do
% that. Number one..
xx=[x x]
% ..two (which is essentially the same command,
% namely a 'concatenation')..
xx=cat(2,x,x)
% ..and three
xx=repmat(x,1,2)

% subtract the mean, but only from the new column:
xx(:,2)=xx(:,2)-mean_x

% the plot:
plot(xx(:,2))
xlabel('day')
ylabel('hours of sunshine')

% repeating steps 7 and 8, computing the median
% instead of the mean:
xx_2=[x x]
% note that here we compute the median 'on the
% fly', without assigning an extra variable to it.
% this is one of the essences of Matlab: you may
% combine as many commands or nest them into each
% other as you like 
xx_2(:,2)=xx_2(:,2)-median(x)

% place new variable xx_2 'behind' old
% variable xx, thus generating a 3D array:
% now we have to use the 'cat' command
quadruple_x=cat(3,xx,xx_2)
% note that 3D variables are not (easily)
% generated in spreadsheets

% generating one million copies of the
% median-subtracted column:
bigX=repmat(xx_2(:,2),1e6,1);
% note: 
% - 1e6 is short for 1000000, it means 'one times
% ten to the power of 6' 
% - this operation results in an array of 7
% million numbers, occupying ~56 MB of workspace.
% 56 MB is not that much, but dealing with large
% numbers of numbers is awkward or impossible in
% spreadsheets because they are simply not made
% for that. In Matlab, there are also limitations
% as to the size of variables, but they are much
% higher than those of typical spreadsheets


