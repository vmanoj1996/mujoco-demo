%% Test on another image
close all

%% Test on the entire training data
set = gTruth.DataSource.Source;
for file = set'
    close all
    detectionAndPlot(file{:}, detector);
    waitforbuttonpress()
end

%% Helper
function detectionAndPlot(imagefile, detector)
    testimage = imread(imagefile);
    [bboxes,scores] = detector.detect(testimage, WindowStride=2, NumScaleLevels=12);
    
    [bboxes,scores] = selectStrongestBbox(bboxes,scores,'OverlapThreshold', 0.05);
    
    for i = 1:length(scores)
        if scores(i)>90
            annotation = sprintf('Confidence = %.1f',scores(i));
            testimage = insertObjectAnnotation(testimage,'rectangle',bboxes(i,:),annotation);
        end
    end
    
    figure('WindowState', 'fullscreen');
    imshow(testimage)

end