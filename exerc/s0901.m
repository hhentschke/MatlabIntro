% plot circles at x positions 1, 2 and 3 and at height (y value) 1
cxpos=[1 2 3];
figure(1), clf
hold on
h1=plot(cxpos(1),1,'o');
h2=plot(cxpos(2),1,'o');
h3=plot(cxpos(3),1,'o');
% combine handles - this way, we can do without the switch statement as
% used in s0302
h=[h1 h2 h3];

clf
% since we are somewhat advanced at this point, I would like to point out 
% that the last four code lines could be compressed into a single command:
h=plot(cxpos(1),1,'bo',cxpos(2),1,'bo',cxpos(3),1,'bo');

set(h,'markersize',60);
set(gca,'xlim',[0 4]);

% the association with the prize: generate three random numbers and identify 
% the index to the largest number. That shall be the index to the winning door
[m,prix]=max(rand(1,3));

% The strings containing the callback commands are pretty long, depending on how
% precisely you want the game to work, so let's place them in a variable and
% use this variable in the set command.
% Set 'ButtonDownFcn' for the right door
bstr='set(h(prix),''markerfacecolor'',''g'');';
set(h(prix),'ButtonDownFcn',bstr);
% ..and the bad ones
bstr= 'text(1,1,''GAME OVER'',''fontsize'',20,''fontweight'',''bold'',''color'',''r'');';
set(h(setdiff(1:3,prix)),'ButtonDownFcn',bstr);

% So far, so good? Not quite: in the present version, we can open up all 
% three doors in one run of the program by clicking on them one after the 
% other. This is so because the callbacks of each of the markers (doors)
% remain in place; they don't dissolve after the first mouse click. This 
% behavior, however, is not in the spirit of the game. So, a better version
% deletes all callbacks after informing you about the outcome of the game:
tryBetterVersion=0;
if tryBetterVersion
  bstr='set(h(prix),''markerfacecolor'',''g''); set(h,''ButtonDownFcn'',[]);';
  set(h(prix),'ButtonDownFcn',bstr);
  % ..and the bad ones
  bstr= 'text(1,1,''GAME OVER'',''fontsize'',20,''fontweight'',''bold'',''color'',''r''); set(h,''ButtonDownFcn'',[]);';
  set(h(setdiff(1:3,prix)),'ButtonDownFcn',bstr);
end