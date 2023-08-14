function [valid] = isValid(j1,j2,xavg,yavg,cframe)

%Could also implement O(nlogn) by using sweep line algo instead
%of checking thru every line. 
%Might need special cases for start, endpoints. 
    
    [njoints,unimportant] = size(obj.cnxs);
    valid = 1;
    
    %Check if the point is outside the truss
    if(outsideFrame(j1,j2,cframe,xavg,yavg))
        valid = 0;
        return
    end

    %Loop that checks every joint for intersections, one by one. 
    for ii = 1: njoints-1
        for jj = ii+1:njoints
            %Check if the member exists on the truss, check if intersecting
            %a current member, check if outside of frame. 
            if (obj.cnxs(ii,jj) == 1 && (intersecting(j1,j2,ii,jj,x,y))) 
                valid = 0;
                return
            end
        end
    end
    return
end