% a = imread('images/img70.jpg');
%
% libLocation = 'C:\Temp\mujoco-cv\examples\codegen\lib\slDetect';
% libName = 'slDetect';
%
% headerLocation = 'C:\Temp\mujoco-cv\examples\codegen\lib\slDetect\interface';
% header='_coder_slDetect_api.h';
%
% nam = 'slDetect'
% if ~libisloaded(nam)
%    %addpath()
%    loadlibrary(nam, 'slDetect.h')
% end

robot = loadrobot("universalUR5e",DataFormat="row");
chomp = manipulatorCHOMP(robot);

env = [0.20 0.2 -0.1 -0.1;   % sphere, radius 0.20 at (0.2,-0.1,-0.1)
    0.15 0.2  0.0  0.5]'; % sphere, radius 0.15 at (0.2,0.0,0.5)
chomp.SphericalObstacles = env;

homp.SmoothnessOptions = chompSmoothnessOptions(SmoothnessCostWeight=1e-3);
chomp.CollisionOptions = chompCollisionOptions(CollisionCostWeight=10);
chomp.SolverOptions = chompSolverOptions(Verbosity="none",LearningRate=7.0);

startconfig = homeConfiguration(robot);
goalconfig = [0.5 1.75 -2.25 2.0 0.3 -1.65 -0.4];
timepoints = [0 5];
timestep = 0.1;
trajtype = "minjerkpolytraj";
% [wptsamples,tsamples] = optimize(chomp, ...
%     [startconfig; goalconfig], ...
%     timepoints, ...
%     timestep, ...
%     InitialTrajectoryFitType=trajtype);
show(chomp,wptsamples,NumSamples=10);
zlim([-0.5 1.3])

