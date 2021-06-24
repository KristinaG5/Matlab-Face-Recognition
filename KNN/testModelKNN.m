function accuracy = testModelKNN(testX, testY, model, neighbours, distanceMeasure)
    total_correct = 0;
    for t=1:size(testX, 1)
        test = testX(t,:);
        classificationResult = KNNTesting(test, model, neighbours, distanceMeasure);
        actual = testY(t,:);
        if classificationResult == actual
            total_correct = total_correct + 1;
        end
    end
    accuracy = total_correct / size(testX, 1);
end