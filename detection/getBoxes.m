function boxes=getBoxes(I, model, model_name, feature_extraction_name, cutout_height, cutout_width, min_confidence, max_overlap)
    cutouts = getCutouts(I, cutout_height, cutout_width);
    cutout_features = selectFeatureExtraction(feature_extraction_name, cutouts);
    [~, predictions] = predictOnModel(model, model_name, cutout_features);

    dimensions = size(I);
    width = dimensions(2);
    columns = width-cutout_width;
    boxes = extractFaceBoxes(predictions, columns, min_confidence, max_overlap, cutout_width, cutout_height);
end