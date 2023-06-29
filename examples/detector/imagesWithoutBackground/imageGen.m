% messes up the order for some reason
background = rgb2gray(imread('background.png'));

fileList = {};
for index = 51:100
    str = ['../imagesWithBackground/img', num2str(index), '.png'];
    im = rgb2gray(imread(str));
    strWrite = ['imgWObg', num2str(index), '.png'];
    imWithoutBg = imsubtract(im, background);
    imwrite(imWithoutBg, strWrite);
    fileList{end+1} = strWrite;
end

load gtruth_table.mat

trainingdata = [fileList', gtruth_table];
save trainingData1.mat trainingdata

