function data = HOGLibrary(images)
    feature_size = 72;
    data = zeros(length(images), feature_size);
    
    for i=1:length(images)
        data(i,:) = extractHOGFeatures(images(:,:,i));
    end
end
    