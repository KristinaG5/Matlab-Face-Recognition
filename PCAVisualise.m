addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\

% Params
augment = false;
feature_extraction = "hoglib";

[X, Y] = getData(augment, feature_extraction);
[U,S,X_reduce] = pca(X,3);

figure, hold on
faces = find(Y == 0);
non_faces = find(Y == 1);
plot3(X_reduce(faces,1),X_reduce(faces,2),X_reduce(faces,3),'r.')
plot3(X_reduce(non_faces,1),X_reduce(non_faces,2),X_reduce(non_faces,3),'g.')
