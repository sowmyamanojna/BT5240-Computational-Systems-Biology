load('ecoli_model.mat')
%%
% Question 1
sol = optimizeCbModel(model);

%%
% Question 2
% Single Lethal Reactions
% [grRatio, grRateKO, grRateWT, hasEffect, delRxn, fluxSolution] = singleRxnDeletion(model);
grRatio = singleRxnDeletion(model);
slRxnsPos = find(grRatio == 0);
slRxns = model.rxns(slRxnsPos);

%[grRatio, grRateKO, grRateWT, hasEffect, delRxns, fluxSolution] = singleGeneDeletion(model);
grRatio = singleGeneDeletion(model);
slGenesPos = find(grRatio < 10^-8);
slGenes = model.genes(slGenesPos);

%%
% Question 3
excRxns = model.rxns(findExcRxns(model));
% acetate - 20
% succinate - 39
ac_model = model;
ac_model.lb(28) = 0;
ac_model.lb(20) = -10;
ac_sol = optimizeCbModel(ac_model);

succ_model = model;
succ_model.lb(39) = 0;
succ_model.lb(20) = -10;
succ_sol = optimizeCbModel(succ_model);

%%
% Question 4
% FRD7 - rxn number 44

[minF, maxF] = fluxVariability(model, 100, 'max', {'FRD7'});

%%
% Question 5

ox_model = changeRxnBounds(model, model.rxns(36), -17);
fValues = [];
for glc = -2000:10:0
    ox_model.lb(28) = glc;
    ox_sol = optimizeCbModel(ox_model);
    fValues = [fValues; ox_sol.f];
end

