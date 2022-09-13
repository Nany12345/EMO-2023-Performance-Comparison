function runAlgNormal(pro,alg,obj,popSize,runNum,objIndList,genNum)
    for objInd = objIndList
        M = obj(objInd);
        N = popSize(objInd);
        caseNum = runNum*length(pro)*length(alg);
        parfor caseInd = 1:caseNum
            algInd = floor((caseInd-1)/(runNum*length(pro)))+1;
            proInd = mod(floor((caseInd-1)/runNum),length(pro))+1;
            runInd = mod(caseInd-1,runNum)+1;
            algName = alg{algInd};
            proName = pro{proInd};
            fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',func2str(algName),func2str(algName),func2str(proName),M,runInd);
            try
                platemo('algorithm',algName,'problem',proName,'M',M,'N',N,...
                    'maxFE',genNum*N,'save',1,'run',runInd);
                fprintf('M%d_%s_%s_%d\n',M,func2str(algName),func2str(proName),runInd);
            catch
                fprintf(2,'error: %s\n',fileName);
            end
        end
    end
end