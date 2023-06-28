function [bbox, score] = slDetect(image)

persistent d background

if isempty(d)
    % if coder.target('MATLAB')
    %     s = load("detector.mat");
    %     d = s.detector;
    % else
        s = coder.load("detectorCG_withoutBG.mat");
        d = acfObjectDetector(s.detectorStruct.Classifier,s.detectorStruct.TrainingOptions);
        background = rgb2gray(imread('background.png'));
    % end
end

maxS = double([120 120]);

grayImg = im2gray(image);
imageWObg = imsubtract(grayImg, background);
imshow(imageWObg)
[bboxes,scores] = detect(d, imageWObg, WindowStride=2, NumScaleLevels=12, SelectStrongest=false, maxSize=maxS);

for i = 1:length(scores)
   annotation = sprintf('Confidence = %.1f',scores(i));
   imageWObg = insertObjectAnnotation(imageWObg,'rectangle',bboxes(i,:),annotation);
end
imshow(imageWObg)

if isempty(bboxes)
    bbox = double(zeros(1,4));
    score = double(0);
else
    % [score, i] = max(selectedScore);
    % bbox = selectedBbox(i, :);
    % bbox = selectedBbox;
    % score = selectedScore;

    % [selectedBbox,selectedScore] = selectStrongestBbox(bboxes,scores,'OverlapThreshold', ot);
    idx = scores>90;
    bbox = sum(bboxes(idx, :))/length(scores(idx));
    score = sum(scores(idx))/length(scores(idx));

end