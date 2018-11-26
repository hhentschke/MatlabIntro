% this is the 'static' version in which the
% definition of corners is fixed. See s0207b for
% a more interesting variant
clear
load d01

spy(a2)
for i=1:50
  a2(end-9:end,[1:10 end-9:end])=a2(end-9:end,[end-9:end 1:10]);
  % clockwise rotation:
  a2=rot90(a2,-1);
  spy(a2);
  drawnow;
end