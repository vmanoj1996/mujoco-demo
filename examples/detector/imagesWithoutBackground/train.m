load trainingData.mat

detector = trainACFObjectDetector(trainingdata, NegativeSamplesFactor=20, NumStages=5)
detectorStruct = toStruct(detector);


% save ../detectorWithoutBackground/detector.mat detector
save ../detectorWithoutBackground/detectorCG_withoutBG.mat detectorStruct