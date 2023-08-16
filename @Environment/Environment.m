classdef Environment < handle
    %ENVIRONMENT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        population;
        popsize
        critFunct
        costFunct
        stepNum
        lengthLimits
        jointRange
        mode
        budget
        xlimit
        ylimit
        flt_lastHighScore
        global_glob
    end

    methods
        function obj = Environment(popSize, lengthLims, critFunct, costFunct, xlimit, ylimit, glob, budget,mode)
            %lengthLims[min,max]
            %pin -> [xpos, ypos], roller -> [xpos, ypos, angle], load -> [xpos, ypos, dir]
            obj.population = Truss(6,50,50,glob);
            obj.global_glob = glob; % So the environment can manage heat. 
            obj.budget = budget;
            obj.critFunct = critFunct;
            obj.costFunct = costFunct;
            obj.popsize = popSize;
            obj.xlimit = xlimit;
            obj.ylimit = ylimit;
            obj.lengthLimits = lengthLims;
            obj.jointRange(1) = floor(abs(glob.fltvec_roller(1)-glob.fltvec_pin(1))/lengthLims(2)*1.5+7);
            obj.jointRange(2) = ceil(abs(glob.fltvec_roller(1)-glob.fltvec_pin(1))/lengthLims(2)*3 + 5);
            obj.stepNum = 0;
            obj.mode = mode;
            obj.flt_lastHighScore = -99999;
            for ii = 1:popSize
                njts = randi([obj.jointRange]);
                obj.population(ii) = Truss(njts,xlimit,ylimit,glob);
            end
            % Initial Scoring and Ranking
            obj.scorePop;
            obj.rankPop;
        end
    end
end