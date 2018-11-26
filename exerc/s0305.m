% ** This code animates the particle movement in an efficient way. Compare
% to s0301.m (the difference may only be apparent if the pause between the
% loop iterations is set to zero)

% ------- user input ---------------------------------
% which condition do we want the particle to fulfil?
cond=2;
% what is the limit for each of the conditions?
lim1=5;
lim2=100;
% the particle's position at time 0
pos=0;
% the particle's summed path 
sumPath=0;
% axis limits
ax=[-lim1 lim1 0 2];

% ------- some auxiliary variables ---------------------------------
% the (running) number of loop executions performed 
nSteps=0;
% doMove is a LOGICAL variable indicating whether the particle shall move
% on or not
doMove=true;

% ------- do it -----------------------------------------------
% plot initial position of particle
ph=plot(pos,1,'ko');
% set axis limits
axis(ax);
% label the x axis
xlabel('position');
% reset random number generator
rng(0);
while doMove
  nSteps=nSteps+1;
  step=randn;
  pos=pos+step;
  switch cond
  case 1
    doMove=abs(pos)<lim1;
  case 2
    sumPath=sumPath+abs(step);
    doMove=sumPath<lim2;
  otherwise
    error('bad choice for condition parameter');
  end
  % update particle position
  set(ph,'XData',pos);
  % force Matlab to finish all graphics tasks before moving on 
  drawnow;
  % short pause so we can see the movement
  pause(.05)
end

% ------- aftermath -----------------------------------------------
disp(['condition met after ' int2str(nSteps) ' steps']);

