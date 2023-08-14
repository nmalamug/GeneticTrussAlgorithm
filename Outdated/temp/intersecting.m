function [isec] = intersecting(a1,a2,b1,b2,x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Well documented here https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
    %If it is the same line, consider intersecting.
    if((a1 == b1 && a2 == b2) || (a1 == b2 && a2 == b1))
        isec = 1;
        return
    end
    
    %if exactly one of the joints is shared, not intersecting. 
    if(a1 == b1 || a1 == b2 || a2 == b1 || a2 == b2)
        isec = 0;
        return
    end
    
    p1 = [x(a1),y(a1)];
    q1 = [x(a2),y(a2)];
    p2 = [x(b1),y(b1)];
    q2 = [x(b2),y(b2)];

    o1 = orientation(p1,q1,p2);
    o2 = orientation(p1,q1,q2);
    o3 = orientation(p2,q2,p1);
    o4 = orientation(p2,q2,q1);
    
    if(o1 ~= o2 && o3 ~= o4)
        isec = 1;
        return
    else
        isec = 0;
        return
    end
end

function ort = orientation(pp,pq,pr)
    val = (pq(2)-pp(2))*(pr(1)-pq(1)) - (pq(1)-pp(1))*(pr(2)-pq(2));
    if(val == 0)
        ort = 0;
    elseif(val>0)
        ort = 1;
    else
        ort = -1;
    end
    return
end
