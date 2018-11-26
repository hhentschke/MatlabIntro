function varargout=moments(x)
% ** function varargout=moments(x)
% returns the first, second, third, ... k'th moments of
% vector x, where the j'th moment is 
%       sum(x.^j)/length(x).
% (Modified from Higham, D.J. & Higham, N.J., Matlab Guide, SIAM)

for j=1:nargout
  varargout(j)={sum(x.^j)/length(x)};
end