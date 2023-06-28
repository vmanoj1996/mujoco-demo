
%% Training
clear all
load gtruth3.mat

rangeSt = 1;
trainingdata = [gTruth.DataSource.Source(rangeSt:end), gTruth.LabelData(rangeSt:end, :)];
detector = trainACFObjectDetector(trainingdata, NegativeSamplesFactor=20, NumStages=5)

detectorStruct = toStruct(detector);

save ../acfDetectorWithBackground/detector.mat detector
save ../acfDetectorWithBackground/detectorCG.mat detectorStruct

