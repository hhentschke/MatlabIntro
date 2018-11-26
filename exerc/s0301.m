% ** Please note: this code animates the particle movementin an easily
% comprehensible, but very inefficient way. See s0305.m for a much improved
% version!

% ------- user input ---------------------------------
% which condition do we want the particle to fulfil?
cond=2;
% what is the limit for each of the conditions?
lim1=15;
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
  % plot
  plot(pos,1,'ko');
  % set axis limits
  axis(ax);
  % label the x axis
  xlabel('position');
  % force Matlab to finish all graphics tasks before moving on 
  drawnow;
  % short pause so we can see the movement
  pause(.05)
end

% ------- aftermath -----------------------------------------------
disp(['condition met after ' int2str(nSteps) ' steps']);

