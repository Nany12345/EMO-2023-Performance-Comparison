function Subset_Real_LGI(pro,alg,objNum,selNum,runNum,isHigh)
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
        for algInd = 1:length(alg)
            algName = func2str(alg{1,algInd});
            folder = fullfile('Data/Ref-Sel-LGI',algName);
            [~,~]  = mkdir(folder);
            RUEA = zeros(N,M,runNum);
            parfor runInd = 1:runNum
                fileName = sprintf('./Data/ref/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                if isfile(fileName)
                    try
                        data = load(fileName).UEA;
                        solNum = size(data,1);
                        if solNum>N
                            fmin = min(data); fmax = max(data);
                            dataNormal = (data-fmin)./(fmax-fmin);
                            [~,selInd] = LGIHSS(dataNormal,N,r);
                            RUEA(:,:,runInd) = data(selInd,:);
                        else
                            data(solNum+1:N,:) = zeros(N-solNum,M);
                            RUEA(:,:,runInd) = data;
                        end
                    catch
                        fprintf(2,'error: %s_%s_M%d_%d\n',algName,proName,M,runInd)
                    end
                end
            end
            fileName   = fullfile(folder,sprintf('M%d_%s_%s',M,algName,proName));
            save(fileName,'RUEA');
        end
        fprintf('%s_M%d\n',proName,M);
    end
end