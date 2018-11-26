clear
load d01

b2=[a1 a1];
% note the semicolon
b3=[a1 ; a1];
b4=a1([end 2 1],:);
% typing one and the same thing 50 times would be
% madness, so use repmat now 
b5=repmat(a1(:,3),50,1);
