dirCurr = pwd;
dirTruss = strcat(dirCurr, '/aTrussSubfunctions');
addpath(dirTruss,'-end');
%{
%Truss(numjts, xbound, ybound, pinLocation, rollerLocation, loadLocation/Direction)
newtruss = Truss(6,50,50,[0,0],[50,0],[25,0,-90]);
figure(1)
newtruss.graphTruss
%sim_truss(newtruss.cnxsEval, newtruss.xRxn, newtruss.yRxn, newtruss.x, newtruss.y, newtruss.loadSim)
newtruss.simTruss([-2945,2],[10,1]);
newtruss
child = newtruss.mkChild;
figure(2)
child.graphTruss
child.simTruss([-2945,2],[10,1]);
child
%newtruss.test()
%}
clf
figure(1)
xlim([0,50])
ylim([0,50])
env1 = Environment(150, [8,15], [-4338,2.125], [10,1], 50, 20,[10,0],[44,0],[29,0,-90],325,2)
for i = 1:1000
    env1.stepGen(1);
    if(mod(i,25) == 0)
        fprintf("Generation %i\n", i)
        env1.graphRank
        drawnow;
    end
end
