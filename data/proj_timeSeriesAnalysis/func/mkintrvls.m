function [intrvls,intrvls_pts,nilen,nilen_pts,broeckel_pts]=mkintrvls(Int,varargin)
% **function [intrvls,intrvls_pts,nilen,nilen_pts,broeckel_pts]=mkintrvls(Int,varargin)
% divides a large interval Int (e.g. a period of time) into regularly spaced smaller sub-intervals 
% possibly overlapping each other and puts out start and stop points of the intervals
% ------------------------->>> INPUT VARIABLES >>>-----------------------------------------------------
% NAME                TYPE/DEFAULT        DESCRIPTION
% Int                 2-element-array     start and end times of interval to be subdivided (arbitrary continuous unit, e.g. ms)
% resol                scalar, 1          desired resolution of discretely distributed data, e.g. sampling interval (ms) for 
%                                           time data
% [ilen | ni]         scalar              length of intervals OR number of intervals (of course you cannot specify both)
%                     OR 2-element-arr    range of acceptable interval lengths/numbers 
%                                           function will select lowest value resulting in least omission of points at border
% olap                scalar,0            extent of overlap between segments 
% border              string, 'skip'      determines how to deal with points remaining from division of interval (if they exist)
%                                         'skip'    - ignore, all intervals will have identical length, but interval 
%                                             may not be completely covered
%                                         'include' - include, last interval will be shorter than other intervals
%                                         'embrace' - include, last interval will be as long as others and shifted backwards 
%                                             resulting in more overlap between last and last but one interval
% verbose             scalar, 0           if 1, crucial detail of the calculations will be printed on screen
%                                         if any other nonzero value, you will be informed about details of the calculations 
%                                           (and maybe other things as well)
% ------------------------ <<< OUTPUT VARIABLES <<< ----------------------------------------------------
% NAME                 TYPE/DEFAULT        DESCRIPTION
% intrvls              2d-array            sampling-aligned start (column 1) and stop (col2) times (ms) of intervals
% intrvls_pts          2d-array            start (column 1) and stop (col2) times (in points) of intervals
% nilen                scalar              may differ from input value, see above
% nilen_pts            scalar              may differ from input value, see above
% broeckel_pts         scalar              remainder (pts)


resol=1;
ilen=nan;
ni=nan;
olap=0;
border='skip';
verbose=0;

pvpmod(varargin);

if verbose, disp(['**** ' mfilename ':']); end;
if exist('borders','var')
  warning('attention please: ''border'' is the name of the variable, not ''borders'' - assigning value of latter to first');
  border=borders;
  clear borders;
end;

idx=1;

if isnan(ilen) & isnan(ni), error('specify length of intervals or number of intervals'); end
if ~isnan(ilen) & ~isnan(ni), error('specify EITHER length of intervals OR number of intervals, not both'); end
if ~isnan(ilen)
  % remember trivial but easy-to-be-unaware-of differences between continuous and discrete variables
  % - length of a time interval (continuous vars), e.g. len=diff(intrvl)
  % - length of a time interval (discrete vars, i.e. points),  len=diff(intrvls_pts)+1
  % conversion of continuous variable into discrete variable (points) is done in a 'conservative' way:
  % the discrete variable re-converted into continuous format will be <= original continuous variable
  idiff_pts=unit2pts(ilen,resol,'round')-1;
  olapdiff_pts=unit2pts(olap,resol,'round')-1;
  Int_pts(1)=unit2pts(Int(1),resol,'floor')+1;
  Int_pts(2)=unit2pts(Int(2),resol,'ceil');
  % total # of pts in Int
  IntLen_pts=diff(Int_pts)+1;
  % simple checks
  if size(IntLen_pts) ~= [1 1], error('Int must be a 2-element array'); end;
  if sum(size(idiff_pts))>3, error('ilen must be a scalar or a 2-element array'); end;
  if any(idiff_pts>IntLen_pts), error('(range of) desired sub-interval length is longer than Int'); end
  if any(ilen<resol), error('(range of) desired sub-interval length is too short given resolution'); end  
  if olapdiff_pts>=idiff_pts, error('overlap between intervals is larger than or equal to sub-interval length'); end
  
  % find best interval length if a range is given
  if sum(size(idiff_pts))==3,
    % idiff_pts is now an n-element 2d array
    idiff_pts=idiff_pts(1):idiff_pts(2);
  end;
  [nix,idx]=min(rem(IntLen_pts-olapdiff_pts,idiff_pts-olapdiff_pts));
  % now idiff_pts is a scalar whose value represents the optimal subinterval length
  idiff_pts=idiff_pts(idx);
  [broeckel_pts,nix]=min(rem(IntLen_pts-olapdiff_pts-1,idiff_pts-olapdiff_pts));
  % calculate start points
  switch border
  case 'skip'
    % 'remainder is NOT included here
    intrvls_pts=[Int_pts(1):idiff_pts-olapdiff_pts:Int_pts(2)-idiff_pts]';
  case 'include'
    % remainder is included in subinterval of smaller length here
    intrvls_pts=[Int_pts(1):idiff_pts-olapdiff_pts:Int_pts(2)-olapdiff_pts-1]';
  case 'embrace'
    % remainder is included in subinterval of full length shifted such that its end falls upon end of whole data segment 
    intrvls_pts=unique([Int_pts(1):idiff_pts-olapdiff_pts:Int_pts(2)-idiff_pts Int_pts(2)-idiff_pts]');
  otherwise
    error('bad input string for ''borders''');
  end
  % stop points
  intrvls_pts(:,2)=intrvls_pts(:,1)+idiff_pts;
  % for the 'include' case above check/adjust stop point of last interval
  if intrvls_pts(end,2)>Int_pts(2)
    if strcmpi(border,'include')
      intrvls_pts(end,2)=Int_pts(2);
    else
      error('internal error: last point of last interval beyond bounds of data segment');
    end
  end;
  % subtract 1 to have 1st data point at continuous time 0
  intrvls=pts2unit(intrvls_pts-1,resol);   % ms
  ni=size(intrvls_pts,1);
  if verbose
    if verbose==2
      why;
      disp(['interval ' num2str(Int) ' was divided into ' int2str(ni) ' intervals of regular length '...
          num2str(pts2unit(diff(intrvls_pts(1,:))+1,resol)) ', the remainder being ' num2str(pts2unit(broeckel_pts,resol))]);
      disp(['in points: interval ' int2str(Int_pts) ', regular interval length '...
          int2str(diff(intrvls_pts(1,:))+1) ', remainder ' int2str(broeckel_pts)]);
      intrvls, intrvls_pts
    else disp(['number of subintervals: ' int2str(ni) ', remainder: ' int2str(broeckel_pts)]);
    end
  end
elseif ~isnan(ni)
  error('sorry, not yet finished with this part..');
end;

nilen_pts=idiff_pts(1,:)+1;
nilen=pts2unit(nilen_pts,resol);

% ----------------- local func ------------------------------------
% assume all continuous measures have same units
function xu=pts2unit(x,resol)
xu=x*resol;

function xpts=unit2pts(x,resol,rdmeth)
tmp=x/resol;
eval(['xpts=' rdmeth '(tmp);']);
