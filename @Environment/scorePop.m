function scorePop(env_obj)
%SCOREPOP Gets load, cost, load/cost, and scores trusses accordingly
    %Simulate and score all of the trusses
    for i = 1:env_obj.popsize
        env_obj.population(i).simTruss(env_obj.critFunct,env_obj.costFunct);
        %Start Calculating Score
        %Add points for max load and cost
        switch env_obj.mode
            case 1
                score = env_obj.budget*10*env_obj.population(i).flt_maxLoad/env_obj.population(i).flt_cost;

            case 2
                score = 10*env_obj.population(i).flt_maxLoad;
        end
        cost = env_obj.population(i).flt_cost;
        budget = env_obj.budget;
        %Take away points for being over budget
        if(cost>budget)
            score = score - 50;
            score = score - 2*(cost-env_obj.budget);
        end
        %Take away points for being outside of bounding box
        for j = 1:(env_obj.population(i).int_njts)
            if((env_obj.population(i).fltvec_x(j) > env_obj.xlimit) || (env_obj.population(i).fltvec_x(j) <0))
                score = score - 100;
            end
            if((env_obj.population(i).fltvec_y(j) > env_obj.ylimit) || (env_obj.population(i).fltvec_y(j) <0))
                score = score - 100;
            end            
        end

        %Take away points for member length restraints
        for j = 1:(env_obj.population(i).int_njts*2 - 3)
            if(env_obj.population(i).fltvec_lengths(j)<env_obj.lengthLimits(1))
                score = score - 100;
                %Maybe some other condition?
            end
            if(env_obj.population(i).fltvec_lengths(j)>env_obj.lengthLimits(2))
                score = score - 100;
            end
        end

        %Set the final score
        env_obj.population(i).flt_score = score;
        if(isnan(score))
            env_obj.population(i).score = -99999;
        end
    end

end