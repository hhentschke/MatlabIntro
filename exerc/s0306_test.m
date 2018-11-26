% figure(1), clf, orient landscape
% it's always a good idea to use variables for attributes that may change,
% in this case the number of rows and columns
nrows=4;
ncols=5;
nplots=nrows*ncols;

% the data to plot: one of the simplest discrete dynamical systems
% displaying chaotic behavior depending on the choice of parameter k
k=3+(1:nplots)/nplots;
niter=20;
x=repmat(.1,niter,nrows*ncols);
for i=2:niter
  x(i,:)=k.*x(i-1,:).*(1-x(i-1,:));
end

for np=1:nplots
  subplot(nrows,ncols,np);
  % not part of the task, but looks nicer: have markers and lines in
  % different colors
  plot(x(:,np),'cy-');  
  hold on
  h=plot(x(:,np),'bd');
  set(h,'markerfacecolor','b');
  xlabel('iteration #');
  ylabel('amplitude');
  title(['k=' num2str(k(np))]);
end
  
% to make sure the plots look appealing print the figure 
% as a jpeg..
print -f1 -djpeg60 beads 
% ..and inspect it in some jpeg viewer