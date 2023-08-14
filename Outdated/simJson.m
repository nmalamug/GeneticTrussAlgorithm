function simJson(filename)
    [C,Sx,Sy,X,Y,L] = readJson(filename);
    sim_truss(C,Sx,Sy,X,Y,L)
    %For use with: https://ei.jhu.edu/truss-simulator/
end