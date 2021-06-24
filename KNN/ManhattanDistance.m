function dMan=ManhattanDistance(sample1, sample2)
    dMan = 0;
    for i=1:length(sample1)
        dMan = dMan + abs(sample1(i) - sample2(i));
    end
end