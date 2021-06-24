addpath .\augmentation\
addpath .\tools\
addpath .\featureExtraction\
addpath .\SVM\
addpath .\SVM\SVM-KM\
addpath .\KNN\
addpath .\detection\

% Params
augment = true;
model_name = "rfc";
feature_extraction_name = "hoglib";
test_size = 0.2;

% sliding window params
scan_images = true;
show_scores = false;
images_to_scan = ["images\im1.jpg", "images\im2.jpg", "images\im3.jpg"];
min_confidence_score = 0.8;
max_overlap = 40;
cutout_height = 27;
cutout_width = 18;

% multi-scale params
resize = false;
resize_interval = 0.25;
resize_min = 0.75;
resize_max = 1;
boxes_weighting = 0.05;

% Load data
[X, Y] = getData(augment, feature_extraction_name);
if model_name == "svm"
    Y = double(Y);
    X = double(X);
    Y(Y==0)=-1;
end

% Train-test split
partition = cvpartition(Y,'HoldOut',test_size);
train_indexes = partition.training;
test_indexes = partition.test;

trainX = X(train_indexes,:);
testX = X(test_indexes,:);
trainY = Y(train_indexes);
testY = Y(test_indexes);

% Train
model = selectModel(model_name, trainX, trainY);

% Score
accuracy = scoreModel(model, model_name, testX, testY);
fprintf("Accuracy: %f\n", accuracy);

% Scan image
if scan_images
    for i=1:length(images_to_scan)
        I = imread(images_to_scan(i));
        boxes = getBoxes(I, model, model_name, feature_extraction_name, cutout_height, cutout_width, min_confidence_score, max_overlap);

        if resize
            best_image = [];
            best_score = 0;
            for scale=resize_min:resize_interval:resize_max
                resized = imresize(I, scale);
                current_boxes = getBoxes(resized, model, model_name, feature_extraction_name, cutout_height, cutout_width, min_confidence_score, max_overlap);
                score = scoreBoxes(current_boxes, boxes_weighting);
                fprintf("%f %f\n", scale, score);
                if score > best_score
                    boxes = current_boxes;
                    best_score = score;
                    best_image = resized;
                end 
            end
            I = best_image;
        end

        subplot(2,2,i);
        showBoxes(I, boxes, cutout_width, cutout_height, show_scores); 
        title(i); 
    end
end

