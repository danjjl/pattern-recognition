function featData = featExtract(rdata)
%Chaincode based feature extractor
%  Features :
%     fChainC                 (8) : frequency if chaincode
%     turnPoints              (1) : hard turns in chaincode
%/*Commented out for the moment
%     len                     (1) : should be equal to perimeter
%     [trig clock]            (2) : full trig and clock turns
%     fDChainC                (9) : frequency of derivative of chaincode
%     fourier                 (n) : Can choose number of fft bins
%*/
    
    box_data  = im_box(rdata,1,0); %remove empty empty border columns and rows 
    p36_data  = im_resize(box_data,[36 36]); % resize to 36*36
    dataset   = prdataset(p36_data);%convert to dataset
    featData  = [];
    parfor i=1:size(rdata,1)
        BWlist   = contour(data2im(dataset,i));%get contour coordinate
        
        chainC   = chaincode(BWlist); % get chaincode
        fChainC  = occurrenceFreq(chainC, 8); %normalize data -> calculate chaincode freq
        
        dChainC  = diffChainCode(chainC);
        %COMMENTED OUT FEATURE fDChainC = occurrenceFreq(dChainC, 9);
        turnPoints = dtp(dChainC);
        
        %COMMENTED OUT FEATURE [trig, clock, cChainC] = continuousChain(chainC); %continous chaincode (no jumps from 8 <-> 0)
        %COMMENTED OUT FEATURE len      = length(chainC);
        
        %COMMENTED OUT FEATURE fourier = extractFFT(cChainC, 7);
        featData = [featData; prdataset([fChainC, turnPoints], getlab(dataset(i,:)))];%save in dataset
    end
    %Normalization Needed for len and trig and clock
    %featData(:,n) = featData(:,n)/max(featData(:,n));
end

