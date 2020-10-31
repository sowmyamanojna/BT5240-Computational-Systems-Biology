x0 = 0;
ti = 0;
tf = 30;
time = [ti tf];
[t,x] = ode15s(@ode15s_function, time, x0);