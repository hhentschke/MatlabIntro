%% Linear and polynomial regression 
% of dependent variable y against an independent
% variable x: there are at least nine (yes, 9)
% different ways to do linear regression in
% Matlab, and only slightly fewer for polynomial
% regression! Unless stated otherwise the methods
% assume a constant term, i.e., the relations are
% of the sort
%                   y=a + b*x
%                   y=a + b*x + c*x.^2 + ...
% with 'a' being the constant term.

%% 0) Set up some artificial data
x=(-5:5)'+rand(11,1)
y=0.5*x+rand(11,1)-2
% Let's also generate artificial data from a
% quadratic polynomial
y2=-y+0.2*x.^2;
% In some of the methods below, we'll need
% variable x with an additional column of ones to
% obtain a fit with a constant term ('a' in the
% formula above), so let's create it here
Xc=[ones(size(x)) x]

%% plot
figure(1), clf
subplot(1,2,1)
plot(x,y,'o');
line([-6 0;6 0],[0 -6; 0 6],'linestyle','--','color','k');
grid on
hold on
axis tight
title('linear')

subplot(1,2,2)
plot(x,y2,'o');
grid on
hold on
axis tight
title('quadratic')

%% 1) Matrix left division 
% - assuming no constant term
coef1=x\y
% - assuming a constant term
coef2=Xc\y
% (On the occasion, this is the essence of Matlab,
% the kind of computation it has been devised for:
% matrix operations expressed as succinct code) Do
% the computed parameters fit the data well? Let's
% check this using so-called anonymous functions
linearFunc1=@(x) coef1*x;
linearFunc2=@(x) coef2(1)+coef2(2)*x;
xVal=[-6 6];
subplot(1,2,1)
ph1=plot(xVal,linearFunc1(xVal),'k-');
ph2=plot(xVal,linearFunc2(xVal),'b-');
text(-5,4,['y= ' num2str(coef2(1),2) '+' num2str(coef2(2),2) '*x']);

%% 2) regress
% As with the left matrix divide above, we have to
% add a column of ones to x so a constant term
% will be computed
alpha=.05;
[rcoeff,confI,r,rint,stats]=regress(y,Xc,alpha);
% Put out some information
disp(['linear regression y=a+b*x: a=' num2str(rcoeff(1))...
  '; b=' num2str(rcoeff(2)) ...
  '; R^2=' num2str(stats(1)) '; p=' num2str(stats(3))]);        

%% 3) regstats (without output arguments)
% Without output arguments, this function will pop
% up a GUI and create results variables as desired
% in the workspace.
regstats(y,x); 
beta
%% 3) regstats (with output arguments)
% With regstats, you can also incorporate
% quadratic and interaction terms. If you request
% an output argument, the GUI will not pop up;
% instead, all results will be made fields of the
% output variable. Let's do both here:
stats=regstats(y2,x,'quadratic')
stats.beta
%% 4) polyfit
% the first output variable contains the
% coefficients of the regression line, the second
% parameter some statistics like degrees of
% freedom, etc.
[coef,s]=polyfit(x,y,1)
% Let's check polyfit with the quadratic 
coef=polyfit(x,y2,2)
xVal=-6:.1:6;
quadFunc=@(x) coef(3)+coef(2)*x+coef(1)*x.^2;
subplot(1,2,2)
plot(xVal,quadFunc(xVal),'b-');

%% 5) using method 'fit' of LinearModel class 
% (statistics toolbox;  ** method will be removed
% in a future release **)
lm=LinearModel.fit(x,y)

%% 6) fitlm
lm=fitlm(x,y,'linear')
% note that 'fit objects' like lm have their own
% plot method
subplot(1,2,1)
plot(lm);
% displays linear regression parameters
disp(lm);

%% 7) The fit function (statistics toolbox)
% the nice thing about it is the automatic
% computation of confidence intervals of the
% parameters
fitRes=fit(x,y,'poly1')

%% 8) Use the figure menu ('tools - basic fitting') 

%% 9) Use the curve fitting toolbox
% we can start the curve fitting toolbox by
% clicking on its symbol in the 'APPS' tab in the
% command window or by evoking it from the command
% window
cftool