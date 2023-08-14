classdef Environment < handle
    %ENVIRONMENT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        population = Truss(6,50,50,[0,0],[50,0],[25,0,-90]);
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
        int_heat
        flt_lastHighScore
    end

    methods
        function obj = Environment(popSize, lengthLims, critFunct, costFunct, xlimit, ylimit, pin, roller, load, budget,mode)
            %lengthLims[min,max]
            %pin -> [xpos, ypos], roller -> [xpos, ypos, angle], load -> [xpos, ypos, dir]
            obj.budget = budget;
            obj.critFunct = critFunct;
            obj.costFunct = costFunct;
            obj.popsize = popSize;
            obj.xlimit = xlimit;
            obj.ylimit = ylimit;
            obj.lengthLimits = lengthLims;
            obj.jointRange(1) = floor(abs(roller(1)-pin(1))/lengthLims(2)*1.5+3);
            obj.jointRange(2) = ceil(abs(roller(1)-pin(1))/lengthLims(2)*3 + 3);
            obj.stepNum = 0;
            obj.mode = mode;
            obj.int_heat = 0;
            obj.flt_lastHighScore = -99999;
            for ii = 1:popSize
                njts = randi([obj.jointRange]);
                obj.population(ii) = Truss(njts,xlimit,ylimit,pin,roller,load);
            end
        end
    end
end