% The solution to this task is function
% nernstpot in the \mcourse\func directory. Let's
% run it for potassium (120 mM inside, 3 mM
% outside):
e=nernstpot(25,1,3,120)

% How about chloride, the major ion rushing
% through GABAA receptors? Let's assume 120 mM 
% outside and 5 mM inside:
e=nernstpot(25,-1,120,5)

% Aha, so the equilibrium potential for chloride
% is less hyperpolarized given the assumptions
% above