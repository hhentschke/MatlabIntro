function movebutt

% the multiple 'if ishandle...' commands are necessary because the button
% may have been hit several times

h0=figure(1);
clf
pos=[.3 .3];
len=[.4 .2];

h1 = uicontrol('Parent',h0, ...
  'Units','normalized', ...
  'HorizontalAlignment','center', ...    
  'Position',[pos len], ...
  'FontSize',14, ...
  'Fontweight','bold',...
  'style','pushbutton',...
  'String','try me', ...
  'TooltipString','don''t be afraid...',...
  'ListboxTop',0, ...
  'Tag','doneBttn', ...
  'userdata', 0,...
  'callback', @funfunc);  


% nested function: callback for button
  function funfunc(src,evdat)
    numberButtonPressed=get(src,'userdata');
    % track number of button presses
    numberButtonPressed=numberButtonPressed+1;
    set(src,'userdata',numberButtonPressed),
    if numberButtonPressed==1
      set(src,'string','catch me if you can!','ForegroundColor','r');
      run=1;
      while run
        if ishandle(src)
          run=get(src,'userdata') < 2
        else
          run=0;
        end
        pos=[mod(pos(1)+rand-.5,.6)+.0   mod(pos(2)+rand-.5,.6)+.0];
        if ishandle(src)
          set(src,'position',[pos len]);
        end
        pause(.3);
      end
    else
      for g=3:-1:1
        if ishandle(src)
          set(src,'string',int2str(g));
        end
        pause(.5)
      end
      if ishandle(src)
        delete(src)
      end
      if ishandle(h0)
        close(h0);
      end
    end
  end

end

