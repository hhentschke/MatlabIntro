function pizza_service
evalin('base','tomatoes=rand(2);');
evalin('caller','cheese=rand(4);');

% Note: function pizza_service is used to
% demonstrate the functionality of evalin and is
% therefore run in debug mode. However, in debug
% mode, workspaces get mixed up if the proper
% syntax is used, counteracting the very purpose
% of the file. Therefore, the potentially
% problematic syntax of evalin is used above. Here 
% is the recommended syntax (when not debugging):
% 
% tomatoes=evalin('base','rand(2);');
% cheese=evalin('caller','rand(4);');
