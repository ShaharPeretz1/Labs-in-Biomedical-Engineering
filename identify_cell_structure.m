function [amount,AR,EL,Circularity,Roundness] = identify_cell_structure(AR,EL,Circularity,Roundness)
    % this function should predict the structure of the cells. So we would
    % like to find which parameters increased and which decreased in the
    % passing time.
    amount = length(Roundness);
    AR = [mean(AR),std(AR)];
    EL = [mean(EL),std(EL)];
    Circularity = [mean(Circularity),std(Circularity)];
    Roundness = [mean(Roundness),std(Roundness)];
    
end





    