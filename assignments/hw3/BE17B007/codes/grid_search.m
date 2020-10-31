P1 = 0:10;
P2 = 0:10;
P3 = 0:10;
flag = 1;

cost_hist = zeros(11, 11, 11);

for p1 = P1
    for p2 = P2
        for p3 = P3
            cost_hist(p1+1, p2+1, p3+1) = cost_function([p1, p2, p3], flag);
        end
    end
end
