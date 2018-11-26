function lineWidBlowup(src,evd,h,fac)
% ** function lineWidBlowup(src,evd,h,fac)
% increases line width of graphics object
% with handle h by factor fac

set(h,'linewidth',fac*get(h,'linewidth'));
% for 'educational' purposes display the type of
% graphics object which called:
disp(['function ' mfilename ' called by an object of type ' get(src,'type')]);