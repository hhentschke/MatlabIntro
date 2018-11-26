% ---------- unit 3: graphics ----------------

% ************************************************
% PLEASE NOTE: 
% Graphics in Matlab has been overhauled in
% Release 2014b. The code in this script
% highlights only some of the differences between
% releases pre- and post-2014b. For detailed
% information on the changes, see
% http://de.mathworks.com/help/matlab/graphics-changes-in-r2014b.html
% ************************************************

% let's plot a few curves:
% x values
x=0:.1:10;
% curve 1: square root
y1=sqrt(x);
% curve 2: sine
y2=sin(x);
% curve 3: random (from normal distribution)
y3=randn(size(x));

% plot curve 1
plot(y1);
% again, but now please use red crosses, no lines
plot(y1,'r+');
% again, but use the proper x values 
plot(x,y1,'r+');

% different ways to have more than one curve on
% the plot:
% 1. one after the other
plot(x,y1,'r+');
hold on
plot(x,y2);
plot(x,y3,'g.');
% if a new plot command shall erase existing plots
% (as before), use hold off:
hold off
plot(x,y3,'m-.');

% 2.a all at once (multiple inputs into the plot
% function)
plot(x,y1,'r+',x,y2,x,y3,'g.');

% 2.b all at once making use of array
% concatenation
plot(x,[y1' y2' y3']);

% 3. using yyaxis
clf
yyaxis left
plot(x,y1);
yyaxis right
plot(x,[y2' y3']);
% yyaxis has the advantage of creating two y-axes
% so that data with largely different scaling can
% be displayed together:
y1=y1*1000;
yyaxis left
plot(x,y1);

doc plot
doc LineSpec

% the figure command without input argument opens 
% up an additional figure window, automatically 
% incrementing the figure number
for g=1:3
  figure
end

% what is a sine plotted vs a cosine?? Plot the 
% answer in figure window # 11
figure(11)
plot(cos(x),y2);
axis square
help axis

% wipe it out (clear the axis)
cla
% wipe whole figure
clf
% close the most recent figure window
close
% self-explanatory
close all

% let's do some 'animation' of a randomly moving 
% particle in 2D
xpos=0;
ypos=0;
for i=1:100
  plot(xpos,ypos,'ko');
  axis([-20 20 -20 20]);
  xpos=xpos+randn;
  ypos=ypos+randn;
  % drawnow tells Matlab to execute all pending
  % graphics commands - if we omit it we may not
  % see the particle hops in each loop execution
  drawnow;
  pause(.02)
end

% another type of 2D plot: the bar plot
% bar plots are a natural choice for histograms,
% e.g. for points drawn from the Gaussian
% distribution
d=randn(1000,1);
binWidth=0.05;
binEdges=-3:binWidth:3;
binCenters=binEdges(1:end-1)+binWidth/2;
% compute distribution of the points among bins
n=histcounts(d,binEdges); % ** R2014b and up
% n=histc(d,binEdges); n(end)=[];% ** pre-R2014b
bar(binCenters,n,1.0,'k');
% let's garnish the plot
title('Normally distributed samples')
xlabel('x');
ylabel('N');

% function histogram computes the distribution and 
% creates a plot in one go:
histogram(d,binEdges);
% you need not even specify the bins
histogram(d);

%% moving particle fun 

% now, we would like to have more than one plot 
% per figure window, namely to look at different 
% aspects of a particle randomly moving in 3
% dimensions..
ppath=cumsum(randn(10000,3));
subplot(2,2,1)
% part of the whole trajectory: first 100 points
subPathIdx=1:100;
plot(ppath(subPathIdx,1),ppath(subPathIdx,2),'kd-');
title('trajectory in xy plane');
% the particle's Euclidian distance from the
% origin of the coordinate system
paDist=sqrt(sum(ppath.^2,2));
subplot(2,2,2)
plot(paDist);
title('Euclidian distance from origin');
xlabel('step #');

% next plot:
subplot(2,3,2)
% oops - all plots are gone because instead of 
% subplot(2,2,... we typed subplot (2,3,...  
% which Matlab interprets as an implicit command 
% to clear the figure

% with a little more effort you can much 
% more explicitly specify the subplot's shape 
% and whereabouts:
subplot('position',[.1 .5 .8 .1])
clf

% 3D plots
plot3(ppath(subPathIdx,1),ppath(subPathIdx,2),ppath(subPathIdx,3),'b-o');
grid on

% Matlab offers very many different kinds of
% plots. Let's take a look at the contour plot. We
% would like to know where in the x-y plane the
% particle spent its time. To this end, we need to
% compute a 2-dimensional distribution:
% - determine most negative x and y coordinates
minV=min(min(ppath(:,[1 2])));
% - determine most positive x and y coordinates
maxV=max(max(ppath(:,[1 2])));
% - generate 100 regularly spaced bins in between
axGrid=linspace(minV,maxV,100);
% - now compute the distribution 
% ** R2015b:
d=histcounts2(ppath(:,1),ppath(:,2),axGrid,axGrid); 
% ** R2015a and earlier:
% d=hist2d(ppath(:,[1 2]),axGrid,axGrid); 
% - use the centers of the bins as axes
pax=axGrid(1:end-1)+diff(axGrid(1:2))*0.5;
% - plot it 
contour(pax,pax,d,30);
% - have some information on the color scaling
colorbar
% garnish the plot
xlabel('x coordinate');
ylabel('y coordinate');
title('dwell time');
% - let's have the contours filled
contourf(pax,pax,d,30);
colorbar
% - add plot of particle positions to verify that 
%   the distribution is correct
hold on
plot(ppath(:,2),ppath(:,1),'g.');
% now, let's change the colors in the plot:
colormap bone
colormap hot
% calling colormap without argument displays its 
% current value
colormap
clf

%% changing the appearance of plots 

% plot sth...
mn=mean(abs(ppath));
st=std(ppath);
x=1:3;
bar(x,mn,'k');
hold on
errorbar(x,mn,[0 0 0],st,'ko');
hold off
title('mean traveled paths in three dimensions')
% and change appearances in the 'property editor':
% - in the figure menu, go to view-property editor
% - click on the data, the axis and the figure to
% see how many poperties of the different graphics
% objects there are and how they can be changed

% *** the system behind it: handles ***
clf
% the bar plot again, but now, curiously, in an
% assignment!
bh=bar(x,mn,'k');
% Q: what is bh?
bh
whos bh
% A: 
% - in Matlab R2014a and below: a number,
% seemingly
% - in Matlab R2014b and above: something termed 
% 'matlab.graphics.chart.primitive.Bar'

% Here's the trick: bh is a 'handle', a pointer to
% some graphics object. When you create a graphics
% object, you can explicitly assign a handle to
% it.
ishandle(bh)
ishghandle(bh)
isgraphics(bh)

% What can we do with it? We can use it to change
% the appearance of the graphics object via
% written code (as opposed to doing it with the
% property editor, which is interactive). Using
% the 'set' command, we may, for example, change
% the color:
set(bh,'facecolor','g')
% so, supposedly we can also change a lot more
% than just the color? Yes, absolutely:
get(bh)
% so, let's recreate the error bars, too, and
% change their properties via the set command
hold on
ebh=errorbar(x,mn,[0 0 0],st,'ko');
set(ebh,'marker','none','linewidth',2,'color','g');

% On the occasion, here is a major difference
% between pre- and post R2014b graphics: while
% formerly handles to graphics objects were
% numbers (as alluded to above) starting in R2014b
% they are an entirely different data type,
% namely, handles (to graphics objects). The new
% graphics entailed a new syntax for changing
% graphics objects' properties:
ebh.Color='m';
% This dot notation, which we will deal with in
% more detail in the next unit (data types), is
% case-sensitive
ebh.color='g'; % doesn't work

% any graphics object can be assigned a handle:
% for example, we can have handles to figures,
% axes within a figure, plots in axes, text labels
% like titles, and so on:
fh=figure;
img=imread('cowpointer.jpg');
imh=image(img);
axis image off
th=title('a pointer to a cow')
% in case we should have forgotten to assign
% handles explicitly, we may retrieve some of them
% via the gc... functions:
% - the current figure (current=the one created or
% clicked on last)
gcf
% - the current axis
gca
% - the current object 
gco
% and a few more which we will deal with further
% below

% we can use them as explicitly assigned handles:
get(gcf)
set(gcf,'color','y')
set(gcf,'color',[.8 .8 .8])
% if you close (=delete) a figure the handles to
% it and to all graphics objects in it are no more
% valid, which Matlab thankfully informs us about,
% but the variable per se still exists:
close all
fh

%% 'high-level' vs. 'low-level' commands

% Let's step back again and recreate the simple
% bar plot (without explicit handle because we
% don't need it here):
bar(x,mn,'k');
% properties like color may have an arbitrary
% value within the given limits of that property.
% Other properties have a predefined set of values
% that can be set. Let's take a look at property
% 'nextplot'
get(gca,'nextplot')
% this is the (very unintuitive) syntax to find
% out about the set of predefined values
set(gca,'nextplot')
%  so, let's
set(gca,'nextplot','add')
% the effect of which is that existing plots like
% the bar plot in our axis will NOT be wiped if we
% issue another plot command:
ebh=errorbar(x,mn,[0 0 0],st,'ko');
% setting the 'nextplot' property is a 'low-level'
% command: a very specific, limited instruction.
% Alternatively, we may use a 'high-level'command.
% Before we do that, let's redo the bar plot once
% again:
clf
bar(x,mn,'k')
% the nextplot property is back to its default
% value, 'replace'
get(gca,'nextplot')
% now let's 
hold on
% ...and we see that additional plots will be
% added:
get(gca,'nextplot')
% the idea is that the 'hold' command should make the
% axis behave in a reasonable way when we intend
% to have several plots in one axis; setting the
% nexplot property is just one of several
% properties that are affected. The same applies
% to virtually all high-level commands, e.g. clf,
% axis, and many many more
clf

% another example of low-level vs. high-level
% commands: logarithmic scaling of axis
semilogx(abs(ppath(:,1)));
clf
plot(abs(ppath(:,1)));
set(gca,'xscale','log');

% so, one important insight into Matlab graphics
% at this point is that one can change almost
% every imaginable aspect of a plot with the set
% command, but for specialized graphs one quickly
% ends up producing dozens of code lines to
% achieve the desired result.

%% --- 'children', memory issues, legend, defaults
% we learned above that gco is a handle to the
% graphics object last clicked on
gco
% however, this is not equal to the last object
% created. As there is no such thing as gcp, the
% last plot produced, how can I retrieve a handle
% to the last (or any) plot I created, e.g. the
% line plot of the particle's path in the current
% axis? Here's how:
chld=get(gca,'children')
% all graphics objects created within another are
% children of that object, and via the 'children'
% property we get handles to them

% ** on this occasion, a few words concerning
% memory management: note that the line plot holds 
% all the data needed for its creation in its
% 'XData' and 'YData' fields:
get(chld)
% in other words, there is a lot of redundant data
% in the computer's memory:
isequal(get(chld,'ydata'),abs(ppath(:,1))')
% therefore, plotting very large data sets 
% (hundreds of thousands to millions of data 
% points) will easily clog up memory, and you may
% want to think about alternative strategies
% (downsampling or the like)

% Legends are a scientist's best friend:
h1=plot((ppath(:,1)));
hold on
h2=plot(paDist(:,1),'r');
% the legend function may take handles as input
% argument
lh=legend([h1 h2],'x-coordinate','distance to origin');

% We can set graphics defaults. To see how this
% works, let's 
get(0) % pre-R2014b
get(groot) % R2014b and up
% The two code lines above are old (unintuitive)
% and new (much better) Matlab syntax for
% retrieving the handle to the root of all
% graphics.
% We can see which defaults are set (in
% pre-R2014b, replace all instances of groot below
% by 0):
get(groot,'default')
% this places figures in upper left corner of the
% monitor
set(groot,'DefaultFigurePosition',[10 400 450 300]);
% affects axes including axis labels, legends,
% title, etc
set(groot,'DefaultaxesFontName','Helvetica');
set(groot,'DefaultaxesFontSize',12);
set(groot,'DefaultaxesLineWidth',1.0);
% we can also define defaults on a lower
% hierarchical level:
set(gcf,'DefaultLineLineWidth',3.5);
% as long as the figure exists, all lines in it
% will be plotted with width 3.5
clf
h1=plot((ppath(:,1)));
hold on
h2=plot(paDist(:,1),'r');
% we can 'remove' the default values we specified
% above, that is, restore its original value
get(gcf,'default')
set(gcf,'DefaultLineLineWidth','remove');
% and instead of clearing the figure and
% replotting the graph, we can use this command:
set(h1,'linewidth','default');


%% --- printing, saving, exporting graphics
% 0. orientation
% before saving or printing figures, make up your
% mind as to what area of a page the plots shall
% fill and what orientation the figure shall have. 
% The default:
orient portrait 
% these two orientations fill the whole page
orient landscape
orient tall

% 1. printing
% easiest: use the figure menu
% alternative: use the print function 
% send to default printer
print

% 2. saving figures
% this saves the plot and all the data needed for
% its creation in a *.fig file (which can be quite
% large, depending on the amount of data; see note
% above)
savefig(gcf,'particlePath');
% or 
saveas(gcf,'particlePath','fig');


% 3. exporting figures
% - quick & dirty: in the figure menu, go to 
%   edit-copy figure; plot will be put
%   in clipboard (bad resolution though)
% - better option: 'print' into file
% -- recommended for high quality figures: 
%   postscript or pdf
% -- for working style plots: jpg 
% So,
% export current figure in a color postscript
% level 2 file named 'particlePath.ps'
print -dpsc2 particlePath;
% same, but use pdf format (extensions of 
% file names are taken care of automatically)
print -dpdf particlePath;
% export figure 1 in jpeg file with a quality
% level of 95%
print -f1 -djpeg95 particlePath;

doc print

% highly recommended if you need to produce
% publication-quality figures: export_fig by
% Oliver Woodford, to be found at the Matlab
% Central File Exchange