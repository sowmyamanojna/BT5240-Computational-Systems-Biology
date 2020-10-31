load('iAF1260.mat')
sol = optimizeCbModel(iAF1260);

norm(sol.x)
sol.f

sol2 = optimizeCbModel(iAF1260, 'max', 'one');
norm(sol2.x)

%%
load('ecoli_model.mat')

sol3 = optimizeCbModel(model);
singleGeneDeletion
singleRxnDeletion