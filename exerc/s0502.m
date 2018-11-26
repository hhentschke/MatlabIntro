% solution using textscan (preferred):
fid=fopen('data\98n22014.atf');
tsl=textscan(fid,'%f%*[^\n]','headerlines',11);
fclose(fid);
% tsl is a cell array, so extract its content:
tsl=tsl{1};

% visually inspect time stamp list (must be monotonously ascending)
plot(tsl)
