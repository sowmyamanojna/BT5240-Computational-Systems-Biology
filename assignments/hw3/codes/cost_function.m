% cost_function
% function returns the cost, given P and a flag
% 
% This function uses 'readmatrix' which is available in MATLAB 2020a or
% above. If the program throws an error, kindly comment the lines with
% 'readmatrix' and uncomment the line(s) following it.
% 
% INPUT:
% P - column vector of [p1, p2, p3]' in the same order
% flag - determines the dataset to be used:
%        1: dataset 1
%        2: dataset 2
%        3: dataset 3
% 
% WORKING:
% Normalised sum of squares error was calculated only for cases where the
% function was integrable at all time instances and where all the
% concentrations were greater than 0.

function cost = cost_function(P, flag)

x = analyse_ode(P, flag);
data1 = readmatrix('dataset1.dat');
data2 = readmatrix('dataset2.dat');
% In case the above 2 lines throw an error, kindly comment them and 
% uncomment the following lines:
% data1 = importdata('dataset1.dat').data;
% data2 = importdata('dataset2.dat').data;

data1 = data1(:,2:end);
data2 = data2(:,2:end);

switch flag
    case 1
        if size(x) == [75 8] & sum(x(:) >= 0) == numel(x)
            cost = nansum(nansum(((x-data1)./data1).^2));
        else
            cost = Inf;
        end
    case 2
        if size(x) == [75 8] & sum(x(:) >= 0) == numel(x)
            cost = nansum(nansum(((x-data2)./data2).^2));
        else
            cost = Inf;
        end
    case 3
        data = [data1; data2];
        if size(x) == [150 8] & sum(x(:) >= 0) == numel(x)
            cost = nansum(nansum(((x-data)./data).^2));
        else
            cost = Inf;
        end
end     
end