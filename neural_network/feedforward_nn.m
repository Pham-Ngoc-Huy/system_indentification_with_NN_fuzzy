% multilayer perceptron (MLP) Neural Networks

% example with 2 layers
% net1 = w_T_1 * x
% o1 = F1(net1) -> F1: stands for activation function
% net2 = w_T_2 * o1
% o2 = F2(net2) -> F2: stands for activation function

clc;
clear;

%% Activation Function
mono_sigmoid = @(z) 1 ./ (1+exp(-z)); % @(z) means create fast function
bipolar_sigmoid = @(z) (1-exp(-z)) ./ (1+exp(-z)); % using for 
% RELU = @(x) max(0,x);
%% input 
x = [0.2;0.2;0.8];

n_input = 3;
n_hidden = 4;
n_output = 1;

W1 = randn(n_input, n_hidden);
W2 = randn(n_hidden, n_output);

%% layer creation
net1 = W1' * x;
o1 = bipolar_sigmoid(net1);

net2 = W2' * o1;
o2 = mono_sigmoid(net2);

disp('net1 = ');
disp(net1);

disp('o1 = ');
disp(o1);

disp('net2 = ');
disp(net2);

disp('Final output o2 = ');
disp(o2);