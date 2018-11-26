function s0904

% 'congratulations_nest' and 'badLuck_nest' are nested functions. In the
% present example, it does not matter at all where within the code you
% place them. Note that they both use variable h, the array of handles to
% the three doors, although it is not defined as an input argument. That is
% one of the characteristics of nested functions: they have access to the 
% variables in the workspace of the 'main' function s0904.

% ------- the nested functions -------------------------------------
  function badLuck_nest(src,eventdata)
    text(1,1,'GAME OVER','fontsize',20,'fontweight','bold','color','r');
    set(h,'ButtonDownFcn',[]);
  end

  function congratulations_nest(src,eventdata)
    set(src,'markerfacecolor','g'); set(h,'ButtonDownFcn',[]);
  end
% -------------------------------------------------------------------

% preliminaries as before
cxpos=[1 2 3];
figure(1), clf
hold on
h=plot(cxpos(1),1,'bo',cxpos(2),1,'bo',cxpos(3),1,'bo');
set(h,'markersize',60);
set(gca,'xlim',[0 4]);

[m,prix]=max(rand(1,3));

% Handles to nested functions as callbacks.
% The functions do not have input arguments other than the two mandatory
% ones, which is why we can do without the curly braces here
set(h(prix),'ButtonDownFcn',@congratulations_nest);
set(h(setdiff(1:3,prix)),'ButtonDownFcn',@badLuck_nest);

end