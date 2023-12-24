% Aydin Roozbeh - 9923037

clear;
close all;
clc;

%% Ex4 - Part 1
% 4-1-a)
im1 = imread("lena.bmp","bmp");

% 4-1-b)
im1db = im2double(im1);

% 4-1-c , 4-1-d , 4-1-e)
im1db_eq3 = histeq(im1db,3);
im1db_eq15= histeq(im1db,15);


figure(1)
subplot(3,2,1);
imshow(im1db);
title("Image - Original");

subplot(3,2,2);
imhist(im1db);
title("Histogram - Original");

subplot(3,2,3);
imshow(im1db_eq3);
title("Image - Equalized - n=3");

subplot(3,2,4);
imhist(im1db_eq3);
title("Histogram - Equalized - n=3");

subplot(3,2,5);
imshow(im1db_eq15);
title("Image - Equalized - n=15");

subplot(3,2,6);
imhist(im1db_eq15);
title("Histogram - Equalized - n=15");

%% ---------- Part 2 -----------
% Operation are done on the same 'lena' picture
% 4-2-a to 4-2-d)
im_n = imnoise(im1db, 'gaussian', 0 , 0.04);

mat3=(1/9)*ones(3,3);
mat5=(1/25)*ones(5,5);
im_dn3 = conv2(im_n , mat3);
im_dn5 = conv2(im_n , mat5);

figure(2);
subplot(1,3,1);
imshow(im_n);
title("Noisy Image, Var=0.04");

subplot(1,3,2);
imshow(im_dn3);
title("Filtered Image, n=3");

subplot(1,3,3);
imshow(im_dn5);
title("Filtered Image, n=5");
% ------------------------
% 4-2-e , 4-2-f) Salt and Pepper noise
im_sp = imnoise(im1db , "salt & pepper" , 0.1);
im_sp3 = conv2(im_sp , mat3);
im_sp5 = conv2(im_sp , mat5);

figure(3);
subplot(1,3,1);
imshow(im_sp);
title("Noisy Image - Salt & Pepper");

subplot(1,3,2);
imshow(im_sp3);
title("Filtered, n=3");

subplot(1,3,3);
imshow(im_sp5);
title("Filtered, n=5");

% -------------------------

% 4-2-g)
f1 = load("fil1.mat").coeff;
f2 = ftrans2(f1);

figure(4);
freqz(f1,1,'whole',100);
title("1D frequency response");

figure(5);
freqz2(f2,[100 100]);
title("2D frequency response");

% -------------------------

% 4-2-h)
im_sp_fil = imfilter(im_sp , f2);
im_n_fil = imfilter(im_n , f2);

figure(6);
subplot(2,2,1);
imshow(im_sp);
title("Noisy Image - salt and pepper");

subplot(2,2,2);
imshow(im_sp_fil);
title("Filtered image using fdatool");

subplot(2,2,3);
imshow(im_n);
title("Noisy Image - Gaussian");

subplot(2,2,4);
imshow(im_n_fil);
title("Filtered image using fdatool");

% --------------------------
% 4-2-i) The filter is implemented in median_filter.m

% 4-2-j)
im_med3 = median_filter(im_sp , 3);
im_med5 = median_filter(im_sp , 5);

figure(7)
subplot(1,3,1);
imshow(im_sp);
title("Image + Salt and Pepper noise");

subplot(1,3,2);
imshow(im_med3);
title("Median filtered , N=3");

subplot(1,3,3);
imshow(im_med5);
title("Median filtered , N=5");

% 4-2-k) In the description
% -------------------------
% 4-3-a)
[cA,cH,cV,cD] = dwt2(im1db , 'db1');

figure(8)
subplot(2,2,1);
imshow(cA);
title("cA");

subplot(2,2,2);
imshow(cH);
title("cH");

subplot(2,2,3);
imshow(cV);
title("cV");

subplot(2,2,4);
imshow(cD);
title("cD");

% 4-3-b)
% image reconstruction
figure(9);

subplot(1,2,1);
imshow(idwt2(cA,cH,30*cV,cD,'db1'));
title("Intensifying vertical component - 30");

subplot(1,2,2);
imshow(idwt2(cA,30*cH,cV,cD,'db1'));
title("Intensifying horizontal component - 30");

%% --------------------------
% Motion Bluring
LEN = 15;
THETA = 20;

% 4-4-a)
mot_fil = fspecial('motion',LEN,THETA);
im_mot = imfilter(im1db,mot_fil,'replicate');

figure(10);
imshow(im_mot);
title("Blurred Image , LEN=15, THETA=20");

% 4-4-b)
figure(11);
for i=0:1:8
    subplot(3,3,i+1);
    imshow(deconvwnr(im_mot, mot_fil, 10^(-8+i)));
    title({"NSR=" num2str(10^(-8+i))});
end

% 4-4-c)
im_mot_blur = imnoise(im_mot, 'gaussian', 0 , 0.04);
figure(12);
imshow(im_mot_blur);
title("Motion + Blur(var=0.04)");

% 4-4-d)
figure(13);
for i=0:1:8
    subplot(3,3,i+1);
    imshow(deconvwnr(im_mot_blur, mot_fil, 10^(-8+i)));
    title({"NSR=" num2str(10^(-8+i))});
end

%% ------ Anti-Aliasing --------
% 4-5-a and 4-5-b)
im_temp = imread('glass.png'); % Loading the glass image

%cropping the image to make a square
im_temp_crop = im_temp(1:min(size(im_temp)) , 1:min(size(im_temp)));

im_glass = im2double(im_temp_crop);
im_fft = fft2(im_glass);
im_fft_amp = fftshift(abs(im_fft));
im_fft_ang = fftshift(angle(im_fft));

figure(14);

subplot(1,2,1);
surf(im_fft_amp);
title("Amplitude");

subplot(1,2,2);
surf(im_fft_ang);
title("Angle");

% 4-5-c => implemented in fft_lp_2d.m
% 4-5-d)

im_fft_fil= fft_lp_2d(im_glass , 0.1*pi);

figure(15);
subplot(1,2,1);
imshow(im_glass);
title("Original image");

subplot(1,2,2);
imshow(im_fft_fil);
title("Low-Passed image, w=0.1*pi");

% 4-5-e)
im_dwn = downsample(downsample(im_glass,4)',4)';
im_dwn_fil = fft_lp_2d(im_dwn , 0.6*pi);
figure(16);
subplot(1,2,1);
imshow(im_dwn);
title("Downsampled glass image");

subplot(1,2,2);
imshow(im_dwn_fil);
title("Filtered, w=0.1*pi");

