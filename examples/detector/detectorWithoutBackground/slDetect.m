function [bbox, score] = slDetect(image)

persistent d background

if isempty(d)
    s = coder.load("detectorCG_withoutBG.mat"); 
    d = acfObjectDetector(s.detectorStruct.Classifier,s.detectorStruct.TrainingOptions);
    bg = coder.load('background.mat');
    background = bg.background;
end

maxS = double([120 120]);

grayImg = im2gray(image);
imageWObg = imsubtract(grayImg, background);
% imshow(imageWObg)
[bboxes,scores] = detect(d, imageWObg, WindowStride=2, NumScaleLevels=12, SelectStrongest=false, maxSize=maxS);

if isempty(bboxes)
    bbox = double(zeros(1,4));
    score = double(0);
else
    idx = scores>95;
    bbox = sum(bboxes(idx, :))/length(scores(idx));
    score = sum(scores(idx))/length(scores(idx));
end