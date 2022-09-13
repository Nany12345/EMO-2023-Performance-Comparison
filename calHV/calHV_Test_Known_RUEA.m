function calHV_Test_Known_RUEA(pro,alg,obj,selNum,runNum,objIndList)
    for objInd = objIndList
        M = obj(objInd);
        N = selNum;
        r = (1+1/getH(M,N))*ones(1,M);
        for proInd = 1:length(pro)
            Pro = pro{proInd};
            Problem = Pro('M',M);
            fmax = max(Problem.optimum);
            fmin = min(Problem.optimum);
            proName = func2str(pro{1,proInd});
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
end