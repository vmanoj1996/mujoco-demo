
%% Training yolo 3

load gtruth.mat

trainingdata = [gTruth.DataSource.Source, gTruth.LabelData];

net = squeezenet
analyzeNetwork(net)
% 
% options = trainingOptions('sgdm',...
%           'InitialLearnRate',0.001,...
%           'Verbose',true,...
%           'MiniBatchSize',8,...
%           'MaxEpochs',30,...
%           'Shuffle','once',...
%           'VerboseFrequency',30,...
%           'CheckpointPath',tempdir);
% 
% [detector,info] = trainYOLOv2ObjectDetector(trainingdata,lgraph,options);
% 
% %% Test
% testimage = imread('img39.jpg');
% [bboxes,scores] = detector.detect(testimage);
% 
% 
% for i = 1:length(scores)
%        annotation = sprintf('Confidence = %.1f',scores(i));
%        testimage = insertObjectAnnotation(testimage,'rectangle',bboxes(i,:),annotation);
% end
% 
% figure
% imshow(testimage);