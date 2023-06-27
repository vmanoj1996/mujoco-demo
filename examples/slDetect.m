function [bbox, score] = slDetect(image)

persistent d

if isempty(d)
    % if coder.target('MATLAB')
    %     s = load("detector.mat");
    %     d = s.detector;
    % else
        s = coder.load("detectorCG.mat");
        d = acfObjectDetector(s.detectorStruct.Classifier,s.detectorStruct.TrainingOptions);
    % end
end

maxS = double([120 120]);
ot = double(0.05);
% searcharea = [120 1 400 480];

[bboxes,scores] = detect(d, image, WindowStride=2, NumScaleLevels=12, SelectStrongest=false, maxSize=maxS);

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