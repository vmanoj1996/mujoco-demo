gtSource = groundTruthDataSource(fileList');

gTruth_store = groundTruth(gtSource, gTruth.LabelDefinitions, gtruth_table);

save gtruth_store1.mat gTruth_store