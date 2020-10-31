% solver used: gurobi

clear;

model = readCbModel('iIT341.xml', 'fileType','SBML');
sol = optimizeCbModel(model);


% D-Glucose exchange reaction is 96th reaction
glu_model = model;
glu_model.lb(96) = -10;
glu_sol = optimizeCbModel(glu_model);

% D-Galactose exchange reaction is 95th reaction
gal_model = model;
gal_model.lb(95) = -10;
gal_sol = optimizeCbModel(gal_model);

% D-Glucose, D-Galactose model
glu_gal_model = model;
glu_gal_model.lb(95:96) = -10;
glu_gal_sol = optimizeCbModel(glu_gal_model);

% Build the reaction gene matrix needed for FastSL_dg
model = buildRxnGeneMat(model);
glu_model = buildRxnGeneMat(glu_model);
gal_model = buildRxnGeneMat(gal_model);
glu_gal_model = buildRxnGeneMat(glu_gal_model);

% Double gene deletions
[sgd, dgd] = fastSL_dg(model, 0.05);
[glu_sgd, glu_dgd] = fastSL_dg(glu_model, 0.05);
[gal_sgd, gal_dgd] = fastSL_dg(gal_model, 0.05);
[glu_gal_sgd, glu_gal_dgd] = fastSL_dg(glu_gal_model, 0.05);
