function error = state_error(mrp_BN, B_omega_BN, RN, N_omega_RN)

mrp_RN = dcm2mrp(RN);
mrp_NR = -mrp_RN;

mrp_BR = add_mrp(mrp_BN,mrp_NR);   



%%
BN = mrp2dcm(mrp_BN);

B_omega_NR = -BN*N_omega_RN;   %%%%%%%corrected 13 march all task 6 working

% RN is in inertial frame 
%needs to ratotated into N frame by BN matrix....march 13


%%
B_omega_BR = B_omega_BN + B_omega_NR;



error = [mrp_BR;B_omega_BR];





end