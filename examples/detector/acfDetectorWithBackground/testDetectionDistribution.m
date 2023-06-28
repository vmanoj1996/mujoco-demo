%% Test image
image = imread('images/img90.png');
maxS = double([120 120]);
[bboxes,scores] = detect(detector, image, SelectStrongest=false, maxSize=maxS);

imDetection = zeros(480, 640);
imageLabeled = image;
for i = 1:length(scores)
    if scores(i)>90
        annotation = sprintf('Confidence = %.1f',scores(i));
        imageLabeled = insertObjectAnnotation(imageLabeled,'rectangle',bboxes(i,:),annotation);
        imDetection = imDetection+cpy(bboxes(i, :), scores(i));
    end
end

close all
figure
imshow(imageLabeled);

figure
imageGrey = double(rgb2gray(image))/255;
imshow(imageGrey)

figure
imDetection = imDetection/max(imDetection(:));
imshow(imageGrey+imDetection/4)

centerVal = max(imDetection(:));
[r,c] = find(imDetection==centerVal);

function im = cpy(rect, score)
    im = zeros(480, 640);
    w = rect(3);
    h = rect(4);
    column = rect(1):rect(1)+w;
    row = rect(2):rect(2)+h;
    im(row, column) = score;
end