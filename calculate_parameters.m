function [matrix,AR,EL,Perimeter,Area,Circularity,Roundness]=calculate_parameters(image)
    [B,L] = bwboundaries(image,'noholes');
    stats = regionprops(L,'Area','BoundingBox','MajorAxisLength','MinorAxisLength','Circularity','Perimeter','Eccentricity','Orientation','Centroid');
     
    %initializing the vectors that will contain the parameters of each
    %structure
    Perimeter = zeros(1,length(B));
    Area = zeros(1,length(B));
    Circularity = zeros(1,length(B));
    Roundness = zeros(1,length(B));
    EL = zeros(1,length(B));
    AR = zeros(1,length(B));

    % loop over the boundaries
    for k = 1:length(B)
    
      % obtain (X,Y) boundary coordinates corresponding to label 'k'
      %boundary = B{k};
    
      % compute a simple estimate of the object's perimeter
          
      Perimeter(k) =  stats(k).Perimeter; %delta_sq = diff(boundary).^2; sum(sqrt(sum(delta_sq,2)));
      
      % obtain the area calculation corresponding to label 'k'
      Area(k) = stats(k).Area;
      
      % compute the Circularity metric
      Circularity(k) = stats(k).Circularity; %4*pi*Area(k)/Perimeter(k)^2;  

      % compute the Roundness metric
      Roundness(k) = Perimeter(k)/(sqrt(4*pi*Area(k)));
      
      % compute the EL metric
      a(k) = stats(k).MajorAxisLength;
      b(k) = stats(k).MinorAxisLength;
      EL(k) = log2(a(k)/b(k));

      % compute the AR metric
      AR(k) = a(k)/b(k);
    end
    
    matrix = [Perimeter;Area;Roundness;EL;AR];
end