clear all;

% Given parameters
sigma_z_sq = 1;
alpha = 0.25;
beta = 0.25;

% Frequency range
v = linspace(-0.5, 0.5, 1000);

% Calculate Rx1(v)
Rx1 = sigma_z_sq ./ (1 + alpha^2 - 2*alpha*cos(2*pi.*v));

% Calculate H2(v)
H2 = 1 ./ (1 - beta*exp(-1i*2*pi*v));

% Calculate Rx2(v)
Rx2 = abs(H2).^2 .* Rx1;

% Plotting Rx1(v) and Rx2(v)
figure;
subplot(1, 2, 1);
plot(v, Rx1);
title('R_{x1}(v)');
xlabel('Frequency (v)');
ylabel('Amplitude');
grid on;

subplot(1, 2, 2);
plot(v, Rx2);
title('R_{x2}(v)');
xlabel('Frequency (v)');
ylabel('Amplitude');
grid on;

% Lags for autocorrelation
lags = -25:25;

% Autocorrelation function for x1
r_x1_values = (alpha .^ abs(lags)) * sigma_z_sq/(1-alpha^2);

% Compute h2 values for positive lags
h2_values = arrayfun(@(n) h2(n, beta), 0:length(lags)-1);
h2_values_flip = flip(h2_values);

% Compute r_x2 through convolution
r_x2 = conv(h2_values_flip, conv(h2_values, r_x1_values, 'same'), 'same');

% Plotting r_x2(k)
figure;
stem(lags, r_x2);
title('r_{x2}(k)');
xlabel('Lag (k)');
ylabel('Autocorrelation');
grid on;

% Function to compute h2 for a given n
function val = h2(n, beta)
    if n >= 0
        val = beta ^ n;
    else
        val = 0;
    end
end

