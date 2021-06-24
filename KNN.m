addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\KNN\

% Params
augment = false;
iterations = 2;
neighbours = 3;
feature_extraction = "hoglib";
distance_measure = "manhattan";

[X, Y] = getData(augment, feature_extraction);
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

        custom_model = NNtraining(trainX, trainY);
        library_model = fitcknn(trainX,trainY,'NumNeighbors', neighbours);
        custom_scores(i) = testModelKNN(testX, testY, custom_model, neighbours, distance_measure);
        library_scores(i) = 1 - loss(library_model,testX,testY);
    end
    average_library_scores(counter) = mean(library_scores);
    average_custom_scores(counter) = mean(custom_scores);
    counter = counter + 1;
end

hold on
xlabel("Test size");
ylabel("Accuracy");
plot([10, 20, 30, 40, 50], average_custom_scores, 'DisplayName','Custom KNN code');
plot([10, 20, 30, 40, 50], average_library_scores, 'DisplayName','fitcknn library');
legend;

fprintf("Custom: %f\n", mean(average_custom_scores));
fprintf("Library: %f\n", mean(average_library_scores));
