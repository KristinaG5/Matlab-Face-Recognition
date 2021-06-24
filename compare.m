addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\
addpath .\KNN\
addpath .\detection\

% Params
augment = false;
model_names = ["knn", "libsvm", "libknn", "adaboost", "rfc", "svm"];
feature_extraction_names = ["hoglib", "hog", "concat", "edge", "gabor"];
test_size = 0.2;

faces = uint8(loadImages("images/face/", augment));
non_faces = uint8(loadImages("images/non-face/", augment));
partition = cvpartition(length(faces)+length(non_faces),'HoldOut',test_size);
train_indexes = partition.training;
test_indexes = partition.test;
warning('off');

for f=1:length(feature_extraction_names)
    % Load data
    feature_extraction_name = feature_extraction_names(f);
    [X, Y] = getTrainData(faces, non_faces, feature_extraction_name);
    X = double(X);
    Y = double(Y);

    % Train-test split
    trainX = X(train_indexes,:);
    testX = X(test_indexes,:);
    trainY = Y(train_indexes);
    testY = Y(test_indexes);
    
    for m=1:length(model_names)
        model_name = model_names(m);
        
        if model_name == "svm"
            trainY(trainY==0)=-1;
            testY(testY==0)=-1;
        end

        % Train
        model = selectModel(model_name, trainX, trainY);

        % Score
        accuracy = scoreModel(model, model_name, testX, testY);
        fprintf("%s - %s %f\n", feature_extraction_name, model_name, accuracy);
    end
end
