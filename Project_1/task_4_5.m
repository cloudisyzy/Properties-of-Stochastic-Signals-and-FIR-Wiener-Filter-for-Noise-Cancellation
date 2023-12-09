clear all;

% Load the data
load('SinusInNoise1.mat');
load('SinusInNoise2.mat');

% Compute the periodograms
[Pxx1, frequencies1] = periodogram(y1);
[Pxx2, frequencies2] = periodogram(y2);
[Pxx3, frequencies3] = periodogram(y);

% Create the figure for plotting
figure(1);

% Plot the periodogram for y1
subplot(3, 1, 1);
stem(frequencies1/(2*pi), Pxx1);
title('Periodogram of Sequence y1');
xlabel('Normalized Frequency');
ylabel('Power Spectrum ');
grid on;

% Plot the periodogram for y2
subplot(3, 1, 2);
stem(frequencies2/(2*pi), Pxx2);
title('Periodogram of Sequence y2');
xlabel('Normalized Frequency');
ylabel('Power Spectrum ');
grid on;

% Plot the periodogram for y2
subplot(3, 1, 3);
stem(frequencies3/(2*pi), Pxx3);
title('Periodogram of Sequence y (corrupted by colored noise)');
xlabel('Normalized Frequency');
ylabel('Power Spectrum ');
grid on;
% % Create the figure for plotting
% figure(2);
% 
% % Plot the periodogram for y1
% subplot(2, 1, 1);
% plot(frequencies1/(2*pi), 10*log10(Pxx1));
% title('Periodogram of Sequence y1');
% xlabel('Normalized Frequency');
% ylabel('Power Spectrum (dB)');
% grid on;
% 
% % Plot the periodogram for y2
% subplot(2, 1, 2);
% plot(frequencies2/(2*pi), 10*log10(Pxx2));
% title('Periodogram of Sequence y2');
% xlabel('Normalized Frequency');
% ylabel('Power Spectrum (dB)');
% grid on;





