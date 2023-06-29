clear all
load trainingData.mat
trainingdata = [gTruth.DataSource.Source, gTruth.LabelData];

detector = trainACFObjectDetector(trainingdata, NegativeSamplesFactor=20, NumStages=5)
detectorStruct = toStruct(detector);

save ../detectorWithoutBackground/detectorCG_withoutBG.mat detectorStruct