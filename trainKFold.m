addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\
addpath .\KNN\
addpath .\detection\

% Params
augment = true;
model_name = "rfc";
feature_extraction_name = "hoglib";
test_size = 0.2;
folds = 10;

% Load data
[X, Y] = getData(augment, feature_extraction_name);
if model_name == "svm"
    Y = double(Y);
    X = double(X);
    Y(Y==0)=-1;
end

% K fold cross validation
k_fold_partition = cvpartition(Y,'KFold',folds);

accuracy_scores = zeros(1, folds);

for i=1:folds
    train_indexes = training(k_fold_partition, i);
    test_indexes = test(k_fold_partition, i);

    trainX = X(train_indexes,:);
    testX = X(test_indexes,:);
    trainY = Y(train_indexes);
    testY = Y(test_indexes);

    % Train
    model = selectModel(model_name, trainX, trainY);

    % Score
    accuracy_scores(i) = scoreModel(model, model_name, testX, testY);
    fprintf("Fold: %i\n", i);
end

fprintf("Accuracy: %f\n", mean(accuracy_scores));
