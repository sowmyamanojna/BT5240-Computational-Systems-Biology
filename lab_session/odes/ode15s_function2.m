function xdot = ode15s_function2%(t, g, atp)
   k1 = 0.02;
   kp = 6;
   km = 13;
   vm = 0.036;
   
   syms g atp
   
   atpdot = 2*k1*g*atp - kp*atp/(atp+km);
   gdot = vm - k1*g*atp
   
   jack = jacobian([atpdot, gdot], [atp, g]);
   
   eig_vals = eig(jack)
   
   S = solve([atpdot, gdot])
   
   subs(eig_vals, S)

end