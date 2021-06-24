function dEuc=EuclideanDistance(sample1, sample2)
    total = 0;
    for i=1:length(sample1)
        total = total + (sample1(i) - sample2(i))^2;
    end
    dEuc = sqrt(total);
end