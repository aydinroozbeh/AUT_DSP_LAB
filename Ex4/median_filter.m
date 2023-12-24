function img_out = median_filter(img_in , w)

if(~mod(w,2))
    error("WINDOWS SIZE IS NOT AN ODD NUMBER");
end


s=size(img_in);
img_out = zeros(s(1)-1 , s(2)-1);

for i=2:1:s(1)-1
    for j=2:1:s(2)-1
        img_out(i,j) = median( img_in(i-(w-1)/2:i+(w-1)/2 , j-(w-1)/2:j+(w+1)/2) , 'all');
    end
end

