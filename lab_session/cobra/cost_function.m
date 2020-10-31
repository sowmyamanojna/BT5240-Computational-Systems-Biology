function cost = cost_function( P, flag)
data = readmatrix('pestim_data.txt');

V_max = P(1);
K_m =  P(2);
K_I = P(3);

data = [data, 10*ones(20,1), 20*ones(20,1)];

S = data(:,1);
switch flag
    case 1
        v = data(:,2);
        I = data(:,4);
    case 2
        v = data(:,3);
        I = data(:,5);
    case 3
        v = [data(:,2), data(:,3)];
        I = [data(:,4), data(:,5)];
end

v_pred = V_max*S./(K_m*(1 + I/K_I) + S);

cost = sum(sum(((v - v_pred)./v).^2));

end
