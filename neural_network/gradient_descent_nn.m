function [w1,w2] = gradient_descent_nn(e, eta, u, o1, net1, net2, w1, w2)
    % bipolar sigmoid activation function
    df1 = @(x) 2 * exp(-x) ./ (1 + exp(-x)).^2;
    df2 = @(x) exp(-x) ./ (1 + exp(-x)).^2; 
    % monopolar sigmoid activation function
    
end