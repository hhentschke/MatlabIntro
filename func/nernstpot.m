function e_equil=nernstpot(T,z,c_out,c_in)
% ** function e_equil=nernstpot(T,z,c_out,c_in)
% computes the Nernst potential of an ion, given the following input:
% T     - temperature in degrees Celsius
% z     - charge of the ion
% c_out - the concentration of the ion outside the
%         cell (arbitrary unit)
% c_in  - the concentration of the ion inside the
%         cell (arbitrary unit)

% a few constant values:
R=8.3144;
F=96485;

% convert temperature from °C to Kelvin
T=T+273.15;

% compute (multiply by 1000 to obtain millivolts)
e_equil=1000*R*T/(z*F)*log(c_out/c_in);
