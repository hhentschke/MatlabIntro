% read image file (the \mcourse\data directory must be on the path
d=imread('littletown.jpg');
% open up a figure, visualize the image
figure(1)
image(d);
% this command ensures proper aspect ratio 
axis image

% let's take a look at d:
whos d
% aha, it's 796 by 1085 by 3

% so, let's exchange the red and green layers: this is the easiest way to 
% do it
d2=d(:,:,[2 1 3]);
figure(2)
image(d2);
axis image

% the funny (furry) animal is in the lower left corner. Easy:
% - first way
figure(1)
axis([50 240 580 796]);
% alternative (a little cumbersome here, but
% useful in cases in which only one axis shall be
% scaled):
set(gca,'xlim',[50 240],'ylim',[580 796]);
% - second way
d3=d(580:end,50:240,:);
figure(3)
image(d3);
axis image

% in the excerpt just created, the nose is centered on coordinate [62 58].
% To 'paint intensely red' means to set the values in the red (first) layer
% to maximal values and those in the green and blue layers to minimal
% values. Here is the step-by-step version:
d3(58:66,54:62,1)=255;
d3(58:66,54:62,2)=0;
d3(58:66,54:62,3)=0;
image(d3);
axis image

% let's re-create original excerpt to demonstrate...
d3=d(580:end,50:240,:);

% ...an equivalent, shorter, more elegant, but also more difficult way:
d3(58:66,54:62,:)=cat(3,255*ones(9,9),zeros([9 9 2]));
image(d3);
axis image
