function setVars(truss_obj)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %Use 6,100,100 for testing??
    truss_obj.mat_cnxsEval = zeros(truss_obj.int_njts,truss_obj.int_njts*2-3);
    int_numjoints = truss_obj.int_njts;
    truss_obj.intvec_xRxn = zeros(int_numjoints, 3);
    truss_obj.intvec_xRxn(1,1) = 1;
    truss_obj.intvec_yRxn = zeros(int_numjoints, 3);
    truss_obj.intvec_yRxn(1,2) = 1;
    truss_obj.intvec_yRxn(2,3) = 1;
    truss_obj.int_loadJoint = 3; %3 for now, change up later
    truss_obj.intvec_loadSim = zeros(int_numjoints*2,1);
    truss_obj.intvec_loadSim(int_numjoints+3) = 1;
end