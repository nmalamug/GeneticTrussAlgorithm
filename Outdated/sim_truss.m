%Truss Function
function [] = sim_truss(C,Sx,Sy,X,Y,L)
    [jt,mem] = size(C);
    Cx = C;
    Cy = C;

    jind = zeros(2,1);

    cost = (10*jt); %Initial cost calculation
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
        cost = cost + span; %add the cost of the member
        pcrit(m) = span;
    end
    pcrit = -4338./(pcrit.^2.125);%Get the failure values for all members

    A = [Cx Sx; Cy Sy];
    T = (A^-1)*L;
    Tmem = T(1:mem)'; %isolate members

    failure = Tmem./pcrit; %How close each member is to failure - ratio. 
    [top,topjoint] = max(failure); %Which member has the most strain relative to failing load?

    failload = (1/failure(topjoint))*max(L); % Multiplier to maxload * current load. 
    
    count = 1;
    for j = 1:jt
        if C(j,topjoint) == 1
            jind(count) = j;
            count = count + 1;
        end
    end
    failmem = strcat(num2str(jind(1)-1),'-',num2str(jind(2)-1));
    
    fprintf('\nEK301, Section A2, Harman Singh, Nicolas Malamug, 11/11/2022\n')
    fprintf('Load: %.2f oz \n\n',max(L))
    fprintf('Member force in oz\n')
    for i = 1:length(Tmem)
        fprintf('m%.0f: %.2f  ',i,Tmem(i))
        if Tmem(i)<0
            fprintf('(C)')
        end
        if Tmem(i)>0
            fprintf('(T)')
        end
        fprintf('\n')
    end
    fprintf('\nReaction Forces(oz):\n')
    fprintf('Sx1: %.2f\n',T(mem+1))
    fprintf('Sy1: %.2f\n',T(mem+2))
    fprintf('Sy2: %.2f\n\n',T(mem+3))

    fprintf('Cost of Truss ($): %.2f \n',cost)
    fprintf('Theoretical max load (oz): %.2f \n',failload)
    fprintf('Theoretical max load/cost ratio (oz/$): %.4f \n',failload/cost)
    fprintf('Failing Member(Nodes) %s, m%.0f \n\n',failmem,topjoint)
end