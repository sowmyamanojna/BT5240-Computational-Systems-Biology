% ode_model1
% function that returns the values of the vector xdot at a given time instant
% 
% INPUT:
% P - column vector of [p1, p2, p3]' in the same order
%  
% OUTPUT:
% xdot - values of the model components at a given time instant
%        The values in correspond to 
%            1 - MKKK                          5 - MKK-PP
%            2 - MKKK-P                        6 - MAPK
%            3 - MKK                           7 - MAPK-P
%            4 - MKK-P                         8 - MAPK-PP
% 
% WORKING:
% All the parameter values corresponding to dataset 1 is defined here. 
% The values returned are calculated as per the differential equations.

function xdot = ode_model1(t, x, P)

% initialisation of unknown parameters
p1 = P(1);
p2 = P(2);
p3 = P(3);

% parameter set 1;
KI = 9;
n = 1;
V1 = 2.5;
V9 = 0.5;
V10 = 0.5;
K1 = 10;
K2 = 8;
K3 = 15;
K4 = 15;
K5 = 15;
K6 = 15;
K7 = 15;
K8 = 15;
K9 = 15;
K10 = 15;

% reactions
r1 = V1*x(1)/((1 + (x(8)/KI)^n)*(K1 + x(1)));
r2 = p3*x(2)/(K2 + x(2));
r3 = p1*x(2)*x(3)/(K3 + x(3));
r4 = p1*x(2)*x(4)/(K4 + x(4));
r5 = p2*x(5)/(K5 + x(5));
r6 = p2*x(4)/(K6 + x(4));
r7 = p1*x(5)*x(6)/(K7 + x(6));
r8 = p1*x(5)*x(7)/(K8 + x(7));
r9 = V9*x(8)/(K9 + x(8));
r10 = V10*x(7)/(K10 + x(7));


% xdot represents the component values as per the differential equations 
% in the model.
% The values in correspond to 
% 1 - MKKK                          5 - MKK-PP
% 2 - MKKK-P                        6 - MAPK
% 3 - MKK                           7 - MAPK-P
% 4 - MKK-P                         8 - MAPK-PP

xdot = zeros(8,1);
xdot(1) = r2 - r1;
xdot(2) = r1 - r2;
xdot(3) = r6 - r3;
xdot(4) = r3 + r5 - r4 - r6;
xdot(5) = r4 - r5;
xdot(6) = r10 - r7;
xdot(7) = r7 + r9 - r8 - r10;
xdot(8) = r8 - r9;

end
