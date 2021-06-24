function features = selectFeatureExtraction(name, images)
    if name == "hoglib"
        features = HOGLibrary(images);
    elseif name == "hog"
        features = zeros(length(images),72);
        for i=1:length(images)
            features(i, :) = hog_feature_vector(images(:,:,i));
        end
    elseif name == "gabor"
        features = zeros(length(images),19440);
        for i=1:length(images)
            features(i, :) = gabor_feature_vector(images(:,:,i));
        end
    elseif name == "concat"
        [height, width] = size(images(:,:,1));
        features = zeros(length(images),height*width);
        for i=1:length(images)
            features(i, :) = concatPixels(images(:,:,i),height,width);
        end
    elseif name == "edge"
        [height, width] = size(images(:,:,1));
        features = zeros(length(images),(height + 2) * (width + 2));
        for i=1:length(images)
            edges = edgeExtraction(images(:,:,i));
            features(i, :) = reshape(edges, [1, (height + 2) * (width + 2)]);
        end
    else
        error("Please select a valid method from: hoglib, hog, gabor, concat, edge");
    end
end