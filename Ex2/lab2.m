% Aydin Roozbeh - 9923037 - Ex.2 
clear
close all
clc

%% 2-1-a) myconv function is already written

%% 2-1-b)
sig = [ones(1,50) , -1*ones(1,50) , ones(1,50), -1*ones(1,50)];
fil1 = 1/10*ones(1,10);
res1 = myconv(sig,fil1);

figure(1);
subplot(3,1,1);
stem(sig)
title("Input");
axis([0 220 -1.5 1.5]);
grid minor;

subplot(3,1,2);
stem(fil1);
title("Filter 1");
axis([0 220 -1.5 1.5]);
grid minor;

subplot(3,1,3);
stem(res1);
title("Result of convolution 1");
axis([0 220 -1.5 1.5]);
grid minor;

%% 2-1-c)
fil2 =  zeros(1,15);
for i=1:1:15
    fil2(i)=0.25*(0.75^(i-1));
end

res2 = myconv(sig , fil2);

figure(2);
subplot(3,1,1);
plot(sig)
title("Input");
axis([0 220 -1.5 1.5]);
grid minor;

subplot(3,1,2);
plot(fil2);
title("Filter 2");
axis([0 220 -0.3 0.3]);
grid minor;

subplot(3,1,3);
plot(res1);
title("Result of convolution 2");
axis([0 220 -1.5 1.5]);
grid minor;

%% 2-1-d)

fil3 = [1 -1];

% applying the filter 5 times in a row
fil3 = myconv(fil3 , fil3);
fil3 = myconv(fil3 , fil3);
fil3 = 0.2*myconv(fil3 , [1 -1]);

res3 = myconv(fil3 , sig);

figure(3);
subplot(3,1,1);
stem(sig)
title("Input");
axis([0 220 -1.5 1.5]);
grid minor;

subplot(3,1,2);
stem(fil3);
title("Filter 3");
axis([0 220 -1*max(fil3) 1*max(fil3)]);
grid minor;

subplot(3,1,3);
stem(res3);
title("Result of convolution 3");
axis([0 220 -1*max(res3) max(res3)]);
grid minor;


%% 2-2-a)
w1 = 0.05*pi;
w2 = 0.20*pi;
w3 = 0.35*pi;

Wa = 0.15*pi;
Wb = 0.25*pi;

t=0:1:200;

s = sin(w2*t);
v = sin(w1*t) + sin(w3*t);
x = s+v;

figure(4)
stem(t,x , color='red');
hold on;
stem(t,s , color='blue');
grid minor;
yline(0);
legend("X","Y",'Zero');
title("Before filtering");


%% 2-2-b)
M=100;
W = zeros(1,100);
H = zeros(1,100);
for i=1:1:M
    W(i)=0.54 - 0.46*sin(2*pi*i/M);
end

for i=1:1:100
    H(i)=W(i)*( (Wa/(pi^2))*sinc((Wa/pi)*(i-M/2)) - (Wb/(pi^2))*sinc((Wb/pi)*(i-M/2)) );
end

y = filter(H , 1 , x);
figure(5);
title("After Filtering");
plot(s,color='red');
hold on;
plot(y,color='green');

%% 2-2-c)
% The filter is already designed using the FDATOOL and here I just load the
% coefficients

coeff = load("fil.mat").coeff;
fda_fil = filter(coeff , 1 , x);

figure(6);
title("After Filtering using FDATOOL");
plot(s,color='red');
hold on;
plot(fda_fil,color='green');

%% 2-3-a)
fs=22296;
f0=fs/4;
audio = audioread("sample-3.mp3",[1,10*fs]);
audio = audio';

%% 2-3-b)
% The coefficients are stored as 'Audio_filter'
aud_fil = load("audio_filter.mat").coeff;
%% 2-3-c)
S=zeros(1,size(audio,2));
for i=1:1:size(audio,2)
    S(i)=2*cos(pi*i/2);
end
% Scrambling
y0 = filter(aud_fil , 1 , audio);   
y1 = y0.*S;
y2 = filter(aud_fil , 1 , y1);
% Applying this system all over again

%% 2-3-d)
y3 = y2.*S;
y4 = filter(aud_fil, 1, y3);

%% 2-4-a)

n=1:1:1000;
x1 = sin(2*pi*100*n/500);
x2 = zeros(1,1000);
x2(250)=50;
x3 = sin(2*pi*(200 + 0.2.*n).*n/500);

x4 = x1 + x2 + x3;

figure(7);
hold on;
subplot(2,2,1);
plot(x1);
title("x1 = sin ~ 100Hz");
grid minor;


subplot(2,2,2);
plot(x2);
title("Delta function");
grid minor;

subplot(2,2,3);
plot(x3);
title("Chirp");
grid minor;

subplot(2,2,4);
plot(x4);
title("Sum");
grid minor;
hold off;

x4_fft = fftshift(abs(fft(x4)));

figure(8);
m=-500:1:499;
plot(m,x4_fft);

%% 4-2-b)
figure(9);
hold on;
colormap("winter");

subplot(2,2,1);
spectrogram(x4,64);
title("64 Points");

subplot(2,2,2);
spectrogram(x4, 128);
title("128 points")

subplot(2,2,3);
spectrogram(x4,256);
title("256 Points");

subplot(2,2,4);
spectrogram(x4,512);
title("512 Points");

%% 2-5)
[wav,noisyx] = wnoise('doppler',10,7);
loc = linspace(0,1,2^10);

figure(10);
subplot(2,1,1);
plot(loc,wav);
title('Clean Doppler');
ylim([-15 15]);

subplot(2,1,2);
plot(loc,noisyx);
title('Noisy Doppler');
ylim([-15 15]);

% Analysis:
[cA, cD]=dwt(wav,'db1');

figure(11);

subplot(2,1,1);
plot(cA);

subplot(2,1,2);
plot(cD);
