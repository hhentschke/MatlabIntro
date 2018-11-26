% Create an array of five numbers between 1 and 10
% (it does not matter here whether it is a row
% array or a column array)
capDia=[4 2.5 3 9 5]
% convert to centimeters:
capDia=capDia*2.54
% correct the faulty value: in contrast to the
% line above, in which the whole array was changed,
% we now have to manipulate only one single
% element:
capDia(2)=capDia(2)+0.3*2.54