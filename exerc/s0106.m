clear
load d01
spy(a2)
% you may copy & paste the lines below repeatedly into the 
% workspace and execute them 

% A remarkable thing about array indexing in matlab is
% highlighted here: you can address non-contiguous subsets
% of arrays (namely two corners which by definition are not
% connected) in a single statement
a2(end-9:end,[1:10 end-9:end])=a2(end-9:end,[end-9:end 1:10]);
% clockwise rotation:
a2=rot90(a2,-1);
spy(a2);
