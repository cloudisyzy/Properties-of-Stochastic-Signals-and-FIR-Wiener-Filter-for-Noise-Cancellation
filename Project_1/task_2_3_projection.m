% Load the data from the provided MATLAB file
load('Gaussian2D.mat');

% Number of bins for the histogram
bins = 50;

% Compute 2D histogram for s1
[N1, C1] = hist3(s1, [bins bins]);
% Convert counts to pdf
N1 = N1 / (numel(s1) * (C1{1}(2) - C1{1}(1)) * (C1{2}(2) - C1{2}(1)));

figure;
subplot(1, 2, 1);
imagesc(C1{1}, C1{2}, N1');
axis xy;
colorbar;
title('PDF Projection for s1');
xlabel('X');
ylabel('Y');
set(gca, 'FontSize', 10);
colorbar('off');
grid on;

% Compute 2D histogram for s2
[N2, C2] = hist3(s2, [bins bins]);
% Convert counts to pdf
N2 = N2 / (numel(s2) * (C2{1}(2) - C2{1}(1)) * (C2{2}(2) - C2{2}(1)));

subplot(1, 2, 2);
imagesc(C2{1}, C2{2}, N2');
axis xy;
colorbar;
title('PDF Projection for s2');
xlabel('X');
ylabel('Y');
set(gca, 'FontSize', 10);
colorbar('off');
grid on;
