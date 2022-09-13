function genRefRealFunc(pro,alg,objNum,runNum,isHigh)
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
        M = objNum(proInd);
        proName = func2str(pro{1,proInd});
        folder = fullfile('Data','UEA');
        fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
        if ~isfile(fileName)
            data = cell(1,length(alg));
            parfor algInd = 1:length(alg)
                algName = func2str(alg{1,algInd});
                dataAlg = [];
                for runInd = 1:runNum
                    fileName = sprintf('./Data/ref/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                    if isfile(fileName)
                        try
                            popObjs = load(fileName).UEA;
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
                data{1,algInd} = dataAlg;
            end
            Ref = [];
            for algInd = 1:length(alg)
                Ref = [Ref;data{1,algInd}];
            end
            folder = fullfile('Data','UEA');
            [~,~]  = mkdir(folder);
            fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
            fprintf('%s\n',fileName);
            [FrontNo,~] = NDSort(Ref,1);
            Ref = Ref(FrontNo==1,:);
            save(fileName,'Ref');
        end
    end
end