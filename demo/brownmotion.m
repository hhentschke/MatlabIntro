function [nJump,varargout]=brownmotion(nDim,lim,varargin)
% ** function [nJump,varargout]=brownmotion(nDim,lim,varargin)
% simulates Brownian motion of a particle in 1, 2 or 3 dimensions.
%
% >>> INPUT VARIABLES >>>
% NAME           TYPE          DESCRIPTION
% nDim           scalar        number of dimensions
% lim            scalar        limit of summed path of particle beyond 
%                              which simulation will terminate
% varargin{1}    row array     start position of particle (pay attention to
%                              dimensionality!)
%                     
% <<< OUTPUT VARIABLES <<<
% NAME           TYPE          DESCRIPTION
% nJump          scalar        the number of jumps the particle made to 
%                              fulfill the termination criterion
% varargout{1}   2d-array      the array holding the trajectory of the 
%                              particle (nDim columns, time runs down the 
%                              columns)

% ------- checks of input arguments ---------------------------------
if nDim<1 || nDim>3
  error('nDim must be between 1 and 3');
end
if nargin>2
  % the particle's position at time 0
  pos=varargin{1};
  if numel(pos)~=nDim
    error('dimension mismatch between starting position and input var ''nDim''');
  else
    % make sure pos is a row array (without actually checking this)
    pos=pos(:)';
  end
else
  % the particle's position at time 0 is by default the origin
  pos=zeros(1,nDim);
end

% ------- deal with output arguments ---------------------------------
% check how many additional output arguments were requested (up to 2)
% doKeepTraj is a variable determining whether trajectory shall be put out
doKeepTraj=false;
switch nargout
case {0,1} 
  % do nothing: either no output or just 'nJump' requested
case 2
  doKeepTraj=true;  
otherwise
  error('only 1 additional output argument (trajectory) is legal')
end

% ------- initialzation of variables ---------------------------------
% the particle's trajectory
traj=pos;
% the particle's summed path at the beginning
sumPath=0;
% number of jumps the particle shall make en block (to speed up code)
nBlockJumps=1000;
% the (running) number of loop executions performed 
nLoopRun=0;
% logical variable indicating whether the particle shall move or not
doMove=true;

% ------- move! -----------------------------------------------
while doMove
  nLoopRun=nLoopRun+1;
  % variables jump, pos and traj are column arrays with as many
  % columns as dimensions; time goes down the columns
  jump=randn(nBlockJumps,nDim);
  pos=cumsum([pos(end,:); jump]);
  % the Euclidian distance covered in each jump
  jumpDist=sqrt(sum(jump.^2,2));
  % summed path (= total travelled distance)
  sumPath=cumsum([sumPath(end,:); jumpDist]);
  % see whether summed path is already above limit 
  r=min(find(sumPath>=lim));
  doMove=isempty(r);
  if doKeepTraj
    % if trajectory is requested as output argument, concatenate all
    % positions into variable traj (note that this is memory-consuming and
    % slow because preallocation is not really possible here!)
    traj=[traj;pos];
  end
end

% ------- aftermath -----------------------------------------------
% the number of elementary particle jumps
nJump=(nLoopRun-1)*nBlockJumps+r;
% additional output arg, if requested
if doKeepTraj
  varargout{1}=traj(1:nJump,:);
end
% put out a little information
disp(['condition met after ' int2str(nJump) ' elementary particle jumps (=' ...
  int2str(nLoopRun) ' loop runs)']);
