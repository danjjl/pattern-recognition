oPClass = 25; % objects per class
n = floor(1000/oPClass);
%train
rdata        = prnist([0:9],[1:n:1000]);
trnData      = featExtract(rdata);
[means, var] = meancov(trnData);%calculate mean (and covariance)

%test
rdata        = prnist([0:9],[2:n:1000]);
tstData      = featExtract(rdata);

correct = 0;
len     = size(rdata,1);  
for i=1:size(rdata,1)
    n = miniDist(tstData(i,:), means);
    if getlab(tstData(i,:)) == n
        correct = correct +1;
    end
end
(len-correct) / len