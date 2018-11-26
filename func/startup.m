if exist('d:/hh/teaching/course_matlab/2018_GradSchoolMasters/','dir')
  rootp='d:/hh/teaching/course_matlab/2018_GradSchoolMasters/';
elseif exist('c:/mcourse','dir')
  rootp='c:/mcourse';  
elseif exist('d:/mcourse','dir')
  rootp='d:/mcourse';    
else
  warning('could not find ''mcourse'' directory'); 
  rootp='';
end

% places figures in upper left corner of monitor
set(groot,'DefaultFigurePosition',[10 200 450 300]);

% default is usletter, so for Europe change that 
set(groot,'DefaultFigurePaperType','A4');

addpath(rootp);
addpath([rootp '/func']);
addpath([rootp '/data']);
addpath([rootp '/exerc']);
addpath([rootp '/demo']);
curWorkDir=rootp;

cd(curWorkDir);

disp('************************************************************');
disp('*     Startup - Matlab Course - Winter Term 2017/18        *');
disp('************************************************************');
disp(' ');
disp(['Current working directory is ' curWorkDir]);

edit startup
