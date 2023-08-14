%Path folder
classdef Truss
    %UNTITLED Summary of this class goes here
    %   A class which creates a truss

    properties
        cnxs
        x
        y

    end

    methods
        function obj = Truss(numjoints, xlimit, ylimit) %Add min distance apart
            %Use 6,100,100 for testing??

            %Connections matrix - Column is joint #, row is connections to it.
            obj.cnxs = zeros(numjoints);
            obj.x = xlimit*rand(1,numjoints);
            obj.y = ylimit*rand(1,numjoints);
            
            %Plot the points
            %plot(x,y,'*')
            %hold on
            xavg = mean(obj.x);
            yavg = mean(obj.y);
            
            %plot(xavg,yavg,'r*')
            
            %Calculate all of the angles relative to the centerpoint
            theta = zeros(2,numjoints);
            for ii = 1:numjoints
                if((obj.x(ii)-xavg)>0)
                    theta(1,ii) = atan((obj.y(ii)-yavg)/(obj.x(ii)-xavg));
                else
                    theta(1,ii) = pi+atan((obj.y(ii)-yavg)/(obj.x(ii)-xavg));
                end
                theta(2,ii) = ii;
            end
            
            %Sort the thetas by ascending order, with tags for joint number.
            theta = sortrows(theta',1)';
            
            %Update the connections matrices
            %For all intents and purposes, you got the outside of the truss. 
            obj.cnxs(theta(2,1),theta(2,numjoints)) = 1;
            obj.cnxs(theta(2,numjoints),theta(2,1)) = 1;
            for ii = 1:numjoints-1
                obj.cnxs(theta(2,ii),theta(2,ii+1)) = 1;
                obj.cnxs(theta(2,ii+1),theta(2,ii)) = 1;
            end
            
            %Exterior connections
            cframe = obj.cnxs;
            
            %Number of members currently equals number of joints
            numMembers = numjoints;
            
            %Start making internal connections
            while numMembers < 2*numjoints - 3
                j1 = randi(numjoints);
                j2 = randi(numjoints);
            
                if(j1 ~= j2 && isValid(j1,j2,obj.cnxs,obj.x,obj.y,xavg,yavg,cframe))
                    obj.cnxs(j1,j2) = 1;
                    obj.cnxs(j2,j1) = 1;
                    numMembers = numMembers+1;
                end
                %Check if the connection is not to any already connected points
                %If it is, go the the next point. 
                %If it isn't check to see if the connection intersects any existing
                %connections. 
                %If not, add it to the matrix, 
            end
            
            %graphTruss(cnxs,x,y)
            
            %hold off
        end

        function graphTruss(obj)
            % graph points between every member. 
            %Make sure hold is on.
            clf
            hold on
            for ii = 1: length(obj.x)-1
                for jj = ii+1:length(obj.x)
                    if(obj.cnxs(ii,jj) == 1)
                        plot([obj.x(ii),obj.x(jj)] , [obj.y(ii),obj.y(jj)])
                    end
                end
            end
            hold off
        end
        
    end
    %End Methods
end
%End Class