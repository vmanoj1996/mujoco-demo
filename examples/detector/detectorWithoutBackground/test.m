im = imread('img81.png');

[bbox, score] = slDetect(im)

annotation = sprintf('Confidence = %.1f',score);
im = insertObjectAnnotation(im,'rectangle',bbox,annotation);

close all
imshow(im)