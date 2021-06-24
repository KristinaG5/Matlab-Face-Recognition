function model = selectModel(name, trainX, trainY)
    if name == "svm"
        model = SVMtraining(trainX, trainY);
    elseif name == "knn"
        model = NNtraining(trainX, trainY);
    elseif  name == "libsvm"
        model = fitcsvm(trainX,trainY,'KernelFunction','polynomial','BoxConstraint',2);
    elseif name == "libknn"
        model = fitcknn(trainX,trainY);
    elseif name == "adaboost"
        model = fitensemble(trainX,trainY,"AdaBoostM1",1000,'Tree');
    elseif name == "gentleboost"
        model = fitensemble(trainX,trainY,"GentleBoost",1000,'Tree');
    elseif name == "rfc"
        model = TreeBagger(100,trainX,trainY,'OOBPrediction','On','Method','classification');
    else
        error("Please select a valid model from: svm, knn, libsvm, libknn, adaboost, rfc");
    end
end