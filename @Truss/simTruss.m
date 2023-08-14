function simTruss(truss_obj,fltvec_critFunct, fltvec_costFunct)
    %critFunct 1 is the coefficient, critFunct 2 is the power. 
    %costFunct 1 is the cost of each joint, costFunct 2 is the cost per
    %unit length. 

    %Put parameters together to retrofit function
    C = truss_obj.mat_cnxsEval;
    [jt,mem] = size(C);
    Cx = C;
    Cy = C;
    jind = zeros(2,1);
    X = truss_obj.fltvec_x;
    Y = truss_obj.fltvec_y;
    Sx = truss_obj.intvec_xRxn;
    Sy = truss_obj.intvec_yRxn;
    L = zeros(1,jt*2);
    L(1,truss_obj.int_loadJoint+jt) = 1;
    L = L';

    cost = (fltvec_costFunct(1)*jt); %Initial cost calculation
    pcrit = zeros(1,mem);
    for m = 1:mem %loop through members
        count = 1;
        for j = 1:jt
            if Cx(j,m) == 1
                jind(count) = j;
                count = count + 1;
            end
        end
        span = sqrt((X(jind(2))-X(jind(1)))^2 +(Y(jind(2))-Y(jind(1)))^2); %Length of the member
        
        Cx(jind(1),m) = (X(jind(2))-X(jind(1)))/span; %For each, calculate force ratio
        Cx(jind(2),m) = (X(jind(1))-X(jind(2)))/span;
        Cy(jind(1),m) = (Y(jind(2))-Y(jind(1)))/span;
        Cy(jind(2),m) = (Y(jind(1))-Y(jind(2)))/span;
        cost = cost + fltvec_costFunct(2)*span; %add the cost of the member
        pcrit(m) = fltvec_critFunct(1)/(span^fltvec_critFunct(2));
        truss_obj.fltvec_lengths(m) = span;
    end

    A = [Cx Sx; Cy Sy];
    T = (A^-1)*L;
    Tmem = T(1:mem)'; %isolate members

    failure = Tmem./pcrit; %How close each member is to failure - ratio. 
    [top,topjoint] = max(failure); %Which member has the most strain relative to failing load?

    truss_obj.flt_maxLoad = (1/failure(topjoint)); % Multiplier to maxload * current load. 
    truss_obj.flt_cost = cost;