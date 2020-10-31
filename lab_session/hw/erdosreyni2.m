function[G]=erdosreyni2(n,p)
    am1 = triu(rand(n,n),1);
    am1(am1>p) = 0;
    am1(am1~=0) = 1;
    am1 = am1 + am1';
    G=graph(am1);
    plot(G)
end