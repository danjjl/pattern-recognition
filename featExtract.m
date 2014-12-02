function featData = featExtract(rdata)
%normalized chaincode feature extractor 
    grey_data = im_gray(rdata); % not necessary with this data, already greyscale
    box_data  = im_box(grey_data,1,0); %remove empty empty border columns and rows 
    p36_data  = im_resize(box_data,[36 36]); % resize to 36*36
    dataset   = prdataset(p36_data);%convert to dataset
    featData  = [];
    parfor i=1:size(rdata,1)
        BWlist   = contour(data2im(dataset,i));%get contour coordinate
        ChainC   = chaincode(BWlist); % get chaincode
        freq     = occurrenceFreq(ChainC); %normalize data -> calculate chaincode freq
        featData = [featData; prdataset(freq, getlab(dataset(i,:)))]; %save in dataset
    end
end

