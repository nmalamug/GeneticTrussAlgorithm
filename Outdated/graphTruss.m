function graphTruss(C,x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% graph points between every member. 
%Make sure hold is on.
    clf
    hold on
    for ii = 1: length(x)-1
        for jj = ii+1:length(x)
            if(C(ii,jj) == 1)
                plot([x(ii),x(jj)] , [y(ii),y(jj)])
            end
        end
    end
    hold off
end