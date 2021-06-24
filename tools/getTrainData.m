function [X, Y] = getTrainData(class_a, class_b, feature_extraction_name)
    class_a_features = single(selectFeatureExtraction(feature_extraction_name, class_a));
    class_b_features = single(selectFeatureExtraction(feature_extraction_name, class_b));
    total_class_a = length(class_a);
    total_class_b = length(class_b);
    
    class_a_labels = uint8(zeros(length(class_a), 1));
	class_b_labels = uint8(zeros(length(class_b), 1) + 1);
    
    fprintf("%i %s\n", total_class_a, "total class A images");
    fprintf("%i %s\n", total_class_b, "total class B images");
    
    X = cat(1, class_a_features, class_b_features);
    Y = cat(1, class_a_labels, class_b_labels);
end