function graphTruss(truss_obj)
    % graph points between every member. 
    %Make sure hold is on.
    clf
    hold on
    for ii = 1: length(truss_obj.fltvec_x)-1
        for jj = ii+1:length(truss_obj.fltvec_x)
            if(truss_obj.mat_cnxs(ii,jj) == 1)
                plot([truss_obj.fltvec_x(ii),truss_obj.fltvec_x(jj)] , [truss_obj.fltvec_y(ii),truss_obj.fltvec_y(jj)], "k")
            end
        end
    end
    plot(truss_obj.fltvec_x(1), truss_obj.fltvec_y(1), "+", 'MarkerSize', 10, 'LineWidth',1.5, 'Color', "r")
    plot(truss_obj.fltvec_x(2), truss_obj.fltvec_y(2), "o", 'MarkerSize', 10, 'LineWidth',1.5, 'Color', "b")
    plot(truss_obj.fltvec_x(3), truss_obj.fltvec_y(3), "V", 'MarkerSize', 10, 'LineWidth',1.5, 'Color', "m")
    hold off
    limit = max(truss_obj.flt_xlimit,truss_obj.flt_ylimit);
    axis([0,limit, 0, limit]);
end