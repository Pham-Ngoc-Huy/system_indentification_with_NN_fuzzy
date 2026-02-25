clc;
clear;

%% generate training and testing data
u(:,1) = 8-2*rand(1000,1);
y(3,1) = 0;

% function 
for t=4:length(u)
    y(t) = (y(t-1)*y(t-2)*y(t-3)*u(t-2)*(y(t-3)-1) + u(t-1))/ (1 + y(t-2).^2 + y(t-3).^2);
end

%% input data
data = [[0; y(1:end-1)], [0;0;y(1:end-2)], [0;0;0;y(1:end-3)], [0;u(1:end-1)], [0;0;u(1:end-2)]];


nn = randperm(1000);
train_data = data(nn(1:700),:);
target_train = y(nn(1:700));

%% neural network intial parameters
num_neuron = 4;
w1 = rand(6,num_neuron);
w2 = rand(num_neuron + 1,1);
eta = 5;
b1=1;
b2=1;

%% train
for epoch = 1:100
    epoch
    E=0;
    nn=randperm(700);
    kk=1;
    for ii = nn
        x = train_data(ii,:)';
        [o1,o2,net1,net2]=feedforward_nn(x,b1,b2,w1,w2);
        e=target_train(ii) - o2;
        [w1,w2]=gradient_descent_nn(e,eta,[b1;x], [b2;o1], net1, net2, w1, w2);
        E=E+e^2;
    end
    E/700
    MSE_Train(epoch)=E/700;
    
    % Test
    E=0;
    for ii=1:300
        x=test_data(ii,:)';
        [o1,o2,net1,net2]=feedforward_nn(x,1,1,w1,w2);
        e=target_test(ii) - o2;
        E=E+e^2;
        yest(ii)=o2;
    end
    E/300
    MSE_Test(epoch)=E/300;
end

%% plot MSE
plot(MSE_Train(1:end), '--b', 'LineWidth',2)
hold on
plot(MSE_Test,'--r', 'LineWidth',2)

% test
E=0;
for ii=1:300
    x=test_data(ii,:)';
    [o1,o2,net1,net2]=feedforward_nn(x,1,1,w1,w2);
    e=target_test(ii)-o2;
    E=E+e^2;
    yest(ii)=o2;
end
E/300

% plot out
plot(yest, '--b', 'LineWidth',2)
hold on
plot(target_test, '--r', 'LineWidth',2)