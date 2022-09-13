function generateRef_Real(pro,alg,objNum,popSize,runNum,testInd,isHigh)
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
        M = objNum(proInd);
        N = popSize(proInd);
        r = (1+1/getH(M,N))*ones(1,M);
        proName = func2str(pro{1,proInd});
        data = [];
        for algInd = 1:length(alg)
            algName = func2str(alg{1,algInd});
            dataAlg = [];
            for runInd = 1:runNum
                fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                if isfile(fileName)
                    try
                        dataInstance = load(fileName).POP;
                        popObjs = dataInstance(:,:,testInd);
                        % remove all zeros point
                        d = sum(popObjs,2);
                        d(d==0) = [];
                        solNum = length(d);
                        dataAlg = [dataAlg;popObjs(1:solNum,:)];
                    catch
                        fprintf(2,'error: %s_%s_M%d_%d\n',algName,proName,M,runInd)
                    end
                end
            end
            [FrontNo,~] = NDSort(dataAlg,1);
            dataAlg = dataAlg(FrontNo==1,:);
            data = [data;dataAlg];
        end
        folder = fullfile('Data','Ref-HV');
        [~,~]  = mkdir(folder);
        fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
        fprintf('%s\n',fileName);
        [FrontNo,~] = NDSort(data,1);
        data = data(FrontNo==1,:);
        save(fileName,'data');
    end
end