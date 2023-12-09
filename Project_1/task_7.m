clear all;
sigma_z_squared = 1;
beta = 0.25;
alpha = 0.25;
k = -10:10;% 适当选择 k 的范围
rx1 = (alpha.^(abs(k))) .* (sigma_z_squared./(1-alpha.^2)); % 根据 AR(1) 过程的自相关函数公式计算
rx2=conv(rx1,rx1);
figure(1);
% set(gcf, 'Color', 'w', 'InvertHardcopy', 'off');
stem(-20:20,rx2);
title('rx2(k)');
xlabel('Lag(k)');
ylabel('Autocorrelation');
ax1 = gca;
% 设置刻度的字体大小
% ax1.XAxis.FontSize = 26;
% ax1.YAxis.FontSize = 26;
n=0:15;
n2=0:15;
h2 = (beta.^n) ; % 线性系统的冲激响应 h2(n)
h2_n = (beta.^n2) ; % 线性系统的冲激响应 h2(n)
h2_h2= conv (h2, h2_n, 'full');
rx2_2=conv(h2_h2,rx1);