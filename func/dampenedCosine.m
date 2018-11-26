function dampenedCosine(xRange,stepSize,a,lineStyle)
% ** function dampenedCosine(xRange,stepSize,a,lineStyle)
% This function plots a dampened cosine wave over
% a range of input (abscissa) values. The formula
% is y=cos(x)/(1+ax2). 
% The input arguments of the function are 
% xRange -    the range of abscissa values over which
%             to plot the function in radians
% stepSize - 	the step size (increments) of the 
%             abscissa values
% a        -	the value of parameter a
% lineStyle -	the color and line style of the plot
%             (as used by the plot command)

% create the range of abscissa values
x=xRange(1):stepSize:xRange(2);
% open up a new figure window
figure
% plot. Note two things:
% i) we have to use the ./ and .^ operators
% because we need elementwise division and
% potentiation
% ii) we plug input argument 'lineStyle' directly
% into the plot function
plot(x,cos(x)./(1+a*x.^2),lineStyle)


