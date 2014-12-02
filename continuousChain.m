function chain = continuousChain(chain)
    plus = 0;
    minus = 0;
    nplus = 0;
    nminus = 0;
    for i=1:max(size(chain))-1
        if chain(i) == 8 && chain(i+1) == 0 %trig turn
            nplus = plus + 1;
        elseif chain(i) == 0 && chain(i+1) == 8 %clock turn
            nminus = minus + 1;
        end
        chain(i) = chain(i) + 9*(plus-minus);
        plus = nplus;
        minus = nminus;
    end
    chain(end) = chain(end) + 9*(plus-minus);