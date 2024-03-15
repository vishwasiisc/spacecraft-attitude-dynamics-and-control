function zdot = rhs_dynamics(t,z,p)



omegadot = dynamics(t,z,p);


zdot = [omegadot];
end
