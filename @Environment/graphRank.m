function graphRank(obj,rank)
%Graphs the truss at a specified rank, if no rank given, graph best. 
    switch nargin
        case 1
            obj.population(1).graphTruss
            text = strcat("Gen ", int2str(obj.stepNum), ", Rank 1" );

        case 2
            obj.population(rank).graphTruss
            text = strcat("Gen ", int2str(obj.stepNum), ", Rank ", int2str(rank));

    end
    title(text);
end