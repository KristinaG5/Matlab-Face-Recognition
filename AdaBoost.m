addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\

% Params
augment = true;
max_cycles = 2000;
cycle_interval = 50;
aggregation_methods = ["AdaBoostM1", "LogitBoost", "GentleBoost", "RobustBoost", "RUSBoost"];
split = 0.2;
feature_extraction = "hoglib";

[X, Y] = getData(augment, feature_extraction);
num_values = int16(max_cycles/cycle_interval);
accuracy_scores = zeros(length(aggregation_methods), max_cycles);

partition = cvpartition(Y,'HoldOut',split);
train_indexes = partition.training;
test_indexes = partition.test;

trainX = X(train_indexes,:);
testX = X(test_indexes,:);
trainY = Y(train_indexes);
testY = Y(test_indexes);

for method=1:length(aggregation_methods)
    current_method = aggregation_methods(method);
    fprintf("%s\n", current_method);
    model = fitensemble(trainX,trainY,current_method,max_cycles,'Tree');
    rsLoss = resubLoss(model,'Mode','Cumulative');
    accuracy_scores(method,:) = rsLoss;
end

hold on
xlabel("Learning cycles");
ylabel("Accuracy");
for i=1:length(aggregation_methods)
    scores = 1 - accuracy_scores(i,:);
    method = aggregation_methods(i);
    fprintf("%s: %f\n", method, mean(scores));
    plot(scores, 'DisplayName', method);
end
legend;
