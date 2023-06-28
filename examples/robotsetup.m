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