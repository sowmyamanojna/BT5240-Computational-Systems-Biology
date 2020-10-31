function cc = clustering_coefficient(nodes, deg, A)
    cc = zeros(nodes, 1);
    for i = 1:nodes
        ci1 = find(A(i, :) == 1);
        cn1 = A(i, :);
        triangles = 0;
        for j = ci1
           cn2 = A(j, :);
            triangles = triangles + sum((cn2 == cn1) & (cn1 == 1));
        end
        cc(i) = triangles/(size(ci1, 2)*(size(ci1, 2)-1));
    end
    cc(isnan(cc)) = 0;
end