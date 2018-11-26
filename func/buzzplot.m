function buzzplot(d)

% check input, determine size
if ndims(d)~=3
  error(['sorry, ' mfilename ' expects input variable d to be 3D']);
end
[n1,n2,n3]=size(d);
if numel(unique([n1 n2 n3]))>1
  error(['sorry, ' mfilename ' expects input variable d to have identical number of rows, columns and slices']);
end

% as array indices and cartesian coordinates are different, bring d into proper form 
d=permute(d,[2 3 1]);
% instead of inverting the direction of the z axis, which would be correct,
% flip d and flip z labels, because otherwise the grid will be plotted 
% on top and obstruct the view
d=flip(d,3);

% insect information
insect=breedInsects;
nInsect=length(insect);

% use whichever figure is available
clf, hold on
axis([0 n1 0 n2 0 n3])

% for each element of insect, retrieve the location of its members and plot
for g=1:nInsect
  ix=find(d==insect(g).code);
  if ~isempty(ix)
    [x,y,z]=ind2sub([n1 n2 n3],ix);
    ph(g)=plot3(x,y,z,insect(g).symb);
    set(ph(g),'markersize',insect(g).mrkSz,'color',insect(g).col,...
      'markerfacecolor',insect(g).faceCol,'linewidth',1);
  end
end
grid on

sph=stem3(45,48,25,'g');
set(sph,'markerfacecolor','r','linewidth',2,'markersize',20);

zlabel('row index');
ylabel('''slice'' index');
xlabel('column index');

set(gca,'CameraPosition',[-68.3376 -349.3567  221.5837]);
set(gca,'ztickmode','manual','zticklabel',flipud(get(gca,'zticklabel')));

try
  legend(ph,{insect.name})
catch
end
