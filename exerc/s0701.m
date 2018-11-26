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
switch cond
  case 1
    while doMove
      nSteps=nSteps+1;
      step=randn;
      pos=pos+step;
      doMove=abs(pos)<lim1;
    end
  case 2
    while doMove
      nSteps=nSteps+1;
      step=randn;
      pos=pos+step;
      sumPath=sumPath+abs(step);
      doMove=sumPath<lim2;
    end
  otherwise
    error('bad choice for condition parameter');
end

% ------- aftermath -----------------------------------------------
disp(['condition met after ' int2str(nSteps) ' steps']);

% Remarks
% 1. This version is better in terms of speed than
% s0205 because the switch construct has moved out
% of the while loop. The drawback is more code
% (which is, besides, to a substantial degree
% redundant)
% 2. Implementing the same changes in s0205b, the
% semi-vectorized version, would not make a lot of
% difference: in this version the switch construct
% takes negligible time to execute relative to the
% other code lines.
