%% settings
xMin = -0.2;
xMax = 0.2;
yMin = -0.4;
yMax = 0.4;
fileIn = '../models/syntheticDataScene_template.xml';
fileOut = '../models/syntheticDataScene.xml';
model = 'syntheticData.slx';
imgoffset = 0;


%% grid generate
xVec = linspace(xMin, xMax, 5);
yVec = linspace(yMin, yMax, 5);

[xgrid, ygrid] = meshgrid(xVec, yVec);

xgrid = xgrid(:);
ygrid = ygrid(:);

%% Loop and generate images
load_system(model);

for index=1:length(xgrid)
    fstr = fileread(fileIn);
    fstr = replace(fstr, '$x$', string(xgrid(index)));
    fstr = replace(fstr, '$y$', string(ygrid(index)));
    writelines(fstr, fileOut);

    sim(model);
    % imshow(vout)
    imwrite(vout, strcat('./images1/img', string(index+imgoffset), '.png'));
end

