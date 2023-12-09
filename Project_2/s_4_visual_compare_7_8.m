clear;
load('spydata.mat');
load('training.mat');

N_train_seq = length(training);

figure;

for order_FIR = 7:8

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
    
    l_received = length(received);
    received_recov = conv(received, h);
    received_recov = received_recov(1:l_received);
    
    key = sign(received_recov);
    
    dPic = decoder(key, cPic);

    subplot(1,2,order_FIR-6);
    image(dPic)
    title(sprintf("FIR Equilizer Order = %d",order_FIR));

end

