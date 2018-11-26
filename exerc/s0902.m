% preliminaries as before
cxpos=[1 2 3];
figure(1), clf
hold on
h=plot(cxpos(1),1,'bo',cxpos(2),1,'bo',cxpos(3),1,'bo');
set(h,'markersize',60);
set(gca,'xlim',[0 4]);

[m,prix]=max(rand(1,3));

% Instead of placing all commands in strings
% we call functions that contain the commands
set(h(prix),'ButtonDownFcn','congratulations(h,prix);');
set(h(setdiff(1:3,prix)),'ButtonDownFcn','badLuck(h);');

% Now the question why we don't make s0902.m a
% function and congratulations and badLuck
% subfunctions. See s0902b.m.