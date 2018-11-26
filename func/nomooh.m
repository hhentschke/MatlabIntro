function nomooh
% This function replicates the simple GUI in
% demo11.m; it is an example of a GUI that will
% not work. The error messages popping up inform
% us that variables snd and sampFreq_original are
% undefined and/or that there is an invalid handle
% object. The reason: different workspaces. The
% callbacks of our two uicontrols are strings, and
% these strings will be evaluated in the BASE
% workspace. However, all vital variables - snd,
% sampFreq, and the handles to the uicontrol -
% were generated here, within function nomooh. In
% other words, these variables are not accessible
% from the base workspace. 

figH=figure(2);
uiH2=uicontrol('style','pushbutton','string','press');
set(uiH2,'position',[20 20 160 120],'fontsize',20);
set(uiH2,'tooltipstring','press to hear the cow') 
[snd,sampFreq]=audioread('data\cow.wav');
set(uiH2,'callback','p=audioplayer(snd,sampFreq); play(p);');
set(uiH2,'KeyPressFcn','disp(''mooooh!'');');
slidH2=uicontrol('style','slider',...
  'position',[20 150 160 30],...
  'max',5,...
  'min',.3,...
  'value',1);
sampFreq_original=sampFreq;
set(slidH2,'callback',...
  'sampFreq=sampFreq_original*get(slidH2,''value'');');
