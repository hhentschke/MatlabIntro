% The strategy taken here: make a long column array,
% copy the contents of the wav file (which is a column 
% array) into it, and add as many amplitude-reduced 
% copies into it as there are echoes

clear;
% [y,fs]=audioread('data\cpf.wav');
[y,fs]=audioread('data\cow.wav');

% wave data are returned as column vectors, so r is the
% number of data points
[r,c]=size(y);

% ------ preliminaries: 
% for the fun of it, play sound in deep voice..
p=audioplayer(y,.5*fs);
playblocking(p);
% ..as if Mickey Mouse were here..
p=audioplayer(y,2*fs);
playblocking(p);
% ..and backwards, too
p=audioplayer(flipud(y),fs);
playblocking(p);

pause(.5)

% --------- our input
% the delay between consecutive echos in s
delay=.7;
% this delay, expressed in terms of sampling points
delayPts=round(delay*fs);
% how many echoes?
nEchoes=2;
% the attenuation factor
att=.5;

% --------- some important calculations
% the new variable holding the original as well as all
% echoes must have this size in points (if you do not see
% why that is so take a piece of paper and a pencil and draw
% a sketch of the situation)
audioDataPts=r+nEchoes*delayPts;
audioData=zeros(audioDataPts,1);

% -------- do it
% put in the original
audioData(1:r,1)=y;
% ADD attenuated originals
audioData(delayPts+1:delayPts+r,1)=audioData(delayPts+1:delayPts+r,1)+y*att;
% and again
audioData(delayPts*2+1:delayPts*2+r,1)=audioData(delayPts*2+1:delayPts*2+r,1)+y*att^2;
% (note that there is an inconsistency in this script: a
% variable 'nEchoes' exists which sets the length of 'audioData'
% according to the number of echoes, but in the two code
% lines above an invariable number of echoes, namely two,
% are inserted. This is because at this point you are not
% yet familiar with control flow which would allow you to
% insert as many echoes as 'nEchoes' suggests the code
% should.)

% now audioData has to be normalized, because audioplay accepts
% only values in the range [-1 1] and adding overlapping
% pieces of wav data may have resulted in values outside
% that range
peak=max(max(audioData),abs(min(audioData)));
audioData=audioData/peak;

p=audioplayer(audioData,fs);
play(p);