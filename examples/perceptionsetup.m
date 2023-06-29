%% Setup perception
%load detector.mat
dt_kf = 0.040;
dt_predictor = 0.010;
% dt_img = 0.050;
A_cont = [0 0 1 0;0 0 0 1;0 0 0 0;0 0 0 0];
A_discrete = A_cont*dt_kf+eye(4);
C = [1 0 0 0;0 1 0 0];

xDot_err_var = 0.001;
vxDot_err_var = 0.1;

X0 = zeros(4,1);
P0 = 10*diag([1 1 1 1]);
Q = dt_kf^2*diag([xDot_err_var, xDot_err_var, vxDot_err_var, vxDot_err_var]);
Qbad = dt_kf^2*diag([1 1 1 1]);
R = 2.5e-5*diag([1 1]);