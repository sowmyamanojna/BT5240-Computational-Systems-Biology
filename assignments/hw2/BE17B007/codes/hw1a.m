clear all; close all;clc;
% Loading complete data excluding the first two lines of text and all
% columns
a = dlmread('socfb-Caltech36.mtx', ' ', 2, 0);

% Calculating total number of nodes
nodes = max(max(a));
A = sparse(zeros(nodes,nodes));
[m,n] = size(a);

% Computing the Adjecency matrix
for i = 1:m
    col = a(i,2);
    row = a(i,1);
    A(row,col) = 1;
    A(col,row) = 1;
end

% degree sum along row
deg = sum(A,1);

% Calculation of assortativity
assort = assortativity(a, deg);
fprintf('Assortativity of the network: %1.7f\n', assort)

% Plotting the degree distribution
figure();
hist(deg, max(deg)-min(deg)+1, 'EdgeColor','k')
title('Degree distribution N(k) vs k')
xlabel('Degree (k)')
ylabel('Number of nodes with degree k (N(k))')

% Calculation of clustering coefficient
cc = clustering_coefficient(nodes, deg, A);
fprintf('Average clustering coefficient of the network: %1.7f \n',mean(cc)); 

% Plotting the clustering coefficient distribution
figure();
plot(deg, cc, '.');
title('Distribution of Clustering coefficient C(k) vs k');
xlabel('Degree (k)');
ylabel('Clustering Coefficient C(k)');