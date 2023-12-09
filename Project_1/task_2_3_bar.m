% Load the data from the provided MATLAB file
load('Gaussian2D.mat');

% Parameters for 2D histogram (number of bins)
bins = 40;

% Compute and plot the empirical pdf for each sequence using a 2D histogram
colormap hsv;
% For s1
figure;
subplot(1,2,1);
histogram2(s1(:,1), s1(:,2), bins, 'Normalization', 'pdf');
view(3);
title('Empirical pdf for s1');
xlabel('X');
ylabel('Y');
zlabel('Probability Density');
colormap hsv;  % Use the jet color map

% For s2
% figure;
subplot(1,2,2);
histogram2(s2(:,1), s2(:,2), bins, 'Normalization', 'pdf');
view(3);
title('Empirical pdf for s2');
xlabel('X');
ylabel('Y');
zlabel('Probability Density');
colormap hsv;  % Use the jet color map
