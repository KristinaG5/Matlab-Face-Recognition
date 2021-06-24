function [prediction, confidenceValue] = KNNTesting(testImage, modelNN, K, distanceMeasure)
    best_index = zeros(1, K);
    best_value = zeros(1, K) + inf;

    for i=1:size(modelNN.neighbours, 1)
        sample = modelNN.neighbours(i,:);
        if distanceMeasure == "manhattan"
            distance = ManhattanDistance(testImage, sample);
        else
            distance = EuclideanDistance(testImage, sample);
        end
        
        weakest_value = 0;
        weakest_index = 0;
        for j=1:length(best_value)
            if best_value(j) > weakest_value
                weakest_value = best_value(j);
                weakest_index = j;
            end
        end
        
        if distance < weakest_value
            best_value(weakest_index) = distance;
            best_index(weakest_index) = i;
        end
    end
    
    confidenceValue = min(best_value) / mean(best_value);
    predictions = modelNN.labels(best_index);
    
    face = 0;
    non_face = 0;
    for i=1:length(predictions)
        if predictions(i) == 0
            face = face+1;
        else
            non_face = non_face+1;
        end
    end
    
    if face > non_face
        prediction = 0;
    else
        prediction = 1;
end