C = [0 1 0 0 1;1 0 1 0 0;0 1 0 1 0;0 0 1 0 1;1 0 0 1 0];
x = [0, 2, 4, 4, 0];
y = [0, 1, 0, 4, 4];
hold on
graphTruss(C,x,y)
hold off

xavg = mean(x);
yavg = mean(y);

outsideFrame(1,4,C,x,y,xavg,yavg)
outsideFrame(1,3,C,x,y,xavg,yavg)