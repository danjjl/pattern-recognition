function BWlist = contour(I)
	%Return list of coordinates of boundary of closed object
	%Based on matlab tutorial: "Detecting a Cell Using Image Segmentation" (http://nl.mathworks.com/help/images/examples/detecting-a-cell-using-image-segmentation.html)
	
	%Detect entire object
	[~, threshold] = edge(I, 'sobel');
	fudgeFactor = .5;
	BWs = edge(I,'sobel', threshold * fudgeFactor);
	%figure, imshow(BWs), title('binary gradient mask');

	%Dilate the Image
    se = strel('disk',2, 0); %changed from line method used in tutorial because seems to give better results
    BWsdil = imdilate(BWs, se);
	%BWsdil = imdilate(BWs, [se90 se0]);
	%figure, imshow(BWsdil), title('dilated gradient mask');

	%Fill Interior Gaps
	BWdfill = imfill(BWsdil, 'holes');
	%figure, imshow(BWdfill), title('binary image with filled holes');
	
	%Smoothen the Object
	seD = strel('diamond',1);
	BWfinal = imerode(BWdfill,seD);
	BWfinal = imerode(BWfinal,seD);
	%figure, imshow(BWfinal), title('segmented image');

	%Ouline object
	BWoutline = bwperim(BWfinal);
	Segout(BWoutline) = 255;
	%figure, imshow(BWoutline), title('outlined original image');

	%Get boundary (biggest object)
	BWlist = bwboundaries(BWoutline,8, 'noholes');
    a = (cellfun(@length,BWlist));
    [~,i] = max(a(:));
    BWlist = BWlist{i,1};
    temp = BWlist(:,1);
    BWlist(:,1) = BWlist(:,2);%seems to have exchanged x and y
    BWlist(:,2) = temp*-1;
    