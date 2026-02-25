function output = bipolar_sigmoid(var)
    output = (1-exp(-var))./(1+exp(-var));
end