%% Robot setup

rbt = loadrobot("universalUR5e",DataFormat="row");

% suctionGripper = rigidBody('gripper');
% rbt.addBody(suctionGripper, "tool0");
chomp = manipulatorCHOMP(rbt);

% collision ground

hms = se3([0 0 -0.1 1 0 0 0], 'xyzquat');
gndBox = collisionBox(2, 2, 0.1);
gndBox.Pose = hms.tform;
%addCollision(rbt.Base, gndBox)
show(rbt, 'visuals', 'on', 'collision', 'on')

chomp = manipulatorCHOMP(rbt);
chomp.SphericalObstacles = spObsHelper();

chomp.CollisionOptions.CollisionCostWeight = 10;
chomp.SmoothnessOptions.SmoothnessCostWeight = 1e-3;
chomp.SolverOptions.LearningRate = 5;


%% Setup detector
load detector.mat
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

%% Controller
dt_control = 0.010;

%% Planner setup
plannerTimeStep = 0.2;

%% INIT
rbtBasePos = [-0.4 1.3 0.6];


%% Helpers
function obs = spObsHelper()
    xRange = -2:0.2:2;
    yRange = xRange;
    z = 0.25;
    radius = 0.09;
    [x,y, z, radius] = ndgrid(xRange, yRange, z, radius);
    obs = [radius(:), x(:), y(:), z(:)]';

end