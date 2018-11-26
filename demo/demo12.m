%% Unit 9: GUIs 
% take a look at some relatively simple
% prefabricated GUIs: warndlg, questdlg, uigetfile

h=warndlg('Programming GUIs can be very time-consuming','A word of caution');
uiwait(h);
bn=questdlg('Sure you want to know more?','Crucial question',...
            'No','Yes','Don''t know, please tell me','Yes');
% questdlg puts out the string of the button
% pressed; this can then be used for control flow 
switch bn
  case 'No'
    exit;
  case 'Yes'
    uigetfile('*.m', 'Another quite useful GUI: uigetfile');
  case 'Don''t know, please tell me'
    if rand>.5
      msgbox('Do it');
    else
      msgbox('Better not');      
    end
end 
%%
% what does a GUI look like from the inside...?
edit questdlg

% Looks pretty complicated! Maybe because the task
% questdlg accomplishes is more complicated than
% we thought. If we made a very simple GUI on our
% own using 'guide' will we get more manageable
% code?
% Instructions:
% - type 'guide' at the command prompt
% - choose 'blank GUI' (default)
% - drag a pushbutton into the figure window and
%   increase its size
% - drag a slider into the window
% - save two different versions of the GUI; one by
%   clicking on 'Save as...' in the file menu, the
%   other by clicking on the 'Export...' option
% - marvel at the number of code lines in the
%   m-files of both versions

% So, quite in contrast to the usually terse style
% of Matlab, even simple GUIs can be composed of
% hundreds of code lines. Let's start and untangle
% things systematically. In the following, we will
% focus on these topics: 
% 1. Callbacks as elementary concepts of GUIs 
% 2. Objects which have callbacks & special
%    types of callbacks 
% 3. Function handles as callbacks 


%% 1. An elementary concept of GUIs: callbacks

% this is a primitive plot of just one data point
ph=plot(1,'o');
% it is of type 'line'
get(ph,'type')
% we know from the graphics sessions that we can
% define all kinds of properties of graphics 
% objects (the plotted data in this case), of the
% axis and even the figure. Let's take a look
% (again) at all the different properties of the
% plotted data:
get(ph)
% There is one property called 'ButtonDownFcn'.
% This is short for 'button press callback
% function'. The idea is that if the mouse pointer
% is above the data point and a mouse button
% pressed, something should happen. For example,
% the color of the plot should be set to a random
% value. In order to accomplish this, we have to
% use the set command to define our callback
set(ph,'ButtonDownFcn','set(gca,''color'',rand(1,3))');
% Now, each mouse click on the data point changes
% the axis' color randomly. 


%% 2. Objects with callbacks

% We can define callbacks for
% - graphics objects (like the one above)
%   including figures, axes, etc.
% - so-called user interface objects
% 
% Let's deal with figure callbacks first:
get(gcf)
% The fields corresponding to callbacks end in 
% 'Fcn'. In analogy to other graphics objects,
% there is a 'WindowButtonDownFcn'. So,
% predictably, after this command
set(gcf,'WindowButtonDownFcn','close all');
% a mouse click anywhere on the figure will close
% all figure windows. Try and experiment to find
% out what you have to do to get the
% 'WindowButtonMotionFcn' callback going! For a
% more systematic overview, search the
% documentation for 'callbacks'
% 
% Now to user interface objects. These are the
% 'real things' one usually means in the context
% of GUI programming. Let's create one in a fresh
% figure window: 
close all; figH=figure(1);
uiH1=uicontrol('style','pushbutton','string','press');
% use the ususal set/get to find out about and set
% properties
get(uiH1)
set(uiH1,'position',[20 20 160 120],'fontsize',20);
set(uiH1,'tooltipstring','press to hear the cow') 
% Now the interesting part, the callbacks
[y,fs]=audioread('cow.wav');
set(uiH1,'callback','p=audioplayer(y,fs); play(p);');
% What's this one?
set(uiH1,'KeyPressFcn','disp(''mooooh!'');');

% What kinds of uicontrols are there?
set(uiH1,'style')
% Yeah, let's make a slider 
slidH=uicontrol('style','slider',...
  'position',[20 150 160 30],...
  'max',5,...
  'min',.3,...
  'value',1);
