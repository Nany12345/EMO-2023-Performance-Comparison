function calHV_Real_RUEA(pro,alg,objNum,selNum,runNum,isHigh)
    if isHigh
        highInd = find(objNum>5);
        objNum = objNum(highInd);
        pro = pro(highInd);
    else
        lowInd = find(objNum<=5);
        objNum = objNum(lowInd);
        pro = pro(lowInd);
    end
    for proInd = 1:length(pro)
        proName = func2str(pro{1,proInd});
        M = objNum(proInd);
        N = selNum;
        r = (1+1/getH(M,N))*ones(1,M);
        fileName = sprintf('./Data/Ref-HV/M%d_%s.mat',M,proName);
        refData = load(fileName).data;
        fmax = max(refData);
        fmin = min(refData);
        for algInd = 1:length(alg)
            algName = func2str(alg{1,algInd});
            folder = fullfile('Data','HV-Sel-LGI');
            [~,~]  = mkdir(folder);
            HV = -1*zeros(1,runNum);
            fileName = sprintf('./Data/Ref-Sel-LGI/%s/M%d_%s_%s.mat',algName,M,algName,proName);
            if isfile(fileName)
                try
                    data = load(fileName).RUEA;
                    parfor runInd = 1:runNum
                        popObjs = data(:,:,runInd);
                        % remove all zeros point
                        d = sum(popObjs,2);
                        d(d==0) = [];
                        solNum = length(d);
                        % normalization
                        popObjs = (popObjs-fmin)./(fmax-fmin);
                        HV(1,runInd) = stk_dominatedhv(popObjs(1:solNum,:),r); 
                    end
                catch
                    fprintf(2,'error: %s_%s_M%d\n',algName,proName,M)
                end
            end
            fileName = fullfile(folder,sprintf('M%d_%s_%s',M,algName,proName));
            save(fileName,'HV');
        end
        fprintf('%s_M%d\n',proName,M);
    end
end