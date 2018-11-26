% *****************************************************
% see comments in f32load_a.m and f32load_b.m
% *****************************************************
% f32load
edit f32load
% ---- read data using f32load based on the original i16load & plot
d=f32load('data\lfp.f32',1,inf);
plot(d);
% d is a single-column array, holding the channel
% data vertically concatenated (first all data
% from one channel, then all data from next
% channel, and so on)

% ----- determine the number of data channels
% Let's divide the number of data points in d by 
%   (3 seconds * 2000 data points per seconds)
% and we know the number of channels:
ppChan=3*2000;
nChans=length(d)/ppChan;
% if nChans is not an integer we have a problem, 
% so check
if nChans ~= fix(nChans)
  error(['something not OK in calculation of channel number in ' mfilename]);
end


% ---- read data using variant a of the f32load-
% functions & plot
d=f32load_a('data\lfp.f32',1,inf);
plot(d);
% OK, works, but there is a more flexible approach

% ---- read data using variant b of the f32load-
% functions & plot
d=f32load_b('data\lfp.f32',1,inf,nChans);
plot(d);
% OK, fine, now we can even load excerpts:
d=f32load_b('data\lfp.f32',1000,3000,nChans);
plot(d);

