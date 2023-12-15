% Aydin Roozbeh - 992307 - DSP Lab, Ex. 1
%% 1-1
close all; clear; clc;

t=0:0.01:1.99;
A=5;
x=A*sin(2*pi*t);

figure(1)
subplot(2,1,1);
stem(t,x, color='red');
xlabel("Time");
ylabel("Amplitude");
title("Sin(2*pi*t)");
grid minor;

subplot(2,1,2);
plot(t,x, color='blue');
xlabel("Time");
ylabel("Amplitude");
title("Sin(2*pi*t)");
grid minor;

%% 1-2) 
% Introducing noise
n=rand(1,200)-0.5;
xn = x + n;
figure(2);
subplot(2,1,1);
plot(t,x,color='blue');
title("Original Signal = x(t)");
xlabel("Time");
ylabel("Amplitude");
grid minor;

subplot(2,1,2);
plot(t,xn,color='red');
title("Noisy Signal = x(t) + n(t)");
xlabel("Time");
ylabel("Amplitude");
grid minor;

%% 1-3 and 1-4
% Moving average
ma = ones(1,21)/21;
num=ones(1,21)/21;
den=1;
res_fil=filter(num,den,xn);
res=conv(xn,ma);
t1 = 0:0.01:2.19;
figure(3);
plot(t1,res,LineWidth=4,color='red');
hold on;
plot(t,res_fil,Marker='*',color='green');
xlabel("Time");
ylabel("Amplitude");
title("Filtered Signal");
legend("conv()","filter()");
disp(max(res_fil)); disp(min(res_fil));
disp(max(res)); disp(min(res));
grid minor;

%% 1-5
% Function is defined in the 'singen' file. example below
temp=singen(4*pi, 200);
figure(4);
plot(t,temp,color='green');

%% 1-6
F=500; % Simulation Frequency
f=5;   % Sampling Frequency 
L=4;   % Signal Length
t2=0:1/F:L-1/F; % Time Domain for Original signal
t2_sample=1/f:1/f:L; % Time Domain for sampled sequence
x1 = singen(2*pi , L*F) + singen(8*pi , L*F) + singen(12*pi , L*F);
x1_sample = zeros(1,L*f);
for i=1:1:L*f
    x1_sample(i)=x1(i*(F/f));
end

x1_sample_fil = lowpass(x1_sample,0.6,5);

figure(5);
plot(t2,x1,color='red', LineWidth=2 , LineStyle='--');
hold on;
stem(t2_sample , x1_sample , color='green',LineWidth=2);
plot(t2_sample , x1_sample_fil , LineWidth=1.5);
legend("Original Signal" , "Sampled Sequence" , "Reconstructed Signal");
grid minor;



