function [nJumps,varargout]=pmove(nDims,lim)
% ** function [nJumps,varargout]=pmove(nDims,lim)
% simulates the random movement of a particle in 1, 2 or 3 dimensions.
%
% >>> INPUT VARIABLES >>>
% NAME           TYPE          DESCRIPTION
% nDims          scalar        number of dimensions
% lim            scalar        limit of summed path of particle beyond 
%                              which simulation will terminate
%                     
% <<< OUTPUT VARIABLES <<<
% NAME           TYPE          DESCRIPTION
% nJumps         scalar        the number of jumps the particle made to 
%                              fulfil termination criterion
% varargout{1}   2d-array      the array holding the trajectory of the 
%                              particle (nDims columns, time runs down the 
%                              columns)

% This solution is based on s0205b.m
% The major differences
% - it is a function
% - the number of dimensions can be chosen (between 1 and 3)
% - there is no option to switch between termination conditions
% - Euclidian distances will be calculated
% - variable number of output arguments

% ------- check of input arguments---------------------------------
if nDims<1 || nDims>3
  error('nDims must be between 1 and 3');
end

% ------- check of output arguments---------------------------------
% check how many additional output arguments were requested (up to 2)
switch nargout
% either no output or just 'nJumps' requested
case {0,1} 
  % trajFlag is a parameter deciding whether trajectory shall be put out
  trajFlag=0;
case 2
  trajFlag=1;  
otherwise
  error('only 1 additional output argument (trajectory) is legal')
end

% ------- some auxiliary variables ---------------------------------
% the particle's position at time 0
pos=zeros(1,nDims);
traj=pos;
% the particle's summed path at the beginning
sumPath=0;
nBlockJumps=1000;
% the (running) number of loop executions performed 
loopc=0;
% doMove is a LOGICAL variable indicating whether the particle shall move on
% or not
doMove=true;

% ------- do it -----------------------------------------------
while doMove
  loopc=loopc+1;
  % variables pos, jump and sumPath are column arrays with as many columns
  % as dimensions
  % time is running down the columns
  jump=randn(nBlockJumps,nDims);
  pos=cumsum([pos(end,:); jump]);
  % the Euclidian distance covered by each jump
  jumpDist=sqrt(sum(jump.^2,2));
  sumPath=cumsum([sumPath(end,:); jumpDist]);
  r=min(find(sumPath>=lim));
  doMove=isempty(r);
  if trajFlag
    % if trajectory is requested as output argument, concatenate all
    % positions into variable traj
    % Note that this is memory-consuming!
    traj=[traj;pos];
  end
end

% ------- aftermath -----------------------------------------------
% the number of elementary particle jumps
nJumps=(loopc-1)*nBlockJumps+r;
if trajFlag
  varargout{1}=traj(1:nJumps,:);
end
disp(['condition met after ' int2str(nJumps) ' elementary particle jumps (' int2str(loopc) ' loop runs)']);
