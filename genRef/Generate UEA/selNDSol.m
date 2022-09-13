function NDSol = selNDSol(sol1,sol2)
    NDSol = sol1;
    [p1,M] = size(sol1);
    for solInd = 1:size(sol2,1)
        curSol = sol2(solInd,:);
        diff = curSol-NDSol(1:p1,:);
        % remove dominated solutions in part1
        dominatedByCur = find(sum(diff<=0,2)==M); % solutions in the first part dominated by curSol
        numOfDominated = size(dominatedByCur,1);
        p1 = p1-numOfDominated;
        NDSol(dominatedByCur,:) = [];
        % judge whether this solution is dominated or not
        if numOfDominated>0 % this solution is not dominated
            NDSol = [NDSol;curSol];
        elseif sum(sum(diff>=0,2)==M)==0 % this solution is not dominated
            NDSol = [NDSol;curSol];
        end
    end
end