function flowerpower(len,col)
[n1,n2]=size(len);

figure(1), clf, hold on
grid on
stem3(nan,nan,nan);
set(gca,'xlim',[0 n1+1],'ylim',[0 n2+1]);

for g=1:n1
  for h=1:n2
    sh=stem3(g,h,len(g,h),'k');
    set(sh,'markerfacecolor',[col(g,h) 0 0],'markersize',10);
  end
end
    
set(gca,'CameraPosition',[ -8.2716  -40.7563    4.7764]);
xlabel('row index')
ylabel('column index');
zlabel('length (m)')