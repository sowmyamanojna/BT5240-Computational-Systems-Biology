function xdot = ode15s_function(t, x)
    a = 2;
    b = 3;
    
    xdot = a - b*x;
end