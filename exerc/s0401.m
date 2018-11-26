% Generate the char array
h=help('datestr')

% See where 'Tuesday' is within h
tueIx=strfind(h,'Tuesday')
% It starts at position 4823

% See where the line breaks are within h
lineBreakIx=regexp(h,'\n')

% The first line break after the occurrence of
% Tuesday is at position 4833 in h. It is the 89th
% line break, so that is the line we're after. To
% find it without looking at tueIx and lineBreakIx
% generated above:
tueLineIx=min(find(lineBreakIx>tueIx))

% Let's look at it:
h(lineBreakIx(tueLineIx-1):lineBreakIx(tueLineIx))

% Replace using strrep
h=strrep(h,'Tuesday','Tomato Tom')