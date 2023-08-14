function defineJoints(int_numjoints, flt_xlimit, flt_ylimit, fltvec_pin, fltvec_roller, fltvec_load, truss_obj)

    %Connections matrix - Column is joint #, row is connections to it.
    truss_obj.mat_cnxs = zeros(int_numjoints);
    truss_obj.fltvec_x = flt_xlimit*rand(1,int_numjoints);
    truss_obj.fltvec_y = flt_ylimit*rand(1,int_numjoints);

    %Define the points for the pin and roller
    truss_obj.fltvec_x(1:3) = [fltvec_pin(1), fltvec_roller(1), fltvec_load(1)];
    truss_obj.fltvec_y(1:3) = [fltvec_pin(2), fltvec_roller(2), fltvec_load(2)];

end