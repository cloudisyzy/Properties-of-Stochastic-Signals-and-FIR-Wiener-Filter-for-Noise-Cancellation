clear;
load('spydata.mat');
load('training.mat');

N_train_seq = length(training);

diff_list = zeros(1, N_train_seq-1);

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
    received_recov = sign(received_recov(1:32));
    received_recov(received_recov == -1) = 0;

    sign_received = sign(received);
    sign_received = sign_received(1:32);
    sign_received(sign_received == -1) = 0;

    training(training == -1) = 0;

    diff_1 = sum(xor(training, sign_received));
    diff_2 = sum(xor(training, received_recov));

%     corrected_bit_number = diff_1 - diff_2;
    diff_list(order_FIR) = diff_2;

    key = sign(received_recov);

end


figure;
stem(1:15, diff_list(1:15), 'o');
xticks(1:15);
xlabel("Filter Order");
ylabel("Number of Error Bits");
