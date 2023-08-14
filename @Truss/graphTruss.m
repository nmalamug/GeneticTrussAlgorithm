function graphTruss(truss_obj)
    % graph points between every member. 
    %Make sure hold is on.
    clf
    hold on
    for ii = 1: length(truss_obj.fltvec_x)-1
        for jj = ii+1:length(truss_obj.fltvec_x)
            if(truss_obj.mat_cnxs(ii,jj) == 1)
                plot([truss_obj.fltvec_x(ii),truss_obj.fltvec_x(jj)] , [truss_obj.fltvec_y(ii),truss_obj.fltvec_y(jj)])
            end
        end
    end
    hold off
    limit = max(truss_obj.flt_xlimit,truss_obj.flt_ylimit);
    axis([0,limit, 0, limit]);
end