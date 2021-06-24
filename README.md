# CSC3067 Face Classifier

All scripts contain a '`% Params`' section at the top to customise parameters.

## Contents
1. [**Training & Applying face detection**](#training-applying-face-detection)
2. [**Training & evaluating models**](#training-evaluating-models)
4. [**Visualisations**](#visualisations)

## Training & Applying face detection

Run `Train.m` to train a model & apply face extraction to test images (model, confidence & test size can be changed in params)

![scan image preview](/sample_images/scanImage.png)

You can also see how what each box scored by setting `show_scores` to true.

![score image preview](/sample_images/scores.png)

You can also run `trainKFold.m` to apply k fold cross validation during training. 

## Training & evaluating models

### SVM

Running `SVM.m` should produce a comparison chart between the custom SVM code found in the SVM directory, and `fitcsvm`

![svm image preview](/sample_images/SVM.png)

### KNN

Running `KNN.m` should produce a comparison chart between the custom KNN code found in the KNN directory, and `fitcknn`

![knn image preview](/sample_images/KNN.png)

### Random Forest Classifier

Running `RandomForestClassifier.m` trains a random forest classifier and outputs the tree & accuracy scores

![knn tree preview](/sample_images/RFC_tree.png)
![knn scores preview](/sample_images/RFC.png)

### Adaboost

Running `Adaboost.m` trains a variety of boosting methods and outputs accuracy scores against the number of learning cycles

![adaboost preview](/sample_images/Adaboost.png)

## Visualisations

### Feature extraction Visualise

Running `FeatureExtractionVisualise` shows visualisations for the HOG & Edge extraction filters 

![filter visualisations](/sample_images/featureExtraction.png)

### Overfitting Visualise

Running `FittingEvaluation.m` visualises the acccuracy differences for train/test data to analyse overfitting

![fitting visualisations](/sample_images/overfitting.png)

### PCA Visualise

Running `PCAVisualise.m` visualises the data using PCA

![fitting visualisations](/sample_images/pca.png)

### Performance evaluation

Running `PerformanceEvaluation.m` produces performance metrics for all classifiers and produces ROC curves

![ROC visualisations](/sample_images/ROC.png)

### Compare

Running `compare.m` compares all the classifiers & feature extractors on the same data
