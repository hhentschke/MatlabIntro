function s0902b
% ** see comments at end of file

% preliminaries as before
cxpos=[1 2 3];
figure(1), clf
hold on
h=plot(cxpos(1),1,'bo',cxpos(2),1,'bo',cxpos(3),1,'bo');
set(h,'markersize',60);
set(gca,'xlim',[0 4]);

[m,prix]=max(rand(1,3));

% Call functions that contain the commands
set(h(prix),'ButtonDownFcn','congratulations_sub(h,prix)');
set(h(setdiff(1:3,prix)),'ButtonDownFcn','badLuck_sub(h)');


% INSERT CODE HERE (see comment below)

% ----- subfunctions ------------------------------------------------
function congratulations_sub(h,ix)
set(h(ix),'markerfacecolor','g'); set(h,'ButtonDownFcn',[]);
  
function badLuck_sub(h)
text(1,1,'GAME OVER','fontsize',20,'fontweight','bold','color','r');
set(h,'ButtonDownFcn',[]); 

% ------ comments -------------------------------
% This version does not work because 
% - the function has its own workspace 
% - but the strings in the callback are evaluated 
%   in the BASE workspace! 
% This means that variables h and prix, created here,
% are not known in the base workspace. This is an
% inherent disadvantage of defining callbacks via
% strings. Workarounds include 
% - making variables global (not recommended) 
% - using assignin to have them in the base
% workspace: uncomment the two lines below and
% copy them above the subfunctions (in the spot
% that reads 'insert here'). Still, it won't work.
% Why? Because congratulations_sub and badLuck_sub
% are subfunctions and, as such, are visible only
% to s0902b.m. So, same problem (to be solved by
% using the autonomous versions of the functions,
% congratulations.m and badLuck.m) However, all in
% all this is not an elegant solution. The best
% way is to use function handles. See exercise
% 8.3.

% assignin('base','h',h);
% assignin('base','prix',prix);

