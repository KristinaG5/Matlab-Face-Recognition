function accuracy = testModelSVM(testX, testY, model)
    total_correct = 0;
    for t=1:size(testX, 1)
        test = testX(t,:);
        classificationResult = SVMTesting(test, model);
        actual = testY(t,:);
        if classificationResult == actual
            total_correct = total_correct + 1;
        end
    end
    accuracy = total_correct / size(testX, 1);
end