function dChainC = diffChainCode(chain)
%returns first order derivative of chaincode
dChainC = zeros(1, length(chain)-1);
for i=1:length(chain)-1
    n = chain(i+1) - chain(i);
    if n < 0 % 8 == -1, 7 == -2, ... 
        n = n+9;
    end
    dChainC(i) = n;
end