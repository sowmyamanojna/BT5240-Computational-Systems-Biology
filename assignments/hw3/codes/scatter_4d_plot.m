function scatter_4d_plot(threshold, P_hist, val_hist)
loc = find(val_hist < threshold)
P_valid = P_hist(:,loc)

P1 = P_valid(1,:);
P2 = P_valid(2,:);
P3 = P_valid(3,:);

scatter3(P1, P2, P3, 1000, val_hist(val_hist<threshold))
cb = colorbar;
cb.Label.String = 'Cost';
title('Cost function distrubution across parameter space');
xlabel('p1 parameter space');
ylabel('p2 parameter space');
zlabel('p3 parameter space');
end