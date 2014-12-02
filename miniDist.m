function mini = miniDist(tst, means)
    mini = 0;
    dist = 100;
    for i=1:10
        if norm(+tst - +means(i,:)) < dist
            dist = norm(+tst - +means(i,:));
            mini = getlab(means(i,:));
        end
    end
end