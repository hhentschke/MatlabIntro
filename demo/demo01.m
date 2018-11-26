% ----- unit 1a: manipulation of arrays & simple 
%                arithmetic operations

% as a warm-up, let's start with a few of the most 
% elementary things that can be done in Matlab:
% entering data, thereby creating variables, and
% performing simple computations on them:
% this command creates variable n with value 3 in
% the workspace
n=3
% the decimal sign is '.':
n=3.5
% by default, Matlab displays the value of the new
% variable on the command screen. In order to
% suppress this, use the semicolon
m=5;
m
% (in much of the following code the semicolon is
% omitted deliberately for demonstration purposes)
% simple numeric operations:
k=n+m
k=n*m
m=k-n
n=k/n
% the equal sign is an assignment: 
% - on the left hand side is a variable name (a
% new one or one which exists already)
% - on the right hand side we may have
%  -- numbers
%  -- combinations/modifications/etc. of variables
%     already in existence
%  -- data generating expressions

% the usual rules of associativity, commutativity
% etc. apply:
m=1+2*3
n=(1+2)*3

% and of course, elementary mathematical functions
% (plus myriads of others) are built into Matlab:
k=exp(1)
m=sqrt(144)

% let's 'glue' some numbers into arrays:
m=[1 2 3]
% in case we prefer to have the numbers arranged
% in columns, this is one way to do it:
m=[1; 2; 3]

% we can also perform operations between arrays
% and single numbers:
n=m*2
n=m/77

% however, operations between arrays/matrices are
% more complicated - we will get to this topic in
% demo02 

% ************************************************
%  So much for the very first steps. The
% remainder of this script demonstrates array
% manipulation and arithmetic operations on a
% somewhat larger scale, detailing the elementary
% steps of a simple task: loading data, 'shaping'
% (scaling, rearranging, etc.) and plotting them
% ***********************************************

% clear the workspace
clear
% load file
load d02.mat
% what variables have we loaded from the file into 
% the workspace?
who
% plot d
plot(d)
%...does not lead to desired result. Why?
whos
% ...because variable d does not have the correct
% orientation (number of rows & columns). Let's
% explore different ways of finding out about the
% size of variables
size(d)
size(d,1)
size(d,2)
% notice the assignment: we create two new
% variables, r and c, and assign values to them
% (the number of rows and columns, respectively,
% of variable d)
[r,c]=size(d)
numel(d)
length(d)

% ok, let's rotate d and plot again
% in matlab, a variable may be used on either side 
% of '='
d=rot90(d);
whos
length(d)
length(d(:,1))
plot(d)
% rotated the wrong way 
% if we think about it, rotating the array is not
% what we wanted to do anyways; we should have
% transposed it (exchanged rows and columns)
% so, load variable d again (which overwrites the
% present, mis-transformed version) and transpose
% it 
load d02.mat
whos
d=d';
plot(d)
% on the occasion, transposing is the same as
% rotating counterclockwise and then flipping
% upside down
load d02.mat
whos
d=flipud(rot90(d));
plot(d)

% we want to deal only with the first 2 channels
d=d(:,[1 2]);
% alternative: d(:,[3 4])=[];
plot(d)

% the first channel has a much larger amplitude
% than the other, so let's downscale it
d(:,1)=d(:,1)*0.25;
plot(d)

% add an offset of 1000 to channel 1
offset=1000;
d(:,1)=d(:,1)+offset;
plot(d)

% 'zoom in' on the spindle-like activity
d=d(1001:3500,:);
plot(d)

% 'downsample' d
whos d
d=d(1:2:end,:);
whos d
plot(d)

% let's plot the base line for each of the two
% channels 
% after downsampling, r has to be recalculated
r=size(d,1)

baseline=[zeros(r,1) , repmat(1000,r,1)];
hold on
plot(baseline,'k')
hold off

% now, for a different kind of plot of the
% excerpts: side by side
% so, concatenate the columns vertically
dcat=reshape(d,2*r,1);
% open new figure window
figure(2),
plot(dcat)
% we forgot that we added an offset to the 
% first excerpt, so let's subtract it again
% and also intersperse some "Not A Number"s 
% between the excerpts so they appear separate
% in the plot
dcat=[d(:,1)-offset; nan(200,1); d(:,2)];
plot(dcat)
axis tight