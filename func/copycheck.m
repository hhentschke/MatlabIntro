function copycheck(arr,job)
% ** function copycheck(arr,job)
% Depending on input variable job, this function
% performs simple operations or manipulations on
% input variable arr or on GLOBAL variable ARR.
% Options for input variable job:
% 'read'       - computes sum of first row of arr
% 'change'     - changes arr(1,1)
% 'globchange' - neither of the above, but changes 
%  ARR(1,1)
% -- global variable ARR must exist! --

global ARR

switch job
  
  case 'read'
    % just read the first row of the array and compute its sum
    s=sum(arr(1,:));
    clc
    disp('done reading');
  
  case 'change'
    % change the upper row
    arr(1,:)=99;
    clc
    disp('done changing');
    
  case 'globchange'
    % do sth with the global variable
    ARR(1,:)=99;
    clc
    disp('done changing global variable');
    
end

  