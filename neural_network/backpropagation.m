% Backpropagation Algorithm


% E(k) = 1/2 * (e(k))^2 
%      = 1/2 * (d(k) - o2(k))^2

% w2(k+1) = w2(k) + (-nw * dE(x)/dw2(k))
% dE(x)/dw2(x) = = -e*F2'*o1

% dE(k)/dw1(j)(k) = -e*F2' * w2(j) * F1'(x)

clc;
clear;

u(:,1) = 8 - 2*rand(1000,1);
y(3,1) = 0;

for t=4:length(u)
    y(t) = (y(t-1)*y(t-2))



