%% clean
clc;
clear;
%% raw data -> self given dataset
file_name = 'data_qc.csv';
dataset = readtable(file_name);
%% number of qubit define:
% since we have 2 var : x1,x2 -> qubit use = 2
qubit = 2;
%% call out the data variable
% data input
x1 = dataset.x1;
x2 = dataset.x2;
% label
label = dataset.label;

%% normalize
max_val = max(max(x1),max(x2));
x1 = x1/max_val * pi;
x2 = x2/max_val * pi;

%% define initial quantum state |00>
state0 = [1;0;0;0];
%% Define rotation matix
RY1 = cell(length(x1),1); % this is use `cell` for store `matrix` as single element 
RY2 = cell(length(x2),1);
U = cell(length(x1),1);
for i = 1:length(x1)
    RY1{i} = rotation_matrix(x1(i));
    RY2{i} = rotation_matrix(x2(i));
    % Encoding circuit
    U{i} = kron(RY1{i}, RY2{i});
end
%% Variable change
theta1 = 0.5;
theta2 = -0.3;
RYt1 = rotation_matrix(theta1);
RYt2 = rotation_matrix(theta2);
W = kron(RYt1, RYt2);
%% Observable
Z = [1,0;0,-1];
I = eye(qubit);
O = kron(Z, I);
%% VQC Forward pass

for i = 1:length(x1)
    % quantum state preparation
    psi = W * U{i} * state0;

    % measurement
    % psi' stands for conjugate transpose
    % psi' is bra vector (row vector) | psi is ket vector (column vector)
    f = psi' * O * psi; % expectation value
    
    disp(['Sample ', num2str(i), ' output:'])
    disp(f)
    
    % loss
    y = label(i);
    loss = (f - y)^2;

    disp(['Sample ', num2str(i), ' loss:'])
    disp(loss)
end

theta1_p = theta1 + pi/2;
theta1_m = theta1 - pi/2;

RYp = [cos(theta1_p/2) -sin(theta1_p/2);
       sin(theta1_p/2)  cos(theta1_p/2)];

RYm = [cos(theta1_m/2) -sin(theta1_m/2);
       sin(theta1_m/2)  cos(theta1_m/2)];

Wp = kron(RYp, RYt2);
Wm = kron(RYm, RYt2);

psi_p = Wp * U * state0;
psi_m = Wm * U * state0;

f_p = psi_p' * O * psi_p;
f_m = psi_m' * O * psi_m;

grad_theta1 = (f_p - f_m)/2;

disp('Gradient theta1:')
disp(grad_theta1)

eta = 0.1;
theta1 = theta1 - eta * grad_theta1;

function RY = rotation_matrix(val)
    RY = [cos(val/2),-sin(val/2);sin(val/2),cos(val/2)];
end