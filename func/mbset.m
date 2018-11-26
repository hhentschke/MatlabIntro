function mbset(varargin)



% coordinates of the rectangular excerpt of the complex plane for which the 
% Mandelbrot set is to be computed; the order of elements is 
% [minimal real part, maximum real part, minimal imag. part, maximal imag. part]
excerpt=[-2 .7 -1 1];

% the number of pixels in the real dimension (the number along the 
% imaginary axis will be computed)
nXPix=5000;
resol=diff(excerpt([1 2]))/(nXPix-1);

% the maximal number of iterations for each point in the complex plane
maxIter=1000;

% 
pvpmod(varargin);

% set up a 2-dimensional grid
[re,im]=ndgrid(excerpt(1):resol:excerpt(2),...
  excerpt(3):resol:excerpt(4));

% total number of points
nPoints=numel(re);

% preallocate results array
imageArr=zeros(size(re));

% initialize plot


for iPoints=1:nPoints
  iIter=0;
  x=re(iPoints);
  y=im(iPoints);
  while iIter<=maxIter && x*x+y*y<=4
    xold=x;
    x=x*x-y*y+re(iPoints);
    y=2*xold*y+im(iPoints);
    iIter=iIter+1;
  end
  imageArr(iPoints)=iIter;
end

imagesc(re([1 end],1),im(1,[1 end])',imageArr',[0 maxIter]);
axis equal
colorbar
