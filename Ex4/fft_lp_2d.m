function im_out = fft_lp_2d(im_in , w)

if(w>pi || w<0)
    error("CUTOFF FREQUENCY SIZE IS NOT CORRECT");
end

temp = fftshift(fft2(im_in));
im = abs(temp);
ang = angle(temp);

s = size(im);
c= round(s/2);

r=w/pi;
R=round(r*s(1)/2);

x=c(1)+R;
y=c(2);
R2=R^2;
d=R2;

while(x>=c(1))
    if(d<R2)
        d=d+2*(y-c(2))+1;
        y=y+1;
    else
       im( x:s(1) , y:s(2))=0;
       im( x:s(1) , 1:s(2)-y)=0;
       im( 1:s(1)-x , y:s(2))=0;
       im( 1:s(1)-x , 1:s(2)-y)=0;
       
       d=d-2*(x-c(1))+1;
       x=x-1;
    end
end

im_out=ifft2(ifftshift(im.*exp(1i*ang)));

end