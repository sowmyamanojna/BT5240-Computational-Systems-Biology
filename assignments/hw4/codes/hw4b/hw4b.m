% solver used: gurobi
clear;

load('iAF1260.mat')
model = iAF1260;

sol = optimizeCbModel(model);
[~, RxnClasses, ~] = pFBA(model);

fprintf("\nPruning Stage 1...")
fprintf("\nSize of model reactions obtained so far: %d\n", numel(model.rxns));
removed_blocked_rxns = removeRxns(model, RxnClasses.Blocked_Rxns);
removed_zero_rxns = removeRxns(removed_blocked_rxns, RxnClasses.ZeroFlux_Rxns);
removed_MLE_rxns = removeRxns(removed_zero_rxns, RxnClasses.MLE_Rxns);
removed_ELE_rxns = removeRxns(removed_MLE_rxns, RxnClasses.ELE_Rxns);

%%

removable_rxns = [];
model_list = [];
f_list = [];

size_list = [];

fprintf("\nPruning Stage 2...")
fprintf("\nSize of pruned model reactions obtained so far: %d\n", numel(removed_ELE_rxns.rxns));

reactions = [RxnClasses.pFBAOpt_Rxns];

for rxn = reactions'
    min_model = removeRxns(removed_ELE_rxns, rxn);
    min_sol = optimizeCbModel(min_model);
    
    if ~isnan(min_sol.f) && (min_sol.f >= sol.f*0.95) && (min_sol.stat == 1)
        s = optimizeCbModel(min_model);

        min_model = removeRxns(min_model, min_model.rxns(s.v == 0));        
        min_sol = optimizeCbModel(min_model);
        
        size_list = [size_list; numel(min_model.rxns)];
        model_list = [model_list; min_model];
        f_list = [f_list; min_sol.f];
        
    end
end

%%

size_list2 = [];
model_list2 = [];
grRatio_list = [];

min_react_models = model_list(size_list == min(size_list));

fprintf("\nPruning Stage 3...\n")
fprintf("Size of pruned model reactions obtained so far: %d\n", min(size_list));

for mr_model = min_react_models'
    [grRatio, ~, ~, hasEffect, ~, ~] = singleRxnDeletion(mr_model);
    
    fprintf("Size of reducable reactions: %d\n", sum(hasEffect == 0));
    
    mr_model = removeRxns(mr_model, mr_model.rxns(hasEffect == 0));
    s = optimizeCbModel(mr_model);
    if ~isnan(s.f) && (s.f >= sol.f*0.95) && (s.stat == 1)
        size_list2 = [size_list2; numel(mr_model.rxns)];
        model_list2 = [model_list2; mr_model];
        grRatio_list = [grRatio_list, grRatio];
    end
end

%%

size_list3 = [];
size_list4 = [];

reaction_list = [];
mr_models = [];

fprintf("\nPruning Stage 4...\n")
fprintf("Size of pruned model reactions obtained so far: %d\n", min(size_list2));

i = 1;

for mr_model = model_list2(size_list2 == min(size_list2))'
    grRatio = grRatio_list(:, i);
    fprintf("Size of (probable) reducable reactions: %d\n", sum(grRatio > 0.05));
  
    for rxn = mr_model.rxns(grRatio > 0.05)'
        fprintf("\nReaction %s\n", char(rxn));
        
        mr = removeRxns(mr_model, rxn);
        s = optimizeCbModel(mr);
        if ~isnan(s.f) && (s.f >= sol.f*0.95) && (s.stat == 1)
            fprintf("Size of reduced model reactions: %d\n", numel(mr.rxns));
            reaction_list = [reaction_list; rxn];
            size_list3 = [size_list3; numel(mr.rxns)];
            mr_models = [mr_models; mr];
        end
        
        [ratio, ~, ~, ~, ~, ~] = singleRxnDeletion(mr);
        while (sum(ratio>0.05)>0) && ~isnan(s.f) && (s.f >= sol.f*0.95) && (s.stat == 1)
            for r = mr_model.rxns(grRatio > 0.05)
                mr = removeRxns(mr_model, r);
                s = optimizeCbModel(mr);
                size_list4 = [size_list4; numel(mr.rxns)];
                [ratio, ~, ~, ~, ~, ~] = singleRxnDeletion(mr);
            end
        end
    end
    i = i+1;
end

%%

% As the reaction removeed in the reaction_list are all ATPM, 
% the minimal reactome  is the one obtained in Step 3

minimalReactome = model_list2(size_list2 == min(size_list2));
