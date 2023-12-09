% Load the data from the provided MATLAB file
load('Gaussian1D.mat');

% Estimate the mean and variance for each sequence
mean_s1 = mean(s1);
var_s1 = var(s1);
mean_s2 = mean(s2);
var_s2 = var(s2);
mean_s3 = mean(s3);
var_s3 = var(s3);

% Plot the empirical CDFs for each sequence
figure;

% Empirical CDF for s1
[F_s1, X_s1] = ecdf(s1);
stairs(X_s1, F_s1, 'DisplayName', 's1');

hold on;

% Empirical CDF for s2
[F_s2, X_s2] = ecdf(s2);
stairs(X_s2, F_s2, 'DisplayName', 's2');

% Empirical CDF for s3
[F_s3, X_s3] = ecdf(s3);
stairs(X_s3, F_s3, 'DisplayName', 's3');

title('Empirical CDFs of the Sequences');
xlabel('Value');
ylabel('Probability');
legend;
grid on;
