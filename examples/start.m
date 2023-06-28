%% Path Setup
addpath('./detector');
addpath('./models');
addpath('./detector/acfDetectorWithBackground/')

%% Robot and perception
robotsetup;
perceptionsetup;

%% Controller
dt_control = 0.010;

%% Planner setup
plannerTimeStep = 0.2;


