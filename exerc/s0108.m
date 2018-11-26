clear
load d04

% the original
figure(1), clf
buzzplot(buzz)

% i) one single operation suffices: 'flipping' the array in
% the first dimension
newBuzz=flip(buzz,1);
figure(2), clf
buzzplot(newBuzz);

% ii) this one is harder: we need two steps:
% first, permute..
newBuzz=permute(buzz,[1 3 2]);
% then, flip dim
newBuzz=flip(newBuzz,3);
figure(3), clf
buzzplot(newBuzz);

% alternatively, and in a more circuitous way, we could
newBuzz=permute(buzz,[3 2 1]);
newBuzz=rot90(newBuzz,1);
newBuzz=ipermute(newBuzz,[3 2 1]);
figure(4), clf
buzzplot(newBuzz);

% iii) Free-style shuffling! While the operations above left
% neighbor relationships between elements intact we have to
% destroy them here. Particularly repmat in combination with
% circshift is useful for this kind of mischievous
% operation. Here is a demo of what circshift does (be sure
% to have figure window 4 in the foreground to see the
% 'movie':

figure(5)
drawnow
newBuzz=buzz;
for g=1:50
  newBuzz=circshift(newBuzz,[0 1]);
  buzzplot(newBuzz);
  pause(.3);
end

% now the task:
newBuzz=buzz;
% start by circularly shifting in two dimensions at once
newBuzz=circshift(newBuzz,[25 11]);
% use reshape to flatten newBuzz into a 2D array
newBuzz=reshape(buzz,[50*50*10 5]);
% rotate once
newBuzz=rot90(newBuzz);
% and bring back into original shape
newBuzz=reshape(newBuzz,[50 50 50]);
% look at the result
figure(5), clf
buzzplot(newBuzz);