function [sol, Loads, maxLoad, linkEnergy] = greedyRandomizedStrategy(nNodes, Links, T, sP, nSP, L)
    nFlows = size(T, 1);
    % random order of flows 
    randFlows = randperm(nFlows);
    sol = zeros(1, nFlows);

    % iterate through each flow
    for flow = randFlows
        path_index = 1;
        best_Loads = inf;
        best_energy = inf;

        % test every path "possible" in a certain load
        for path = 1 : nSP(flow)
            % try the path for that flow
            sol(flow) = path;
            % calculate loads
            [Loads, linkEnergy] = calculateLinkLoadEnergy(nNodes, Links, T, sP, sol, L, 50);
            
            % check if the current link energy is better then best link
            % energy
            if linkEnergy < best_energy
                % change index of path and load
                path_index = path;
                best_Loads = Loads;
                best_energy = linkEnergy;
            end
        end

        sol(flow) = path_index;
    end
    Loads = best_Loads;
    linkEnergy = best_energy;
    
    if Loads == inf
        maxLoad = Inf;
    else
        maxLoad = max(max(Loads(:, 3:4)));
    end
end
