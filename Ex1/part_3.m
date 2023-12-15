clear
close all
clc

t=linspace(0,10,1024);
x = cos(2*pi*(1/16)*t) + cos(2*pi*(5/16)*t) + cos(2*pi*(9/16)*t) + cos(2*pi*(13/16)*t);
x_spec = fftshift(fft(x));

fil1=xlsread("filters.xls",1);
fil2=xlsread("filters.xls",2);

x1 = downsample( filter(fil1(1,:) , 1 ,x) , 4);
x2 = downsample( filter(fil1(2,:) , 1 ,x) , 4);
x3 = downsample( filter(fil1(2,:) , 1 ,x) , 4);
x4 = downsample( filter(fil1(3,:) , 1 ,x) , 4);

res=abs(fftshift(fft(x2)));
plot(res)
