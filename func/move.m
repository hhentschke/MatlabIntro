% simulates Brownian motion of a particle in 1, 2 or 3 dimensions. 
function [nJump,t]=Motion(nDim,lim,pos)

% nDim is the number of dimensions
% startpos = start position of particle 
% lim is the limit of summed path of particle beyond which simulation will
% terminate;  nJump = the number of jumps the particle made to fulfill the termination criterion, namely 
% the summed path distance
% t is the array holding the trajectory of the particle 

if nDim<1 || nDim>3
  error('nDim must be between 1 and 3');
end
particlezeroposition=[0] 
t=pos;sumPath=0;nBlockJumps=1000;loop=0;

move=true;% to move or not to move, that is the question
doKeepTraj=1;
while move

  jump=randn(nBlockJumps,nDim);                                pos=cumsum([pos(end,:); jump]);
  % the Euclidian distance covered in each jump
  jumpDist=sqrt(sum(jump.^2,2));
  loop=loop+1;sumPath=cumsum([sumPath(end,:); jumpDist]);
  r=min(find(sumPath>=lim));
  % see whether summed path is already above limit 
  
  move=isempty(r);
  if doKeepTraj
       t=[t;pos];
end
end


nJump=(loop-1)*nBlockJumps+r; % the number of elementary particle jumps
% additional output arg, if requested
if doKeepTraj
      varargout{1}=t(1:nJump,:);
end
% put out a little information
disp(['condition met after ' int2str(nJump) ' elementary particle jumps (=' int2str(loop) ' loop runs)']);
