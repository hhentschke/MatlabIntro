clear
load d01

[r,c]=size(a2);

spy(a2)
for i=1:500
  % this results in the 'corners' being shifted by one row
  % upwards before each loop execution. The modulo function
  % helps keeping the row indices into a2 within legal
  % limits
  rIdx1=[r-9 r]-mod(i,r-10);
  a2(rIdx1(1):rIdx1(2),[1:10 c-9:c])=a2(rIdx1(1):rIdx1(2),[c-9:c 1:10]);
  % clockwise rotation:
  a2=rot90(a2,-1);
  spy(a2);
  drawnow;
end