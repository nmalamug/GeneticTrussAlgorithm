function genTruss(int_numjoints,truss_obj)
%Takes a given set of points and constructs a truss around them

%Calculate all of the angles relative to the centerpoint
    %FIXME Make centerpoint go between 2 random members. 
    flt_xavg = mean(truss_obj.fltvec_x);
    flt_yavg = mean(truss_obj.fltvec_y);
    flt_theta = zeros(2,int_numjoints);
    for ii = 1:int_numjoints
        if((truss_obj.fltvec_x(ii)-flt_xavg)>0)
            flt_theta(1,ii) = atan((truss_obj.fltvec_y(ii)-flt_yavg)/(truss_obj.fltvec_x(ii)-flt_xavg));
        else
            flt_theta(1,ii) = pi+atan((truss_obj.fltvec_y(ii)-flt_yavg)/(truss_obj.fltvec_x(ii)-flt_xavg));
        end
        flt_theta(2,ii) = ii;
    end
    
    %Sort the thetas by ascending order, with tags for joint number.
    flt_theta = sortrows(flt_theta',1)';
    
    %Update the connections matrices
    %For all intents and purposes, you got the outside of the truss. 
    truss_obj.mat_cnxs(flt_theta(2,1),flt_theta(2,int_numjoints)) = 1;
    truss_obj.mat_cnxs(flt_theta(2,int_numjoints),flt_theta(2,1)) = 1;
    for ii = 1:int_numjoints-1
        truss_obj.mat_cnxs(flt_theta(2,ii),flt_theta(2,ii+1)) = 1;
        truss_obj.mat_cnxs(flt_theta(2,ii+1),flt_theta(2,ii)) = 1;
    end
    
    %Exterior connections
    mat_cframe = truss_obj.mat_cnxs;
    
    %Number of members currently equals number of joints
    numMembers = int_numjoints;
    
    %Start making internal connections
    while numMembers < 2*int_numjoints - 3
        j1 = randi(int_numjoints);
        j2 = randi(int_numjoints);
    
        if(j1 ~= j2 && isValid(j1,j2,truss_obj.mat_cnxs,truss_obj.fltvec_x,truss_obj.fltvec_y,flt_xavg,flt_yavg,mat_cframe))
            truss_obj.mat_cnxs(j1,j2) = 1;
            truss_obj.mat_cnxs(j2,j1) = 1;
            numMembers = numMembers+1;
        end
        %Check if the connection is not to any already connected points
        %If it is, go the the next point. 
        %If it isn't check to see if the connection intersects any existing
        %connections. 
        %If not, add it to the matrix, 
    end
    truss_obj.getCnxsMJ()
end