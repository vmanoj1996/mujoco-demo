function [optimtraj, timesamples, N] = planner(goalXYZ)

persistent chomp rbt currentConfig ik rbtBasePos

% Configuration
initialguess = [pi -pi/4 pi/4 -pi/2 -pi/2 0];
weights = [1 1 1 1 1 1];

if isempty(chomp)
    chomp = evalin('base', 'chomp');
    rbt = evalin('base', 'rbt');
    currentConfig = [0 0 0 0 0 0];
    ik = inverseKinematics('RigidBodyTree', rbt);
    plannerTimeStep = evalin('base', 'plannerTimeStep');
    rbtBasePos = evalin('base', 'rbtBasePos');
end

% Convert XY_gnd to robot frame
pos = goalXYZ - rbtBasePos;
quat = [0 0 1 0];

hms = se3([pos quat], 'xyzquat');
[goalConfig, solInfo] = ik('tool0', hms.tform, weights, initialguess);


wps = [currentConfig; goalConfig];
tpts = [0 1];

[optimtraj, timesamples] = optimize(chomp, wps, tpts, 0.2);
currentConfig = goalConfig;

numSteps = size(optimtraj, 1);
N = length(timesamples);
timesamples = [timesamples, -1];
% disp(timesamples)


end