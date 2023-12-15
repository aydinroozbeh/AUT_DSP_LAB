function res = myconv(x,y)
    lenX=size(x,2);
    lenY=size(y,2);
    fx=fliplr(x);
    disp(fx);
   
    res=zeros(1,lenX+lenY-1);
    
    temp = [zeros(1,lenX-1) , y , zeros(1,lenX-1)];
    
    for i=1:1:lenX+lenY-1
        res(i) = fx*temp(i:i+lenX-1)';
    end
end