function tplot(d,fs)

x=1:size(d,1);
plot(points2ms(x,fs),d);
xlabel('time (ms)');

% ---- subfunction -----------
function time=points2ms(pts,fs)
time=pts*1000/fs;