%% 1-7
clear;
close all;
clc;

% Original Signal
t=-5:0.01:4.99;
x=sinc(5*t).^2;

% All Cases of sampling 
sample_4Hz = zeros(1,10*4);
sample_5Hz = zeros(1,10*5);
sample_10Hz = zeros(1,10*10);
sample_20Hz = zeros(1,10*20);

% Filling the sampled signal values
for i=1:1:40
    sample_4Hz(i)=x(25*i);
end

for i=1:1:50
    sample_5Hz(i)=x(20*i);
end

for i=1:1:100
    sample_10Hz(i)=x(10*i);
end

for i=1:1:200
    sample_20Hz(i)=x(5*i);
end

% Calculating the spectrum
spec_4=fftshift(fft(sample_4Hz));
spec_5=fftshift(fft(sample_5Hz));
spec_10=fftshift(fft(sample_10Hz));
spec_20=fftshift(fft(sample_20Hz));
original_fft = fftshift(fft(x));

% Defining the axis of different sampled signals
xax_4=-20:1:19;
xax_5=-25:1:24;
xax_10=-50:1:49;
xax_20=-100:1:99;

figure(1);

% Original Signal - Time Domain
subplot(3,2,1);
plot(t,x);
xlabel("Time");
ylabel("Amplitude");
title("Original Signal - Time Domain");
grid minor;

% Original Signal - Frequency Domain
subplot(3,2,2)
plot(t,abs(original_fft));
xlabel("Frequency");
ylabel("Amplitude");
title("Original Signal - Spectrum");
grid minor;

% 4Hz Sampling - Spectrum
subplot(3,2,3);
plot(xax_4,abs(spec_4));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled at Fs=4 - Spectrum");
grid minor;
grid on;

% 5Hz Sampling - Spectrum
subplot(3,2,4);
plot(xax_5,abs(spec_5));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled at Fs=5 - Spectrum");
grid minor;
grid on;

% 10Hz Sampling - Spectrum
subplot(3,2,5);
plot(xax_10,abs(spec_10));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled at Fs=10 - Spectrum");
grid minor;
grid on;

% 20Hz Sampling - Spectrum
subplot(3,2,6);
plot(xax_20,abs(spec_20));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled at Fs=20 - Spectrum");
grid minor;
grid on;

%% 1-8

L0=10000;
L1=256;
L2 = L1 * 0.5;
L3 = L1 * 1.5;
L4 = L1 * 3;

t0=linspace(-5,5,L0);
t1=linspace(-5,5,L1);
t2=linspace(-5,5,L2);
t3=linspace(-5,5,L3);
t4=linspace(-5,5,L4);

x0=sinc(2*t0);
x1=sinc(2*t1);
x2=sinc(2*t2);
x3=sinc(2*t3);
x4=sinc(2*t4);

figure(2);

% Original Signal
subplot(5,2,1);
plot(t0,x0);
xlabel("Time");
ylabel("Amplitude");
title("Original Signal - Time Domain");
grid minor;

% Original Signal - Spectrum
subplot(5,2,2);
plot(t0 , abs(fftshift(fft(x0)))/length(x0));
xlabel("Frequency");
ylabel("Amplitude");
title("Original Signal - Spectrum");
grid minor;

% Sampled at L1 - Time
subplot(5,2,3);
plot(t1 ,x1);
xlabel("Time");
ylabel("Amplitude");
title("Sampled with 256 points - Time Domain");
grid minor;

% Sampled at L1 - Spectrum
subplot(5,2,4);
plot(t1 , abs(fftshift(fft(t1)))/length(x1));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled with 256 points - Spectrum");
grid minor;

% Sampled at L2 - Time
subplot(5,2,5);
plot(t2, x2);
xlabel("Time");
ylabel("Amplitude");
title("Sampled with 128 points - Time Domain");
grid minor;


% Sampled at L2 - Spectrum
subplot(5,2,6);
plot(t2 , abs(fftshift(fft(t2)))/length(x2));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled with 128 points - Spectrum");
grid minor;

% Sampled at L3 - Time
subplot(5,2,7);
plot(t3 , x3);
xlabel("Time");
ylabel("Amplitude");
title("Sampled with 384 points - Time Domain");
grid minor;

% Sampled at L3 - Spectrum
subplot(5,2,8);
plot(t3 , abs(fftshift(fft(t3)))/length(x3));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled with 384 points - Spectrum");
grid minor;

% Sampled at L3 - Time
subplot(5,2,9);
plot(t4 , x4);
xlabel("Time");
ylabel("Amplitude");
title("Sampled with 768 points - Time Domain");
grid minor;

% Sampled at L3 - Spectrum
subplot(5,2,10);
plot(t4 , abs(fftshift(fft(t4)))/length(x4));
xlabel("Frequency");
ylabel("Amplitude");
title("Sampled with 768 points - Spectrum");
grid minor;
