function runAlgReal(pro,alg,objNum,popSize,runNum,genNum,isHigh)
    if isHigh
        highInd = find(objNum>5);
        objNum = objNum(highInd);
        popSize = popSize(highInd);
        pro = pro(highInd);
    else
        lowInd = find(objNum<=5);
        objNum = objNum(lowInd);
        popSize = popSize(lowInd);
        pro = pro(lowInd);
    end
    caseNum = runNum*length(pro)*length(alg);
    parfor caseInd = 1:caseNum
        algInd = floor((caseInd-1)/(runNum*length(pro)))+1;
        proInd = mod(floor((caseInd-1)/runNum),length(pro))+1;
        N = popSize(proInd);
        M = objNum(proInd);
        algName = alg{algInd};
        proName = pro{proInd};
        runInd = mod(caseInd-1,runNum)+1;
        fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',func2str(algName),func2str(algName),func2str(proName),M,runInd);
        try
            platemo('algorithm',algName,'problem',proName,'N',N,...
                'maxFE',genNum*N,'save',1,'run',runInd);
            fprintf('%s_%s_%d\n',func2str(algName),func2str(proName),runInd);
        catch
            fprintf('error: %s\n',fileName);
        end
    end
end