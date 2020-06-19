close all;

I = double(imread('im1.jpg')) / 255;


p = I; 
r = 16;
eps = 0.2^2;


q3 = zeros(size(I));
q3(:, :, 1) = pwfilter(I(:, :, 1), p(:, :, 1), r, eps);  
q3(:, :, 2) = pwfilter(I(:, :, 2), p(:, :, 2), r, eps);
q3(:, :, 3) = pwfilter(I(:, :, 3), p(:, :, 3), r, eps);
I_enhanced3 = (I - q3) * 5 + q3;

figure('Name','Proposed Guided Filtering');
imshow([I, q3, I_enhanced3], [0, 1]);
title('Input Image                                                  Smooth Result                                          Enhanced Result');


