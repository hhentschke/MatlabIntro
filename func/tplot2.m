function tplot2(d,fs,varargin)
% ** function tplot2(d,fs,varargin)
% plots data in d (channels along columns) versus
% time in ms. fs is the sampling frequency. One
% optional input argument will be used; if it is a
% char it will be placed as the y axis label

% by default, ylabel is empty..
ylab=' ';

% .. however, if a string is given as an optional 
% input use it
if nargin>2
  if ischar(varargin{1})
    ylab=varargin{1};
  else
    ylab=' ';
  end
end

% what else could be given as optional input
% arguments? for example an offset (if several
% channels shall be plotted one above the other)

x=1:size(d,1);
plot(points2ms(x,fs),d);
xlabel('time (ms)');
ylabel(ylab);


% ------ subfunction ----------
function time=points2ms(pts,fs)
time=pts*1000/fs;