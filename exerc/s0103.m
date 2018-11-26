% one (of many) ways to generate array 'stripes'
stripes=repmat([zeros(1,10) ones(1,10)],80,4);
spy(stripes)
% multiplication:
stripes=stripes*15.4;
% nothing changes in the plot because 'spy' plots all numbers
% different from zero as a dot on the figure
spy(stripes)
% for the same reason, adding any nonzero values to stripes
% changes things dramatically
stripes(:,2:2:end)=stripes(:,2:2:end)+2;
spy(stripes)
% just for the fun of it, and as a preview of the graphics
% session, take a look at a 3d-plot of stripes
surfc(stripes)