addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\

% Params
augment = false;
iterations = 2;
feature_extraction = "hoglib";

[X, Y] = getData(augment, feature_extraction);
Y = double(Y);
X = double(X);
Y(Y==0)=-1;

average_custom_scores = zeros(4,1);
average_library_scores = zeros(4,1);
counter = 1;

for split=0.1:0.1:0.5
    custom_scores = zeros(iterations, 1);
    library_scores = zeros(iterations, 1);
    for i=1:iterations
        fprintf("%f: %i\n", split, i);

        partition = cvpartition(Y,'HoldOut',split);
        train_indexes = partition.training;
        test_indexes = partition.test;

        trainX = X(train_indexes,:);
        testX = X(test_indexes,:);
        trainY = Y(train_indexes);
        testY = Y(test_indexes);

        custom_model = SVMtraining(trainX, trainY);
        library_model = fitcsvm(trainX,trainY);
        custom_scores(i) = testModelSVM(testX, testY, custom_model);
        library_scores(i) = 1 - loss(library_model,testX,testY);
    end
    average_library_scores(counter) = mean(library_scores);
    average_custom_scores(counter) = mean(custom_scores);
    counter = counter + 1;
end

hold on
xlabel("Test size");
ylabel("Accuracy");
plot([10, 20, 30, 40, 50], average_custom_scores, 'DisplayName','Custom SVM code');
plot([10, 20, 30, 40, 50], average_library_scores, 'DisplayName','fitcsvm library');
legend;

fprintf("Custom: %f\n", mean(average_custom_scores));
fprintf("Library: %f\n", mean(average_library_scores));
