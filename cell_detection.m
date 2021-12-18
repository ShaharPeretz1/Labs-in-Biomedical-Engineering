function [im] = cell_detection(im,flag)
    %% gray-scale:
    I = rgb2gray(im);

%     figure()
%     imshow(I)
    %% binarize the image:
    im = imbinarize(I);

%     figure()
%     imshow(im)
    %% define edges and dialating them:
    [~,threshold] = edge(im,'sobel');
    fudgeFactor = 0.5;
    BWs = edge(im,'sobel',threshold * fudgeFactor);
    se90 = strel('line',3,90);
    se0 = strel('line',3,0);
    im = imdilate(BWs,[se90 se0]);
    se = strel('disk',5);
    im = imclose(im,se);

%     figure()
%     imshow(im)
    %% fill-in holes:
    im = imfill(double(im));
    
%     figure()
%     imshow(im)
    %% clean all structures with area under 4000 and above 100000 pixels width:
    LB = 4000;
    UB = 1000000;
    im = xor(bwareaopen(im,LB),  bwareaopen(im,UB));

%     figure()
%     imshow(im)
    %% clean borders:
    im = imclearborder(medfilt2(im));
    %% clean specific (floating) cells:
    if flag==1
        % after we found out were the floating cell was placed we extracted
        % the centers and radiuses of every spot we wanted to earase.
        centers = [1704.05782,1905.979032; 1312.967727,1054.575653;1254.987306,819.682519;1137.205652,405.243074];
        r = [228;190;245;108];
    
        for i=1:length(r)
            [xgrid, ygrid] = meshgrid(1:size(im,2), 1:size(im,1));
            mask = ((xgrid-centers(i,1)).^2 + (ygrid-centers(i,2)).^2) <= r(i).^2;
            im(mask)=0;
        end
    end

%     figure()
%     imshow(im)
    %% labelling:
    B = labeloverlay(I,im);

%     figure()
%     imshow(B)
    %% outline the structures on the gray picture:
    stats = regionprops('table',im,'BoundingBox','Area','MajorAxisLength','MinorAxisLength','SubarrayIdx','Centroid');

    BWoutline = bwperim(im); 
    SegoutR = I;
    SegoutG = I;
    SegoutB = I;
    thickOutlines = imdilate(BWoutline, true(3));
    SegoutR(thickOutlines) = 255;
    SegoutG(thickOutlines) = 0;
    SegoutB(thickOutlines) = 0;
    SegoutRGB = cat(3, SegoutR, SegoutG, SegoutB);

    figure()
    imshow(SegoutRGB)
    hold on
    
    for i = 1:height(stats)
        rectangle('Position', stats.BoundingBox(i,:),'Curvature',1,'EdgeColor', 'b')
        text(stats.BoundingBox(i,1),stats.BoundingBox(i,2),num2str(i),'FontSize', 12)
        % those lines were used in order to find the place were the
        % floating cell was placed in every picture:
        %text1 = sprintf("[%f,%f]",stats.Centroid(i,1),stats.Centroid(i,2))
        %text(stats.Centroid(i,1),stats.Centroid(i,2),text1,'FontSize', 12)
        %text(stats.Centroid(i,1),stats.Centroid(i,2),num2str(stats.MajorAxisLength(i)),'FontSize', 12)
    end
end

