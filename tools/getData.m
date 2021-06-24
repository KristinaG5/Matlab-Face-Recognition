function [X, Y] = getData(augment, feature_extraction_name)
    faces = uint8(loadImages("images/face/", augment));
    non_faces = uint8(loadImages("images/non-face/", augment));
    [X, Y] = getTrainData(faces, non_faces, feature_extraction_name);
    clearvars faces non_faces
end