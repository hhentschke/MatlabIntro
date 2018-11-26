clear
load d01

% Escapes: all entries with value nan. Here they
% are:
escapeDays=isnan(milk1)

% esc_days contains as many ones as there were
% days of the cow's absence. Of course we don't
% count them by scrolling through a long vector of
% zeroes and ones. Instead, let's use sum:
nEscapeDays=sum(escapeDays)

% The same applies to suspicious values, e.g. all
% values larger than 10
nSuspicDays=sum(milk1>10)
% There are other suspicious values. Let's deal
% with these in the next exercise.

% Note that Matlab performs an implicit conversion
% of number types (a 'type cast') in the
% background: an expression like isnan(milk1)
% evaluates to a logical array. The sum function
% used above first converts the logical ones
% (true) to the number one and then sums these up.