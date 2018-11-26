clear
load d01

% Escapes: all entries with value nan. The line
% below gives us the indices to the days:
escDays=find(isnan(milk1));
% So the total number is
nEscDays=length(escDays)

% Suspicious values: all values larger than 10
nSuspicDays=length(find(milk1>10))

% Highly suspicious values: infinite ..
nImpossibleDays=length(find(isinf(milk1)));
% .. or negative volume
nImpossibleDays=nImpossibleDays+length(find(milk1<0))


% ----- All right? No, because days with an
% infinite or negative-infinite number were
% counted twice: +/-infinity is certainly infinite
% (as checked by function 'isinf'), and it is also
% larger than 10/smaller than 0:
milk1(milk1>10) 
milk1(milk1<0) 

% We see that both nSuspicDays and nImpossibleDays
% were not determined correctly. Here are the
% correct versions:

% Suspicious values: all FINITE values larger than
% 10 
nSuspicDays=length(find(milk1>10 & isfinite(milk1)))

% Highly suspicious values (all conditions now
% compressed into a single line): 
nImpossibleDays=length(find( isinf(milk1) | (isfinite(milk1) & milk1<0) ))