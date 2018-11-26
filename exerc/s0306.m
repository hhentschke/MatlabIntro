% ** Note that on Matlab versions prior to R2014b
% you have to replace groot below by 0

% affects axes including axis labels, legends, title, etc
set(groot,'DefaultaxesFontSize',6);
% so, the font will be small but bold
set(groot,'DefaultaxesFontWeight','bold');
% affects the plotted data
set(groot,'DefaultlineLineWidth',.25);
set(groot,'DefaultlineMarkerSize',4);

% test the settings: see s0306_test

% In case you want to change the settings back to the default values,
% uncomment the lines below:
% set(groot,'DefaultaxesFontSize','factory');
% set(groot,'DefaultaxesFontWeight','factory');
% set(groot,'DefaultlineLineWidth','factory');
% set(groot,'DefaultlineMarkerSize','factory');
