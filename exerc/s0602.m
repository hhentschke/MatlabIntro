%% 1.7 -> see mtable.m
t=mtable(15)

%% 2.7 -> see mmixer.m
stripes=repmat([zeros(1,10) ones(1,10)],80,4);
mmixer(stripes,60,53)

%% 3.6/2.5 -> see pmove.m
[n,traj]=pmove(2,500);
% plot
ph1=plot(traj(:,1),traj(:,2),'-');
% gray line
set(ph1,'color',[.5 .5 .5]);
hold on
% red dots
ph2=plot(traj(:,1),traj(:,2),'r.');
hold off

%% same game, but now 3D
[n,traj]=pmove(3,500);
% plot
ph1=plot3(traj(:,1),traj(:,2),traj(:,3),'-');
% gray line
set(ph1,'color',[.5 .5 .5]);
hold on
% red dots
ph2=plot3(traj(:,1),traj(:,2),traj(:,3),'r.');
hold off
grid on


