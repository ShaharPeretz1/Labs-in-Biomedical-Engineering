clc; clear all; close all;
control = {};
experiment = {};
for i = 1:10
    c = sprintf("control%d.tif",i);
    control{i} = c;
    e = sprintf("ex%d.tif",i);
    experiment{i} = e;
end

% building a structure with the parameters for every picture
[structure_control] = building_control_structure(control);
[structure_exp] = building_experiment_structure(experiment);


%% plots:
time = [0:length(structure_control.control.all_std_AR)-1]*0.5;

figure()
%AR
hold on
err = structure_control.control.all_std_AR;
errorbar(time,structure_control.control.all_mean_AR,err)
err = structure_exp.experiment.all_std_AR;
errorbar(time,structure_exp.experiment.all_mean_AR,err)
title("Normalized mean of AR with std bars")
xlabel("time [minute]")
ylabel("Normalized mean of AR")
legend("control group","experiment group")
hold off

figure()
%EL
hold on
err = structure_control.control.all_std_EL;
errorbar(time,structure_control.control.all_mean_EL,err)
err = structure_exp.experiment.all_std_EL;
errorbar(time,structure_exp.experiment.all_mean_EL,err)
title("Normalized mean of EL with std bars")
xlabel("time [minute]")
ylabel("Normalized mean of EL")
legend("control group","experiment group")
hold off

figure()
%Circularity
hold on
err = structure_control.control.all_std_Circularity;
errorbar(time,structure_control.control.all_mean_Circularity,err)
err = structure_exp.experiment.all_std_Circularity;
errorbar(time,structure_exp.experiment.all_mean_Circularity,err)
title("Normalized mean of Circularity with std bars for experiment group")
xlabel("time [minute]")
ylabel("Normalized mean of Circularity")
legend("control group","experiment group")
hold off

figure()
%Roundness
hold on
err = structure_control.control.all_std_Roundness;
errorbar(time,structure_control.control.all_mean_Roundness,err)
err = structure_exp.experiment.all_std_Roundness;
errorbar(time,structure_exp.experiment.all_mean_Roundness,err)
title("Normalized mean of Roundness with std bars for control group")
xlabel("time [minute]")
ylabel("Normalized mean of Roundness")
legend("control group","experiment group")
hold off
