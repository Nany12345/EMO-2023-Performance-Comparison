function calHV_Real(pro,alg,objNum,popSize,runNum,testInd,isHigh)
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
    for proInd = 1:length(pro)
        proName = func2str(pro{1,proInd});
        M = objNum(proInd);
        N = popSize(proInd);
        r = (1+1/getH(M,N))*ones(1,M);
        fileName = sprintf('./Data/Ref-HV/M%d_%s.mat',M,proName);
        refData = load(fileName).data;
        fmax = max(refData);
        fmin = min(refData);
        for algInd = 1:length(alg)
            algName = func2str(alg{1,algInd});
            folder = fullfile('Data','HV');
            [~,~]  = mkdir(folder);
            fileName   = fullfile(folder,sprintf('M%d_%s_%s.mat',M,algName,proName));
            HV = -1*zeros(runNum,testInd);
            for runInd = 1:runNum
                fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                if isfile(fileName)
                    try
                        data = load(fileName).POP;
                        popObjs = data;
                        % remove all zeros point
                        solNum = zeros(1,testInd);
                        for i = 1:testInd
                            d = sum(popObjs(:,:,i),2);
                            d(d==0) = [];
                            solNum(1,i) = length(d);
                        end
                        % normalization
                        for setInd = 1:testInd
                            popObjs(:,:,setInd) = (popObjs(:,:,setInd)-fmin)./(fmax-fmin);
                            HV(runInd,setInd) = stk_dominatedhv(popObjs(1:solNum(1,setInd),:,setInd),r); 
                        end
                    catch
                        fprintf(2,'error: %s_%s_M%d_%d\n',algName,proName,M,runInd)
                    end
                end
            end
            fileName   = fullfile(folder,sprintf('M%d_%s_%s',M,algName,proName));
            save(fileName,'HV');
        end
        fprintf('%s_M%d\n',proName,M);
    end
end