% The slider shall control how fast the sound is
% played
fs_original=fs;
set(slidH,'callback',...
  'fs=fs_original*get(slidH,''value'');');
% Note that we can use a query of the slider's
% present value as a callback.
% **** Note: all commands in strings are evaluated
% in the base workspace **** 
% This may lead to problems when code like the one
% above is put into a function:
edit nomooh
nomooh
close

%% 3. Function handles as callbacks 

% Thus far, we have used commands in strings to
% define callbacks. This is fine as long as these
% commands are simple and short (although the
% double quotation marks are a drag). There is an
% additional way: function handles. They are
% constructed via the @ operator. Here is a handle
% to the sine function:
sfh=@sin;
whos sfh
% Use it
figure(2);
plot(sfh(0:.01:20));
% So, function handles are used like the functions
% they point to, that is, you call them by typing
% their name and you specify the same input and/or
% output arguments.
% We can create handles to any function, that is,
% also to those we made ourselves
funcH=@lineWidBlowup;
% Does lineWidBlowup need input arguments?
help lineWidBlowup

% **** IMPORTANT: ****************************
% Any function whose handle shall be used as a
% callback of a graphics object must have two
% 'default' input arguments, even if you never
% intend to use them. 
% *******************************************

% Traditionally, in the Matlab manuals and example
% code they are called 'src' and 'eventdata' (or
% similarly), but you can name them differently.
% The first of them is the handle to the caller.
% So, if we associate lineWidBlowup with the big
% fat button created above, the first input
% argument is a handle to the button. (Let's not
% care about the second argument now.) The third
% and fourth arguments, h and fac, are the ones we
% need. So, the idea now is to use this handle to 
% increase the line width of a plot of the wav 
% data when the button is pressed
figure(1), subplot(3,1,1);
ph=plot(y(1:3:end),'k-');
axis tight
% Set the callback...
try
  set(uiH1,'callback',funcH(uiH1,[],ph,2));
catch MExc
  disp(MExc.message)
end
% Disappointment! We get an obscure error message.
% Well, here is how to do it correctly:
set(uiH1,'callback',{funcH,ph,2});
% or
set(uiH1,'callback',{@lineWidBlowup,ph,2});

% So, unfortunately, the syntax of setting
% function handles as callbacks is not intuitive
% at all. Here are the rules: 
% - put everything after 'callback' in curly
% braces (in other words, into a cell array)
% - the first two mandatory input arguments of the
% function called are so mandatory that Matlab
% takes that business out of our hands and does it
% implicitly, in the background, so don't list
% them 
% - the remaining input arguments, if any, must be
% listed right after the function handle

% Given all this confusing syntax, why use 
% function handles at all? 
% --> see exercises 9.2 and 9.3

% There is another difficulty dealing with GUIs
% and function handles. Assume that pressing the
% pushbutton in the simple GUI we created above
% should create e.g. a filtered version of the wav
% file. A function like
%        filteredSound=filtersound(inputSound) 
% is useless if we want to use a handle to it as
% the callback of the button! The Matlab syntax
% illustrated above simply does not permit the use
% of callback functions which produce output
% arguments. So, what to do? As usual, there are
% several ways out:
% - use global variables (not recommended except
% for specific cases like variables of gigantic
% size)
% - store data 'within graphics objects'
% The latter option is probably a little confusing
% at the beginning but is in most cases preferred
% over using global variables. In short, here is
% the idea: remember that graphics objects store
% data - see demo06, around the line saying
% isequal(get(chld,'ydata'),abs(ppath(:,1))')
% Many, if not all, graphics objects allow you to
% store data in the so-called 'userdata' property:
set(gcf,'userdata',rand(100));
% Since working with a GUI you will always have a
% figure window open (namely the one holding all
% the sliders, buttons, etc.) you may use it to
% store and retrieve data. For example, our
% fictitious function filtersound could identify
% the main GUI figure window and write the
% filtered sound to its userdata field. Or it
% could use the pressbutton's userdata field. Once
% placed there, the data can then be retrieved by
% all other parts of the GUI. 
% Finally, particularly if you use 'guide' to
% generate GUIs it is advisable to know about
% these two functions:
help guihandles
help guidata