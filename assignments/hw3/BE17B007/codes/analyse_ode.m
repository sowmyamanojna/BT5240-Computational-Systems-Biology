% analyse_ode
% function that calls a ode function and returns the integrated value
%
% This function uses 'readmatrix' which is available in MATLAB 2020a or
% above. If the program throws an error, kindly comment the lines with
% 'readmatrix' and uncomment the line following it.
% 
% INPUT:
% P - column vector of [p1, p2, p3]' in the same order
% flag - determines the dataset to be used:
%        1: dataset 1
%        2: dataset 2
%        3: dataset 3
% 
% OUTPUT:
% x - values of the model components as returned by the ode15s integrator
%     for the given P values and flag
%     The columns in x correspond to 
%       1 - MKKK                          5 - MKK-PP
%       2 - MKKK-P                        6 - MAPK
%       3 - MKK                           7 - MAPK-P
%       4 - MKK-P                         8 - MAPK-PP
%     while the rows are the respetive values at different time instances
% 
% WORKING:
% Based on the flag value, functions - ode_model1 (or) ode_model2 (or) both
% is (are) called. Different functions are maintained for each of the
% datasets, due to the difference in the parameter values



function x = analyse_ode(P, flag)

data1 = readmatrix('dataset1.dat');
% In case the above line throws an error, kindly comment it and uncomment
% the following line:
% data1 = importdata('dataset1.dat').data;

time = data1(:,1);
x0 = [90 10 280 10 10 280 10 10]';

switch flag
    case 1 
        [~,x_set1] = ode15s(@(t,x) ode_model1(t,x,P), time, x0);
        x = x_set1;
    case 2
        [~,x_set2] = ode15s(@(t,x) ode_model2(t,x,P), time, x0);
        x = x_set2;
    case 3
    	[~,x_set1] = ode15s(@(t,x) ode_model1(t,x,P), time, x0);
    	[~,x_set2] = ode15s(@(t,x) ode_model2(t,x,P), time, x0);
    	x = [x_set1; x_set2];

end