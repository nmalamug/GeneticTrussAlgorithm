function outside = outsideFrame(j1,j2,C,xavg,yavg)
    %Convert joints to points
    %Want origin, center, proposed, 2 existing
    thetam = [0, 0];
    index = 1;
    x = obj.x;
    y = obj.y;
    %Get the thetas to existing members
    for ii = 1:length(x)
        if(C(j1,ii) == 1)
            if((x(ii)-x(j1))>0)
                thetam(index) = atan((y(j1)-y(ii))/(x(j1)-x(ii)));
            else
                thetam(index) = pi + atan((y(j1)-y(ii))/(x(j1)-x(ii)));
            end
            index = index + 1;
        end
    end

    %Get theta to the center
    if((xavg-x(j1))>0)
        thetac = atan((y(j1)-yavg)/(x(j1)-xavg));
    else
        thetac = pi + atan((y(j1)-yavg)/(x(j1)-xavg));
    end
    %Get theta to proposed point
    if(x(j2)-(x(j1))>0)
        thetap = atan((y(j1)-y(j2))/(x(j1)-x(j2)));
    else
        thetap = pi + atan((y(j1)-y(j2))/(x(j1)-x(j2)));
    end    

    %Do the final check - if c between and p between or both not
    thetam = sort(thetam);
    cbetween = (thetam(1)<thetac && thetac<thetam(2));
    pbetween = (thetam(1)<thetap && thetap<thetam(2));

    if(cbetween == pbetween)
        outside = 0;
        return
    end
    outside = 1;

end