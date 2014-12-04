function featData = extractFFT(rdata, numFeatures)
%FFT from continuous normalized chaincode feature extractor 
    %TODO TO MUCH CODE duplication from featExtract 
    box_data  = im_box(rdata,1,0); %remove empty empty border columns and rows 
    p36_data  = im_resize(box_data,[36 36]); % resize to 36*36
    dataset   = prdataset(p36_data);%convert to dataset
    featData  = [];
    for i=1:size(rdata,1)
        BWlist   = contour(data2im(dataset,i));%get contour coordinate
        ChainC   = chaincode(BWlist); % get chaincode
        CChainC = continuousChain(ChainC); %continous chaincode (no jumps from 8 <-> 0)
        
        %Get FFT
        N =length(CChainC);
        X = fft(CChainC) / N;%normalized fft
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
        j=1;
        k=1;
        Y = 0;
        fH = -0.5 + 0.5/numFeatures;
        for k=1:numFeatures
            Y(k) = 0;
        end
        k=1;
        while k < numFeatures
          %Trapeze calculation
          Y(k) =  Y(k) + X(j)*(freq(j+1)-freq(j)) + 0.5*(freq(j+1)-freq(j))*(X(j+1)-X(j));
          if freq(j) > fH;%integration period
              k = k+1;
              fH = -0.5 + 0.5/numFeatures;
          end
          j = j+1;
        end
        featData = [featData; prdataset(Y(1:numFeatures), getlab(dataset(i,:)))]; %save in dataset (numfeatures checks same amount features saved (more debug option))
    end