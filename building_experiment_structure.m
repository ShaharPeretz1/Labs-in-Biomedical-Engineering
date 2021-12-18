function [structure] = building_experiment_structure(group)
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
        [image] = cell_detection(im,1);           
        [matrix,AR,EL,Perimeter,Area,Circularity,Roundness] = calculate_parameters(image);
        [amount,AR,EL,Circularity,Roundness] = identify_cell_structure(AR,EL,Circularity,Roundness);
        % adding parameters to the structure
        structure.experiment.amount = amount;
        structure.experiment.AR = AR;
        structure.experiment.EL = EL;
        structure.experiment.Circularity = Circularity;
        structure.experiment.Roundness = Roundness;
        structure.experiment.Perimeter = Perimeter;
        structure.experiment.Area = Area;
        structure.experiment.amount = amount;
        structure.experiment.matrix = matrix;
        % add parameters to vectors to create a graph
        % mean:
        all_mean_AR(image_indx) =  structure.experiment.AR(1);
        all_mean_EL(image_indx) = structure.experiment.EL(1);
        all_mean_Circularity(image_indx) = structure.experiment.Circularity(1);
        all_mean_Roundness(image_indx) = structure.experiment.Roundness(1);
        % std:
        all_std_AR(image_indx) = structure.experiment.AR(2);
        all_std_EL(image_indx) = structure.experiment.EL(2);
        all_std_Circularity(image_indx) = structure.experiment.Circularity(2);
        all_std_Roundness(image_indx) = structure.experiment.Roundness(2);
    end
     structure.experiment.all_mean_AR = all_mean_AR/all_mean_AR(1);
     structure.experiment.all_mean_EL = all_mean_EL/all_mean_EL(1);
     structure.experiment.all_mean_Circularity = all_mean_Circularity/all_mean_Circularity(1);
     structure.experiment.all_mean_Roundness = all_mean_Roundness/all_mean_Roundness(1);

     structure.experiment.all_std_AR = all_std_AR;
     structure.experiment.all_std_EL = all_std_EL;
     structure.experiment.all_std_Circularity = all_std_Circularity;
     structure.experiment.all_std_Roundness = all_std_Roundness;
end
