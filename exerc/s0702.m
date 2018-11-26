% Note: the following code and explanations assume that 
% i) stop conditions are identical in s0301 and s0305 
% ii) you ran both s0301 and s0305 at least once beforehand. This ensures
% that any functions that Matlab uses are memory-resident.

% We can run the profiler programmatically:
profile on
s0301
profile viewer

%%
profile on
s0305
profile viewer


% Inspection of the results points to the time-consuming, unnecessary code
% parts in s0301: plot is a high-level graphics function which performs a
% lot of steps in the backgound (these are the entries called
% 'axis','newplot', and others in the viewer) which would be needed only
% once. Also, as each plot command resets the axis limits, labels etc. it
% is necessary to renew them after each call to plot, which also costs a
% lot of computational time (relatively speaking). Of course, if your code
% contains a pause statement in the loop and the pause is relatively long
% (say, several hundred milliseconds) then of course Matlab will spend most
% of the time waiting for the pause to pass, and the relative time required 
% for running the graphics code is comparatively small.
% In s0305, all the preparatory work is done before the loop starts, and in
% the loop it is only the XData property of the plot handle which is
% updated, which is very efficient. If you click (in the profile viewer) on
% s0305, you'll notice that drawnow consumes by far the most time: drawnow
% forces Matlab to complete any pending graphics commands. So, yes,
% graphics is computationally expensive in Matlab. There is no reasonable
% way to do away with drawnow as the essence of an animation is the
% sequential display of graphics. If we omit drawnow, only a fraction of
% the particle's positions will be displayed (quite possibly only the first
% and last state), simply because the underlying computations are
% ridiculously simple and accordingly fast.
% So, summary: if you need a temporary animation of a few frames, it's fine
% to do animations the quick-and-dirty (time-consuming) way (as in s0301).
% If you want to code some serious animation (e.g. for your projects), use
% the 'set' functionality in Matlab to streamline your code. s0305
% exemplifies it for the plot function, the syntax is principally similar
% but not necessarily identical for other graphics/plotting functions.