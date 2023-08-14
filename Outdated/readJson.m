function [C,Sx,Sy,X,Y,L] = readJson(filename)
    fid = fopen(filename);
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);
    data = jsondecode(str);
    
    jt = length(data.nodes);
    mem = length(data.members);
    
    x = zeros(1,jt);
    y = zeros(1,jt);
    
    cind = zeros(2,mem);
    cz = zeros(jt,mem);
    
    rx = zeros(jt,3);
    ry = zeros(jt,3);
    
    
    for i = 1:jt
        t = split(data.nodes(i),",");
        x(i) = str2num(t{1,1});
        y(i) = str2num(t{2,1});
    end
    X = x;
    Y = y;
    
    for i = 1:mem
        t = split(data.members(i),",");
        cind(1,i) = str2num(t{1,1});
        cind(2,i) = str2num(t{2,1});
        cz((cind(1,i)+1),i) = 1;
        cz((cind(2,i)+1),i) = 1;
    end
    
    C = cz;
    
    ld = zeros(2*jt,1);
    forces = length(data.forces);
    lraw = split(data.forces(1),",");
    for i = 1:forces
        t = split(data.forces(i),",");
        node = str2num(t{1,1});
        ld(node+1) = str2num(t{2,1});
        ld(node+jt+1) = -str2num(t{3,1});
    end    
    
    L = ld;
    
    fields = fieldnames(data.supports);
    
    for i = 1:numel(fields)
        num = str2num(strip(fields{i,1},'x'));
        if data.supports.(fields{i}) == 'P'
            rx(num+1,1) = 1;
            ry(num+1,2) = 1;
        end
        if data.supports.(fields{i}) == 'Rh'
            ry(num+1,3) = 1;
        end     
    end
    Sx = rx;
    Sy = ry;
end