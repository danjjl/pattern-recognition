oPClass = 100; % objects per class
n = floor(1000/oPClass);
%train
rdata        = prnist([0:9],[1:n:1000]);
trnData      = featExtract(rdata);

%test
rdata        = prnist([0:9],[2:floor(n/10):1000]);
tstData      = featExtract(rdata);

testc(tstData*(trnData*ldc))