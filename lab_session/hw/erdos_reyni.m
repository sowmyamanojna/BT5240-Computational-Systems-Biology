function A = erdos_reyni(n, p)
    A = tril(rand(n), -1);
    A(A>p) = 0; A(A>0) = 1;
    A = A+A';
end