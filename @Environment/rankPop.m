function rankPop(obj)
%RANKPOP Ranks the population by score.
%Last object has the highest score
    [~, ind] = sort([obj.population.flt_score],'descend');
    population_sorted = obj.population(ind);
    obj.population = population_sorted;
end