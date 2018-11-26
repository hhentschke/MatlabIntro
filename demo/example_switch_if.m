%% Are if and switch constructs equivalent?
% Scenario: query of a variable's value
limits=[0.5 0.2 0.1 0];
effectSize=0.14;

%% 
disp('if construct:')
if effectSize>limits(1)
  disp('large effect')
elseif effectSize>limits(2)  
  disp('intermediate effect')
elseif effectSize>limits(3)  
  disp('small effect')
else
  disp('negligible effect')
end

disp('switch construct:')
switch find(effectSize>limits,1)
  case 1
    disp('large effect')
  case 2
      disp('intermediate effect')
  case 3
      disp('small effect')
  otherwise 
    disp('negligible effect')
end


%% switch - doesn't work this way
switch effectSize>limits
  case [true true true true]
    disp('large effect')
  otherwise 
end

