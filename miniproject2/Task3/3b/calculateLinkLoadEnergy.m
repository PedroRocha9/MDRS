function [Loads, linkEnergy] = calculateLinkLoadEnergy(nNodes, Links, T, sP, Solution, L)
    nFlows= size(T,1);
    nLinks= size(Links,1);
    aux= zeros(nNodes);
    for i= 1:nFlows
        if Solution(i)>0
            path= sP{i}{Solution(i)};
            for j=2:length(path)
                aux(path(j-1),path(j))= aux(path(j-1),path(j)) + T(i,3); 
                aux(path(j),path(j-1))= aux(path(j),path(j-1)) + T(i,4);
            end
        end
    end
    Loads= [Links zeros(nLinks,2)];
    linkEnergy = 0;
    for i= 1:nLinks
        Loads(i,3)= aux(Loads(i,1),Loads(i,2));
        Loads(i,4)= aux(Loads(i,2),Loads(i,1));
        
        maxLoad = max(max(Loads(:, 3:4)));
        % If the worst link load is greater than max capacity , energy will be infinite    
        if maxLoad > 100
            linkEnergy = inf;
        else
            maxCurrentLoad = max(Loads(i, 3:4));
            % link in sleeping mode
            if maxCurrentLoad == 0
                linkEnergy = linkEnergy + 2;        % El = 2 whatever the link capacity
            else
                % len from nodeA to nodeB
                len = L(Loads(i, 1), Loads(i, 2));
                
                % energy calculation dependent of link capacity
                if maxCurrentLoad <= 50
                    linkEnergy = linkEnergy + 6 + 0.2 * len;
                elseif maxCurrentLoad > 50
                    linkEnergy = linkEnergy + 8 + 0.3 * len;
                else
                    fprintf('Error: Link capacity is %.2f\n', maxCurrentLoad);
                end
            end
        end
    end
end
