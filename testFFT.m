oPClass = 100; % objects per class
n = floor(1000/oPClass);
numFeatures = 10;

%train
rdata        = prnist([0:9],[1:n:1000]);
trnData      = extractFFT(rdata, numFeatures);

%test
rdata        = prnist([0:9],[2:n:1000]);
tstData      = extractFFT(rdata, numFeatures);

%classify
[E,C] = testc(tstData*(trnData*qdc))
