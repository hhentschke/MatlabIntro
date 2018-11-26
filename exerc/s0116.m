clear
load d01

%% The reliability aspect
% Count the finite negative values and zeroes in each column, sum them up
nBadYield=sum(isfinite(milk2) & milk2<=0);
% if we were super-correct, the line above should read..
nBadYield=sum(double(isfinite(milk2) & milk2<=0));
% ...because the expression isfinite(milk2) & milk2<=0 is a logical array,
% and 'sum' performs nothing less than an algebraic operation - and how do
% we know what e.g. 'yes' + 'yes' + 'no' results in? Fortunately, as noted
% before (s0114.m) the Matlab interpreter is clever enough to convert
% logical variables automatically to the double type, so we can afford
% imprecisions of this sort.

% Same with non-finite values (nans, inf)..
nInfinite=sum(~isfinite(milk2));
% ..and see where there is a minimum
[nBadDays,superCow]=min(nBadYield+nInfinite)

%% Mean daily output
mV=mean(milk2)
% This does not work: there are nan's and inf's in the array which spoil
% the computation; we have to get rid of them. Eliminating them in a
% 1d-array would be fine, but since milk2 is 2-dimensional, we cannot do it
% without changing the dimensions of the array. See exercise 1.5. The way
% proposed below is to first locate all problematic entries, evade them one
% way or the other and then to compute the mean.

% Locate all numbers different from nans and infs
logArr1=isfinite(milk2);
% Locate all numbers <= 10
logArr2=milk2<=10;
% Locate all numbers >=0
logArr3=milk2>=0;
% The first logical array is not really needed because neither nan nor 
% -inf nor inf are 'numbers' in the interval [0 10]. However, in general,
% it is good practice to test for finiteness of values. In tests checking 
% e.g. solely for an upper or lower boundary it is all too easy 
% to forget that infinity - a value easily sneaking into your data by
% unintended divisions by 0 - passes expressions like a>100.

% Combine the logical arrays
logArr=logArr1 & logArr2 & logArr3;

% We could have accomplished all of the above in a single line, which is
% shorter and maybe also more readable
logArr=(isfinite(milk2) & (milk2<=10) & (milk2>=0));

% Now, let's try the following: 
nix=mean(milk2(logArr));

% Disappointingly, the result is a scalar, not a 3-element array. Where is
% the problem? The problem is that
milk2(logArr)
% changes the dimension of milk2, moving all elements into a column array.
% This is Matlab's solution to a problematic request which, as prose, would
% read 'from array milk2 put all elements except a few here and there into
% a new array' Evidently, this array could not preserve the order of rows
% or columns, hence the unexpected outcome. A short illustration of the
% problem:
a=[1 2; 3 4; 5 6]
x=logical([1 1; 0 1; 0 1])
a(x)

% So, one solution is to compute the means column by column:
h1mn=mean(milk2(logArr(:,1),1));
h2mn=mean(milk2(logArr(:,2),2));
h3mn=mean(milk2(logArr(:,3),3));

% An alternative method of determining mean values using find:
[r,c]=find(isfinite(milk2) & (milk2<=10) & (milk2>=0));

% Note the use of logical indexing within
h1mn=mean(milk2(r(c==1),1))
h2mn=mean(milk2(r(c==2),2))
h3mn=mean(milk2(r(c==3),3))

%% Mean daily output: easier way 
% Congratulations if you made it to here, understood the problem(s) with
% the data and the solutions exposed above!
% In practice, computations of the means of columns in a matrix strewn with
% potentially bad values would make use of a significant shortcut at the
% end. However, still, there is no way around identifying values which
% according to the nature of the data are bad and setting them to NaN:
% - make a copy of milk2 here because the original will still be used below
milk2_clean=milk2;
% - identify the foul values and set them to nan. Note that although the
% lengthy expression below is a logical index to milk2_clean, the
% dimensions of milk2_clean are preserved because we do not extract the bad
% values into a new variable but instead replace them in the matrix
milk2_clean(~isfinite(milk2_clean) | milk2_clean>10 | milk2_clean<0)=nan;
% use a flavor of the mean function disregarding NaNs
meanVolume=nanmean(milk2_clean)
% or (better)
meanVolume=mean(milk2_clean,'omitnan')


%% Cow on the run
% Find the column where nan entries occur at least two times in a row. The
% strategy to do this (for each column of milk2):
% - find row indices into nan entries
% - differentiate the array containing these row indices 
%   (differentiate=compute next neighbour differences, see help diff)
% - wherever the difference is 1, two nans occurred in a row. Since there
%   is only one cow where that is the case it suffices to count the number
%   of times this is so in each column. This is accomplished by the
%   outermost length(find( .... ==1)). So, the result of one of the lines
%   below must be ~=0, the other two must be ==0
length(find(diff(find(isnan(milk2(:,1))))==1))
length(find(diff(find(isnan(milk2(:,2))))==1))
length(find(diff(find(isnan(milk2(:,3))))==1))

%% Outstanding performances
% Idea: use a threshold based on standard deviation as a criterion.
% Find all days on which the volume of milk given exceeded the mean +1.5
% standard deviations, using variable milk2_clean computed above.
% - the thresholds of the individuals:
threshold=mean(milk2_clean,'omitnan') + 1.5*std(milk2_clean,'omitnan');
% - sum entries:
% R2016b and above: make use of implicit array expansion in the use of
% logical operators
numSuperDays=sum(milk2_clean>threshold)
% earlier releases: have to use repmat
numSuperDays=sum(milk2_clean>repmat(threshold,[size(milk2_clean,1) 1]))
