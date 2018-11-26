% ------- user input --------------------------------- 
% which condition (see switch statement below) do we want the particle to
% fulfil?
cond=2;
% what is the limit for each of the conditions?
lim1=5;
lim2=1e6;
% the particle's position at time 0
pos=0;
% the particle's summed path 
sumPath=0;

% ------- some auxiliary variables --------------------------------- 
% the (running) number of loop executions performed 
nSteps=0;
% doMove is a LOGICAL variable indicating whether the particle shall move
% on or not
doMove=true;


% ------- do it -----------------------------------------------
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
end

% ------- aftermath -----------------------------------------------
disp(['condition met after ' int2str(nSteps) ' steps']);

% Remarks
% 1. A for loop is not suited for this task because due to the randomness
% of the simulated movement prediction of the number of time steps is not
% possible (in fact, computation of this number is part of the task). 
% 2. In each run of this loop a switch statement is executed. This slows
% the code down a trifle. If code execution speed is the main criterion, it
% would be better to...well, see exercise 7.2. In general, keep all
% unnecessary code out of loops that run many times! 
% 3. Talking about speed again (independent of the point above): is there a
% 'vectorized' version of this task? --> see s0205b.m
