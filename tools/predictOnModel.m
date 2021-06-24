function [class, predictions] = predictOnModel(model, name, images)
    num_images = size(images, 1);
    if name == "svm"
        predictions = zeros(1, num_images);
        class = zeros(1, num_images);
        for c=1:num_images
            [p, prediction] = SVMTesting(images(c,:),model);
            predictions(c) = -prediction;
            class(c)=p;
        end
    elseif name == "knn"
        predictions = zeros(num_images, 1);
        class = zeros(1, num_images);
        for c=1:num_images
            [p, prediction] = KNNTesting(images(c,:),model,3,"manhattan");
            if p == 0
                predictions(c,1) = prediction;
            else
                predictions(c,1) = -prediction;
            end
            class(c)=p;
        end
    else
        [class, predictions] = predict(model,images);
        predictions = predictions(:,1);
        if iscell(class)
            classes_cleaned = zeros(num_images, 1);
            for i=1:num_images
                classes_cleaned(i) = str2double(class{i});
            end
            class = classes_cleaned;
        end
    end
end