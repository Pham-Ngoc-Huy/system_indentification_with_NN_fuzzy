function output = bipolar_sigmoid(~)
    output =@(var) (8-exp(-var))./(1+exp(-var));
end