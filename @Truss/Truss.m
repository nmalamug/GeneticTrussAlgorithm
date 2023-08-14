%Class Folder
classdef Truss < handle
    %UNTITLED Summary of this class goes here
    %   A class which creates a truss

    properties
        mat_cnxs
        mat_cnxsEval
        mat_cnxsFrame
        int_njts
        fltvec_x
        fltvec_y
        intvec_xRxn
        intvec_yRxn
        int_loadJoint
        intvec_loadSim
        flt_maxLoad
        flt_cost
        flt_score
        fltvec_lengths
        flt_xlimit
        flt_ylimit
        pin
        roller
        load
    end

    methods
        %Constructor
        function obj = Truss(numjoints, xlimit, ylimit, pin, roller, load, xcoords,  ycoords,cnxs) %Add min distance apart\
            %pin -> [xpos, ypos], roller -> [xpos, ypos, angle], load -> [xpos, ypos, dir]
            %Define the joint positions of the truss
            obj.flt_xlimit = xlimit;
            obj.flt_ylimit = ylimit;
            obj.pin = pin;
            obj.roller = roller;
            obj.load = load;
            obj.int_njts = numjoints;
            switch nargin
                case 0
                    return
                case 6
                    %If not coordinates are given, create them.
                    setVars(obj);
                    defineJoints(numjoints, xlimit, ylimit, pin, roller, load, obj)
                case 8 %When making child or when coords predefined
                    obj.fltvec_x = xcoords;
                    obj.fltvec_y = ycoords;
                    obj.mat_cnxs = zeros(obj.int_njts);
                    setVars(obj);%Change when adding direction to sin and cos
                    %Maybe try to determine these in the environment instead?
                    getCnxsMJ(obj);

                case 9
                    obj.fltvec_x = xcoords;
                    obj.fltvec_y = ycoords;
                    obj.mat_cnxs = cnxs;
                    setVars(obj); %Change when adding direction to sin and cos
                    getCnxsMJ(obj);
                    return
                    %Maybe try to determine these in the environment instead?                
            end
            genTruss(numjoints,obj) %Takes a set of defined points, makes a truss
        end
    
    end
    %End Methods
end
%End Class