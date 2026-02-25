function [w1,w2] = gradient_descent_nn(e, eta, u, o1, net1, net2, w1, w2)
    % bipolar sigmoid activation function
    df1 = @(x) 2 * exp(-x) ./ (1 + exp(-x)).^2;
    
    % monopolar sigmoid activation function
    df2 = @(x) exp(-x) ./ (1 + exp(-x)).^2; 

    delta2 = e.*df2(net2);
    w2 = w2 + eta * o1 * delta2;

    delta1 = (w2 * delta2) .* df1(net1);
    w1 = w1 + eta * u *(delta1);
end