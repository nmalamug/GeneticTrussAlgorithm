function [cnxs, x, y] = mkSimpleTruss(numjoints, xlimit, ylimit) %Add min distance apart
    %Use 6,100,100 for testing??
    clf
    %Connections matrix - Column is joint #, row is connections to it.
    cnxs = zeros(numjoints);
    x = xlimit*rand(1,numjoints);
    y = ylimit*rand(1,numjoints);
    
    %Plot the points
    plot(x,y,'*')
    hold on
    xavg = mean(x);
    yavg = mean(y);
    
    plot(xavg,yavg,'r*')
    
    %Calculate all of the angles relative to the centerpoint
    theta = zeros(2,numjoints);
    for ii = 1:numjoints
        if((x(ii)-xavg)>0)
            theta(1,ii) = atan((y(ii)-yavg)/(x(ii)-xavg));
        else
            theta(1,ii) = pi+atan((y(ii)-yavg)/(x(ii)-xavg));
        end
        theta(2,ii) = ii;
    end
    
    %Sort the thetas by ascending order, with tags for joint number.
    theta = sortrows(theta',1)';
    
    %Update the connections matrices
    %For all intents and purposes, you got the outside of the truss. 
    cnxs(theta(2,1),theta(2,numjoints)) = 1;
    cnxs(theta(2,numjoints),theta(2,1)) = 1;
    for ii = 1:numjoints-1
        cnxs(theta(2,ii),theta(2,ii+1)) = 1;
        cnxs(theta(2,ii+1),theta(2,ii)) = 1;
    end
    
    %Exterior connections
    cframe = cnxs;
    
    %Number of members currently equals number of joints
    numMembers = numjoints;
    
    %Start making internal connections
    while numMembers < 2*numjoints - 3
        j1 = randi(numjoints);
        j2 = randi(numjoints);
    
        if(j1 ~= j2 && isValid(j1,j2,cnxs,x,y,xavg,yavg,cframe))
            cnxs(j1,j2) = 1;
            cnxs(j2,j1) = 1;
            numMembers = numMembers+1;
        end
        %Check if the connection is not to any already connected points
        %If it is, go the the next point. 
        %If it isn't check to see if the connection intersects any existing
        %connections. 
        %If not, add it to the matrix, 
    end
    
    graphTruss(cnxs,x,y)
    
    hold off
end