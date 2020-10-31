clear all; close all;
% Constructing graph of Network A
nodes = 100;
deg = 6;
k = deg/2;

A = zeros(nodes, nodes);
for i = 1:nodes-k
    A(i,i+1:i+k) = 1;
end

for i = nodes-k+1:nodes
    A(i, i+1:nodes) = 1;
    A(i, 1:k-nodes+i) = 1;
end
B = A;
A = A + A';

gA= graph(A);
figure();
plot(gA);
title('Graph of Network A');


p = input('Enter probability of rewiring: ');
for i = 1:nodes
    r = rand(1, nodes);
    swap = rand(1,k)<p;
    nodes_connected = find(B(i,:) == 1);
    nodes_swap = swap.*nodes_connected;
    
    r(i) = 0;
    r(find(B(:,i)==1)) = 0;
    [~, idx] = sort(r, 'descend');
    B(i, nonzeros(nodes_swap)) = 0;
    B(i, idx(1:nnz(swap))) = 1;
end

B = B + B';

gB = graph(B);
figure();
plot(gB);
title('Graph of Network B');

asp = all_shortest_paths(sparse(A));
bsp = all_shortest_paths(sparse(B));

aN = min(sum(asp ~= Inf));
bN = min(sum(bsp ~= Inf));

asp(asp == Inf) = 0;
bsp(bsp == Inf) = 0;

aDia = max(max(asp));
bDia = max(max(bsp));

fprintf('Diameter of Network A: %d\n', aDia)
fprintf('Diameter of Network B: %d\n', bDia)

asp = triu(asp, 1);
bsp = triu(bsp, 1);

aCPL = 2*sum(asp(:))/(aN*(aN-1));
bCPL = 2*sum(bsp(:))/(bN*(bN-1));

fprintf('Characteristic path length of Network A: %4.6f\n', aCPL)
fprintf('Characteristic path length of Network B: %4.6f\n', bCPL)

adeg = sum(A);
bdeg = sum(B);

aCC = clustering_coefficient(nodes, adeg, sparse(A));
bCC = clustering_coefficient(nodes, bdeg, sparse(B));

fprintf('Global clustering coefficient of Network A: %4.6f\n', mean(aCC))
fprintf('Global clustering coefficient of Network B: %4.6f\n', mean(bCC))

figure();
hist(adeg, max(bdeg)-min(bdeg)+1, 'EdgeColor','k')
title('Degree distribution of Network A N(k) vs k')
xlabel('Degree (k)')
ylabel('Number of nodes with degree k (N(k))')

figure();
hist(bdeg, max(bdeg)-min(bdeg)+1, 'EdgeColor','k')
title('Degree distribution of Network B N(k) vs k')
xlabel('Degree (k)')
ylabel('Number of nodes with degree k (N(k))')