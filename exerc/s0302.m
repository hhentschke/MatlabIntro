% The key to the solution (at least the one
% presented below) is to plot the three circles
% separately (=have three handles, one to each of
% them) so they can be individually changed if
% needed. Associate one of them with the prize
% using random numbers, get the mouse input, find
% circle nearest to mouse pointer and paint that
% circle green or display text

% plot circles at x positions 1, 2 and 3 and at
% height (y value) 1
cxpos=[1 2 3];
figure(1), clf
hold on
h1=plot(cxpos(1),1,'o');
h2=plot(cxpos(2),1,'o');
h3=plot(cxpos(3),1,'o');

set([h1 h2 h3],'markersize',60);
set(gca,'xlim',[0 4]);

% the association with the prize: generate three
% random numbers and identify the index to the
% largest number. That shall be the index to the
% winning door
[m,prix]=max(rand(1,3));

% now get the mouse input..
[x,y]=ginput(1);
% and determine to which circle's center the mouse
% click was closest (since the circles are aligned
% in a row we need not care about the y
% coordinate) 
[d,mcix]=min(abs(x-cxpos));

if mcix==prix
  switch mcix
    case 1
      set(h1,'markerfacecolor','g');
    case 2
      set(h2,'markerfacecolor','g');
    case 3
      set(h3,'markerfacecolor','g');
  end
else
  text(1,1,'GAME OVER','fontsize',20,'fontweight','bold','color','r');
end

% What is this exercise good for?
% 1. there may be situations where you would like
% to have a subset of points in a plot in a
% specific color (e.g. because they are outliers,
% significantly different, etc.) - now you know
% how to accomplish this
% 2. the ginput function may be useful if some
% interactive data analysis is required (e.g.
% manually picking out individual data traces
% among a whole set displayed in a plot). 
