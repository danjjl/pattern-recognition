function [nplus, nminus, chain] = continuousChain(chain)
%Returns continuous chain code and number of trig and clock turns
    plus = 0; minus = 0; nplus = 0; nminus = 0;
    for i=1:max(size(chain))-1
        if chain(i) == 7 && chain(i+1) == 0 %trig turn
            nplus = plus + 1;
        elseif chain(i) == 0 && chain(i+1) == 7 %clock turn
            nminus = minus + 1;
        end
        chain(i) = chain(i) + 8*(plus-minus);
        plus = nplus;
        minus = nminus;
    end
    chain(end) = chain(end) + 8*(plus-minus);