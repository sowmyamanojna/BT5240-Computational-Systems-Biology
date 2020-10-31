g0 = 0;
ti = 0;
tf = 100;
time = [ti tf];
[t,x] = ode15s(@ode15s_function, time, g0);