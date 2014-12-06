function Y = extractFFT(cChainC, numFeatures)
%FFT from continuous normalized chaincode feature extractor
%returns fft integrated in numFeatures bins

%Get FFT
N =length(cChainC);
X = fft(cChainC) / N;%normalized fft
X = fftshift(X); % centered around 0
X = abs(X); %not interested in phase shift (OR ARE WE?)

%calculate freq axis
if mod(N,2)==0
    k=-N/2:N/2-1; % N even
else
    k=-(N-1)/2:(N-1)/2; % N odd
end
freq=k/N;  %the frequency axis

%integrate periods of FFT (feature reduction)
j=1; k=1; Y=zeros(1, numFeatures);
fH = -0.5 + 0.5/numFeatures;
while k < numFeatures
    %Trapeze calculation
    Y(k) =  Y(k) + X(j)*(freq(j+1)-freq(j)) + 0.5*(freq(j+1)-freq(j))*(X(j+1)-X(j));
    if freq(j) > fH;%integration period
        k = k+1;
        fH = -0.5 + 0.5/numFeatures;
    end
    j = j+1;
end