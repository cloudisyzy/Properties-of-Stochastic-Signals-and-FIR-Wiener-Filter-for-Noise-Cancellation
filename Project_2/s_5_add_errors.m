clear;
load('spydata.mat');
load('training.mat');
N_train_seq = length(training);

order_FIR = 8;
tap_FIR = order_FIR + 1;

r_xy = zeros(1, tap_FIR);
for i = 1:tap_FIR
    for j = i:N_train_seq
        r_xy(i) = r_xy(i) + training(j) * received(j-i+1);
    end
    r_xy(i) = r_xy(i) / (N_train_seq-i+1);
end

r_y = zeros(1, tap_FIR);
for i = 1:tap_FIR
    for j = i:N_train_seq
        r_y(i) = r_y(i) + received(j) * received(j-i+1);
    end
    r_y(i) = r_y(i) / (N_train_seq-i+1);
end
R_y = toeplitz(r_y);

h = inv(R_y) * r_xy';

received_recov = conv(received, h);
received_recov = received_recov(1:length(received_recov)-length(h)+1);

key = sign(received_recov);

figure;
i = 1;

for num_errors = 300:70:930
    interrupted_key = key;
    indice_interrupted = randperm(length(key), num_errors);
    interrupted_key(indice_interrupted) = key(indice_interrupted) * -1;
    dPic = decoder(interrupted_key, cPic);
    subplot(2,5,i);
    image(dPic)
    ax=gca;
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    biterr = num_errors/length(key)*100;
    title(sprintf("%.2f%% bit error rate", biterr))
    i = i + 1;
end



