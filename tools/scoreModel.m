function accuracy = scoreModel(model, name, testX, testY)
    if name == "svm"
        accuracy = testModelSVM(testX, testY, model);
    elseif name == "knn"
        accuracy = testModelKNN(testX, testY, model, 3, "manhattan");
    elseif name == "rfc"
        accuracy = 1-min(oobError(model));
    else
        accuracy = 1-loss(model,testX,testY);
    end
end