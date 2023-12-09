clear;
load('spydata.mat');
load('training.mat');

N_train_seq = length(training);

figure;

for order_FIR = 0:N_train_seq-1

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
% 
%     if order_FIR >= 6 && order_FIR <= 10
%         subplot(1,5,order_FIR-5);
%         image(dPic)
%         ax=gca;
%         ax.XAxis.Visible='off';
%         ax.YAxis.Visible='off';
%         title(sprintf("Order = %d",order_FIR));
%     end
    if order_FIR >= 0 && order_FIR <= 31
        subplot(4,8,order_FIR+1);
        image(dPic)
        ax=gca;
        ax.XAxis.Visible='off';
        ax.YAxis.Visible='off';
        title(sprintf("Order = %d",order_FIR));
    end

end

