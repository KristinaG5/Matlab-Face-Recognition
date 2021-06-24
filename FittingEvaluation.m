addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\
addpath .\KNN\
addpath .\detection\

% Params
augment = true;
feature_extraction_name = "hoglib";
test_size = 0.2;
adaboost_cycles = 500;
cycle_step_size = 25;
rfc_trees = 500;
tree_step_size = 25;


[X, Y] = getData(augment, feature_extraction_name);
% Train-test split
partition = cvpartition(Y,'HoldOut',test_size);
train_indexes = partition.training;
test_indexes = partition.test;

trainX = X(train_indexes,:);
testX = X(test_indexes,:);
trainY = Y(train_indexes);
testY = Y(test_indexes);

adaboost_train = zeros(1,adaboost_cycles/cycle_step_size);
adaboost_test = zeros(1,adaboost_cycles/cycle_step_size);
adaboost_iteration_labels = zeros(1,adaboost_cycles/cycle_step_size);
rfc_train = zeros(1,rfc_trees/tree_step_size);
rfc_test = zeros(1,rfc_trees/tree_step_size);
rfc_iteration_labels = zeros(1,rfc_trees/tree_step_size);
item = 1;

for learning_cycles = 10:cycle_step_size:adaboost_cycles+1
    model = fitensemble(trainX,trainY,'AdaBoostM1',learning_cycles,'Tree');
    train_loss = loss(model, trainX, trainY);
    test_loss = loss(model, testX, testY);
    adaboost_train(item) = train_loss;
    adaboost_test(item) = test_loss;
    adaboost_iteration_labels(item) = learning_cycles;
    item = item + 1;
end

fprintf("%s = %f - %f\n", "adaboost", adaboost_train(size(adaboost_train,2)), adaboost_test(size(adaboost_test,2)));

item = 1;
for num_trees = 10:tree_step_size:rfc_trees+1
    model = TreeBagger(num_trees,trainX,trainY,'OOBPrediction','On','Method','classification');
    [train_predictions, ~] = predictOnModel(model, "rfc", trainX);
    train_loss = calculateLoss(train_predictions, trainY);
    [test_predictions, ~] = predictOnModel(model, "rfc", testX);
    test_loss = calculateLoss(test_predictions, testY);
    rfc_train(item) = train_loss;
    rfc_test(item) = test_loss;
    rfc_iteration_labels(item) = num_trees;
    item = item + 1;
end

fprintf("%s = %f - %f\n", "rfc", rfc_train(size(rfc_train,2)), rfc_test(size(rfc_test,2)));

other_models = ["knn", "libknn", "libsvm"];
for i=1:length(other_models)
    model_name = other_models(i);
    model = selectModel(model_name, trainX, trainY);
    train_loss = 1-scoreModel(model, model_name, trainX, trainY);
    test_loss = 1-scoreModel(model, model_name, testX, testY);
    fprintf("%s = %f - %f\n", model_name, train_loss, test_loss);
end

subplot(1,2,1);
hold on;
title("Adaboost");
xlabel('Number of Learning Cycles');
ylabel('Generalization Error');
plot(adaboost_iteration_labels, adaboost_train, 'DisplayName', "Train");
plot(adaboost_iteration_labels, adaboost_test, 'DisplayName', "Test");
legend;
hold off;

subplot(1,2,2);
hold on;
title("Random Forest");
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
plot(rfc_iteration_labels, rfc_train, 'DisplayName', "Train");
plot(rfc_iteration_labels, rfc_test, 'DisplayName', "Test");
legend;
hold off;
