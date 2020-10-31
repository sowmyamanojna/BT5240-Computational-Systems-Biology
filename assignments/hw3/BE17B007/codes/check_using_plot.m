% check_using_plot
% This function has been used to visualise the fit of the data, given P and
% flag
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

function check_using_plot(P, flag)
x = analyse_ode(P, flag);

switch flag
    case 1
        data = readmatrix('dataset1.dat');
        % In case the above line throws an error, kindly comment it and 
        % uncomment the following line:
        % data = importdata('dataset1.dat').data;
        data = data(:, 2:end);
        
    case 2
        data = readmatrix('dataset2.dat');
        % In case the above line throws an error, kindly comment it and 
        % uncomment the following line:
        % data = importdata('dataset2.dat').data;
        data = data(:, 2:end);
    case 3
        data1 = readmatrix('dataset1.dat');
        data2 = readmatrix('dataset2.dat');
        % In case the above 2 lines throw an error, kindly comment them and
        % uncomment the following lines:
        % data1 = importdata('dataset1.dat').data;
        % data2 = importdata('dataset2.dat').data;
        data = [data1(:,2:end); data2(:,2:end)];
end
figure
b = 'Flag: ' + string(flag) + ' P: [' + string(P(1)) + ', ' + string(P(2)) + ', ' + string(P(3)) + ']';
sgtitle(b);
for i = 1:8
    subplot(4,2,i)
    plot(data(:,i), 'LineWidth', 3)
    hold on;
    plot(x(:,i), 'LineWidth', 3)
    name = 'Component ' + string(i);
    title(name);
end

end