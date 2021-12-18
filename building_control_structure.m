function [structure] = building_control_structure(group)
    structure = struct();

    % mean:
    all_mean_AR = zeros(1,length(group));
    all_mean_EL = zeros(1,length(group));
    all_mean_Circularity = zeros(1,length(group));
    all_mean_Roundness = zeros(1,length(group));
    % std:
    all_std_AR = zeros(1,length(group));
    all_std_EL = zeros(1,length(group));
    all_std_Circularity = zeros(1,length(group));
    all_std_Roundness = zeros(1,length(group));
    
    
    for image_indx=1:length(group) 
        image_name = group{image_indx};
        im = imread(image_name);
        [image] = cell_detection(im,0);
        [matrix,AR,EL,Perimeter,Area,Circularity,Roundness] = calculate_parameters(image);
        [amount,AR,EL,Circularity,Roundness] = identify_cell_structure(AR,EL,Circularity,Roundness);
        % adding parameters to the structure
        structure.control.amount = amount;
        structure.control.AR = AR;
        structure.control.EL = EL;
        structure.control.Circularity = Circularity;
        structure.control.Roundness = Roundness;
        structure.control.Perimeter = Perimeter;
        structure.control.Area = Area;
        structure.control.amount = amount;
        structure.control.matrix = matrix;
        % add parameters to vectors to create a graph
        % mean:
        all_mean_AR(image_indx) =  structure.control.AR(1);
        all_mean_EL(image_indx) = structure.control.EL(1);
        all_mean_Circularity(image_indx) = structure.control.Circularity(1);
        all_mean_Roundness(image_indx) = structure.control.Roundness(1);
        % std:
        all_std_AR(image_indx) = structure.control.AR(2);
        all_std_EL(image_indx) = structure.control.EL(2);
        all_std_Circularity(image_indx) = structure.control.Circularity(2);
        all_std_Roundness(image_indx) = structure.control.Roundness(2);
    end
     structure.control.all_mean_AR = all_mean_AR/all_mean_AR(1);
     structure.control.all_mean_EL = all_mean_EL/all_mean_EL(1);
     structure.control.all_mean_Circularity = all_mean_Circularity/all_mean_Circularity(1);
     structure.control.all_mean_Roundness = all_mean_Roundness/all_mean_Roundness(1);

     structure.control.all_std_AR = all_std_AR;
     structure.control.all_std_EL = all_std_EL;
     structure.control.all_std_Circularity = all_std_Circularity;
     structure.control.all_std_Roundness = all_std_Roundness;
end

