function newobj = mkChild(truss_obj)
% This function is definitely messy, but there are a lot of plans in the
% work to fix and improve this. 


newX = truss_obj.fltvec_x;
newY = truss_obj.fltvec_y;
nLoads = 1;
nMovable = truss_obj.int_njts - nLoads - 2;
nMoving = 7*randi(nMovable);
sigmaX = truss_obj.flt_xlimit/40;
sigmaY = truss_obj.flt_ylimit/40;

%MKCHILD Makes a child of the current truss based on the aspects of the
%current truss. 

%Pick a random set of joints to move.
%Move those joints. 
%Right now assumes the number of loads is 1. 

for i = 1:nMoving
    targetJt = randi([3+nLoads, truss_obj.int_njts]);
    newX(targetJt) = normrnd(newX(targetJt),sigmaX);
    newY(targetJt) = normrnd(newY(targetJt),sigmaY);
end

%Ask if we want to add, remove, or stay same?
%Do the process of adding/removing
genJoint = randi([1,100]);
if(genJoint < 10)
    if(truss_obj.int_njts > 3+nLoads)
        genJoint = -1;
        %Pick a joint to delete
        tar = randi([3+nLoads, truss_obj.int_njts]);
        %Delete that joint
        newX(tar) = [];
        newY(tar) = [];
        %Attempt to resolve truss if target is 0 force member. 
        if(sum(truss_obj.mat_cnxs(:, tar)) == 2)
            new_cnxs = truss_obj.mat_cnxs;
            where_to = [0 0];
            count = 1;
            for ii = 1:truss_obj.int_njts
                if(truss_obj.mat_cnxs(ii,tar) == 1)
                    where_to(count) = ii;
                    count = count + 1;
                end
            end
            new_cnxs(where_to(1), where_to(2)) = 1;
            new_cnxs(where_to(2), where_to(1)) = 1;
            new_cnxs(tar,:) = [];
            new_cnxs(:,tar) = [];
            newNjts = truss_obj.int_njts + genJoint;
            newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY, new_cnxs);
        else
            newNjts = truss_obj.int_njts + genJoint;
            newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY);
        end
    else
        genJoint = 0;
        newNjts = truss_obj.int_njts + genJoint;
        newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY,truss_obj.mat_cnxs);
    end
elseif(genJoint < 40)
    genJoint = 0;
    newNjts = truss_obj.int_njts + genJoint;
    newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY,truss_obj.mat_cnxs);

elseif(genJoint < 80)
    genJoint = 1;
    newX(truss_obj.int_njts+1) = truss_obj.flt_xlimit*rand();
    newY(truss_obj.int_njts+1) = truss_obj.flt_ylimit*rand();
    newNjts = truss_obj.int_njts + genJoint;
    newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY);
else
    genJoint = 2;
    newX(truss_obj.int_njts+1) = truss_obj.flt_xlimit*rand();
    newY(truss_obj.int_njts+1) = truss_obj.flt_ylimit*rand();
    newX(truss_obj.int_njts+2) = truss_obj.flt_xlimit*rand();
    newY(truss_obj.int_njts+2) = truss_obj.flt_ylimit*rand();
    newNjts = truss_obj.int_njts + genJoint;
    newobj = Truss(newNjts, truss_obj.flt_xlimit, truss_obj.flt_ylimit, truss_obj.global_glob, newX, newY);
end


%Once the points are changed, pass the paramters to the next truss, and
%have it generate things. 
end