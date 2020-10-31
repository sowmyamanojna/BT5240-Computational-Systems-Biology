% fit_parameters - 
% script that executes fminsearch to optimise the cost function called
% 
% INPUTS: none
% 
% VARIABLES:
% P - column vector of [p1, p2, p3]' in the same order
% P_hist - stores all the values of P returned after optimisation
% P_0 - initial values of P sent 
% P0_hist - stores all the values of P0 passed for optimisation
% val - optimum cost function value returned by fminsearch
% val_hist - stores all optimum cost function values returned by fminsearch
% n - number of iteration (each starting with a random P0 - rand(3,1))
% flag - determines the dataset to be used:
%        1: dataset 1
%        2: dataset 2
%        3: dataset 3

clear;

n = 1;
P0_hist = zeros(3, n);
P_hist = zeros(3, n);
val_hist = zeros(n,1);
flag = 1;

fprintf('Running %d iterations on dataset %d \n', n, flag);
for i = 1:n
    P0 = rand(3,1);
    fprintf('Initial paramaters: [%f, %f, %f] \n', P0(1), P0(2), P0(3));
    [P, val] = fminsearch(@(P) cost_function(P, flag), P0);
    fprintf('Paramaters after optimization: [%f, %f, %f] \n', P(1), P(2), P(3));
    fprintf('Cost: %f\n', val);
    P_hist(:,i) = P;
    P0_hist(:,i) = P0;
    val_hist(i) = val;
end