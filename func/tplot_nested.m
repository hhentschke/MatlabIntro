function tplot_nested(d,fs)
x=1:size(d,1);

  % ---- NESTED function -----------
  function points2ms
    x=x*1000/fs;
    % nested functions must be terminated by an
    % 'end'
  end

% this call of the nested function changes the
% value of variable x so that we can use it right
% away in the next line
points2ms;

plot(x,d);
xlabel('time (ms)');

% if there is any nested function the 'main'
% function (tplot_nested') must also be terminated
% with an 'end'
end

% Note: the hallmark of nested functions is (in
% simplifying terms) a great 'overlap' of the 
% workspaces of nested and parent functions. 
% This is why nested functions are great for 
% experienced Matlab programmers, particularly 
% those creating graphical user interfaces, but
% also why, on the other hand, they may confuse
% the beginner. I recommend working with functions
% and subfunctions first, and to proceed 
% to nested functions only after you acquired a 
% solid understanding of the concept of functions 
% and their workspaces.
