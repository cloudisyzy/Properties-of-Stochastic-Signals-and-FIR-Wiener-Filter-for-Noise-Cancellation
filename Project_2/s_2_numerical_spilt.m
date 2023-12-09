clear;
load('spydata.mat');
load('training.mat');

N_train_seq = length(training);

MSE_record = zeros(1, N_train_seq-1);

for order_FIR = 1:N_train_seq-1

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
    
    MSE = 1/(32-order_FIR) * sum((received_recov(tap_FIR:32) - training(tap_FIR:32)).^2);
    MSE_record(order_FIR) = MSE;

end

[min_MSE, min_Order] = min(MSE_record)

