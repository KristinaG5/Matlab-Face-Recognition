addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\
addpath .\KNN\
addpath .\detection\

% Params
augment = true;
model_names = ["libsvm", "libknn", "adaboost", "rfc", "knn", "svm"];
feature_extraction_name = "hoglib";
test_size = 0.2;

faces = uint8(loadImages("images/face/", augment));
non_faces = uint8(loadImages("images/non-face/", augment));
partition = cvpartition(length(faces)+length(non_faces),'HoldOut',test_size);
train_indexes = partition.training;
test_indexes = partition.test;
warning('off');

% Load data
[X, Y] = getTrainData(faces, non_faces, feature_extraction_name);
X = double(X);
Y = double(Y);

% Train-test split
trainX = X(train_indexes,:);
testX = X(test_indexes,:);
trainY = Y(train_indexes);
testY = Y(test_indexes);

hold on;
xlabel('False positive rate'); 
ylabel('True positive rate');
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
    fprintf("\n%s - %s %f\n", feature_extraction_name, model_name, accuracy);
    
    %Predict
    [class, predictions] = predictOnModel(model, model_name, testX);
    
    if model_name == "svm"
        testY(testY==-1)=0;
        class(class==-1)=0;
    end
    
    %ROC curve
    [X_model,Y_model,T_model,AUC_model] = perfcurve(testY,predictions,0);

    plot(X_model,Y_model, 'DisplayName', model_name + " - AUC: " + AUC_model);
    
    [TP, FP, TN, FN, N] = calculateFPR(testY, class);
    
    acc = (TN+TP) / N;
    err = (FN+FP) / N;
    recall = TP / (TP+FN);
    precision = TP / (TP+FP);
    specificity = TN / (TN+FP);
    f_measure = (2*TP) / ((2*TP) + FN + FP);
    false_alarm_rate = FP / (FP+TN);
    fprintf("\nType 1&2 errors for %s:\naccuracy: %f\nerror: %f\nrecall: %f\nprecision: %f\nspecificity: %f\nF-measure: %f\nFalse alarm rate: %f\n", model_name, acc, err, recall, precision, specificity, f_measure, false_alarm_rate);
end
legend;
