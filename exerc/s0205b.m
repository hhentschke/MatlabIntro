% The task can be sped up substantially with a mixed approach:
% 1. compute 'nBlockJumps' jumps en block (randn allows that)
% 2. within a while loop see whether condition is met
%    yes: determine the number of particle jumps, done
%    no: repeat steps 1 and 2
% The choice of nBlockJumps depends on several factors. For obvious  
% reasons, it should be large for large values of lim1 or lim2. Also,
% there must be an upper boundary due to memory limitations.
% The optimal value can be estimated, however, here just some fixed value 
% is tried. An additional change: nSteps is no good name for a variable 
% here because it is ambiguous (is it the number of loop runs or the 
% number of particle hops?), so it is renamed.
% Try this version versus s0205 for large values of lim1 and lim2;
% you will see it is way faster. However, if, as is one of the tasks
% to follow, the particle's movements shall be animated (=plotted 
% in each step), the original approach is more suitable because a loop 
% dealing with each individual hop of the particle is inevitable then. 


% ------- user input ---------------------------------
% which condition do we want the particle to fulfil?
cond=2;
% what is the limit for each of the conditions?
lim1=50;
lim2=300000;
% the particle's position at time 0
pos=0;
% the particle's summed path 
sumPath=0;
% 
nBlockJumps=1000;

% ------- some auxiliary variables ---------------------------------
% the (running) number of loop executions performed 
loopc=0;
% doMove is a LOGICAL variable indicating whether the particle shall move on 
% or not
doMove=true;

% ------- do it -----------------------------------------------
while doMove
  loopc=loopc+1;
  % Variables pos, jump and sumPath are column arrays.
  % Guess why column arrays - exactly, because we may want to 
  % extend this game to more than one particle and/or more than
  % one dimension, in which case it is best to have simulated 
  % time running down the columns
  jump=randn(nBlockJumps,1);
  pos=cumsum([pos(end,1); jump]);
  switch cond
    case 1
      r=min(find(abs(pos)>=lim1));
      doMove=isempty(r);
    case 2
      sumPath=cumsum([sumPath(end,1); abs(jump)]);
      r=min(find(sumPath>=lim2));
      doMove=isempty(r);
    otherwise
      error('bad choice for condition parameter');
  end
end
  

% ------- aftermath -----------------------------------------------
nJumps=(loopc-1)*nBlockJumps+r;
disp(['condition met after ' int2str(nJumps) ' elementary particle jumps (' int2str(loopc) ' loop runs)']);
