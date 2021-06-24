function loss = calculateLoss(predictions, actual)
    num_correct = 0;
    num_items = size(predictions, 1);
    for i=1:num_items
        if predictions(i) == actual(i)
            num_correct = num_correct + 1;
        end
    end
    loss = 1 - (num_correct / num_items);
end