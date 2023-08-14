function getCnxsMJ(truss_obj)
%GETCNXSMJ Convert the current C matrix into one usable by the simulation
%program. Do this before evaluating
    int_count = 1;
    truss_obj.mat_cnxsEval = zeros(truss_obj.int_njts,truss_obj.int_njts*2-3);
    for ii = 1: length(truss_obj.fltvec_x)-1
        for jj = ii+1:length(truss_obj.fltvec_x)
            if(truss_obj.mat_cnxs(ii,jj) == 1)
                %Found a member, make those joints
                truss_obj.mat_cnxsEval(ii,int_count) = 1;
                truss_obj.mat_cnxsEval(jj,int_count) = 1;
                int_count = int_count + 1;
            end
        end
    end
end