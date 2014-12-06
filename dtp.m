function turnPoints = dtp(dChainC)
%Direction Turning Point: Implement DTP as described in (Recognition Method
%for Handwritten Digits Based on Improved Chain Code Histogram Feature)
%Aim is to get the frequency of hard turns.
turnPoints = 0;
for i=1:length(dChainC)
    if i>3 && dChainC(i) ~= 0 && dChainC(i-1) == 0 && dChainC(i-2) == 0
        turnPoints = turnPoints + 1;
    end
    if i>3 && dChainC(i) == dChainC(i-1) && dChainC(i) == dChainC(i-2) && (dChainC(i) == 1 || dChainC(i) == 7)
        turnPoints = turnPoints + 1;
    end
    if 2 <= dChainC(i) && dChainC(i) <= 6
        turnPoints = turnPoints + 1;
    end
end
turnPoints = turnPoints / length(dChainC);

