function s0903

% ** this is a satisfying solution: all the code
% is in one function file and cleanly separated
% into a 'main' function and subfunctions.
% 'congratulations' and 'badLuck' might as well be
% separate functions, but since they accomplish
% very special things probably not required
% elsewhere, they are best defined as subfunctions

% preliminaries as before
cxpos=[1 2 3];
figure(1), clf
hold on
h=plot(cxpos(1),1,'bo',cxpos(2),1,'bo',cxpos(3),1,'bo');
set(h,'markersize',60);
set(gca,'xlim',[0 4]);

[~,prix]=max(rand(1,3));

% Instead of placing all commands in strings
% we generate function handles
funcH1=@congratulations_sub;
funcH2=@badLuck_sub;
% and use these
set(h(prix),'ButtonDownFcn',{funcH1,h});
set(h(setdiff(1:3,prix)),'ButtonDownFcn',{funcH2,h});
% Note the calling syntax (also read comments
% after subfunction 'congratulations_sub' below):
% - curly braces
% - the mandatory input arguments are not listed
% - the third input argument of either subfunction
%   is listed


% ------- subfunctions -------------------------------------
function badLuck_sub(src,eventdata,h)
text(1,1,'GAME OVER','fontsize',20,'fontweight','bold','color','r');
set(h,'ButtonDownFcn',[]);

function congratulations_sub(src,eventdata,h)
set(src,'markerfacecolor','g'); set(h,'ButtonDownFcn',[]);

% A number of things should be mentioned here: 
% i) Before dealing with GUIs, we enjoyed total
% liberty in defining functions: the number of
% input and output arguments was free to choose.
% Here, however, we use handles to (sub-)
% functions as callbacks for graphics objects (the
% 'doors' holding the prize or nothing, in
% technical terms they are line objects). Under
% this circumstance things are different: the
% first two input arguments ('src' and
% 'eventdata') are MANDATORY. If you do not
% include them in the function definitons, errors
% will result. The first input argument is the
% handle to the object calling this function (so,
% in our example this object is a single marker
% ('door' holding the prize/nothing)). The second
% input argument 'eventdata' contains nothing in
% this case, but does contain information in other
% cases (e.g. the kind of key pressed, etc.).
% Plese read the Matlab documentation as to the
% rationale behind these two input arguments. By
% the way, the fact that they are mandatory does
% not mean that their names are fixed: we could
% give them different names, e.g. 'Ernie' and
% 'Bert', if we wanted to add confusion to an
% already complicated subject..
% ii) Regardless of whether src and eventdata are
% mandatory or not, we can use them as we use any
% input argument. As a matter of fact, src is used
% in congratulations_sub to set the markersize.
% The additional input argument h is needed
% nevertheless: it contains the handles to all
% markers on the plot, which is what we need to
% delete all callbacks.

% For more & detailed information see the matlab
% documentation on function handle callbacks
