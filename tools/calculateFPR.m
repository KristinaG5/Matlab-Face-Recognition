function [TP, FP, TN, FN, N] = calculateFPR(testY, class)
    %Calculate False Positive Rate to analyse type 1&2 errors
    %Input parameters:
    %testY is the ground-truth labels
    %class is the predicted labels
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    N = length(testY);

    for i=1:N
        correct = testY(i);
        pred = class(i);
        if iscell(pred)
            pred = str2double(pred{1});
        end
        if correct == pred
            if correct == 0
                TP = TP + 1;
            else
                TN = TN + 1;
            end
        else
            if correct == 0
                FN = FN + 1;
            else
                FP = FP + 1;
            end
        end
    end
end