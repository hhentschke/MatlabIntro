clear
load d01
% version 1: directly assigning interesting columns to b1 
b1=a1(:,1:2:end)
% version 2: deleting columns
b1=a1;
b1(:,2:2:end)=[]