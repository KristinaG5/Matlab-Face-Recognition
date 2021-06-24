addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\

% Params
augment = true;
iterations = 2;
training_iterations = 100;
feature_extraction = "hoglib";

[X, Y] = getData(augment, feature_extraction);
average_scores = zeros(4,1);
average_num_nodes = zeros(4,1);
best_score = 0;
best_tree = 0;
best_split = 0;

counter = 1;

for split=0.1:0.1:0.5
    scores = zeros(iterations, 1);
    nodes = zeros(iterations, 1);
    for i=1:iterations
        partition = cvpartition(Y,'HoldOut',split);
        train_indexes = partition.training;
        test_indexes = partition.test;

        trainX = X(train_indexes,:);
        testX = X(test_indexes,:);
        trainY = Y(train_indexes);
        testY = Y(test_indexes);

        model = TreeBagger(training_iterations,trainX,trainY,'OOBPrediction','On','Method','classification');
        accuracy = 1 - min(oobError(model));
        scores(i) = accuracy;
        
        if accuracy > best_score && split > 0.15
            best_score = accuracy;
            best_tree = model;
            best_split = split;
        end
    end
    average_scores(counter) = mean(scores);
    average_num_nodes(counter) = mean(nodes);
    counter = counter + 1;
end

hold on
xlabel("Test size");
ylabel("Accuracy");
plot([10, 20, 30, 40, 50], average_scores, 'DisplayName','RFC');
legend;

view(best_tree.Trees{1},'Mode','Graph');

fprintf("RFC average score: %f \n", mean(average_scores));  
fprintf("RFC best tree: %f %f\n", best_score, best_split);   

