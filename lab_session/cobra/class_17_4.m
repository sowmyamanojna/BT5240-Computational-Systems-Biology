clear;
load('iAF1260.mat');
model = iAF1260;
sol = optimizeCbModel(model);
opti = sol.f;

bio_pos = find(model.c);
list = [0.05:0.05:1];

% 965 
% 884
n = 1503;
prod_name = model.rxnNames(n);
prod_ub = model.ub(n);

v_list = [];
x_axis = [];

for factor = list
    test = model;
    test.ub(n) = factor;
    test.lb(n) = factor;
    test_sol = optimizeCbModel(test);
    if test_sol.stat == 1
        v_list = [v_list test_sol.v];
        x_axis = [x_axis; factor];
    end
end


for j = 1:10
    figure
    hold on
    lst = [];
    for i = 200*(j-1)+1:200*j
        if v_list(i, :) ~= 0
        i
        plot(x_axis, v_list(i, :))
        str = string(i) + " " + string(model.rxnNames(i));
        lst = [lst; str];
        end
        legend(lst)
    end
end


