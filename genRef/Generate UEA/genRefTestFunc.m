function genRefTestFunc(pro,alg,obj,runNum,objIndList)
    for objInd = objIndList
        M = obj(objInd);
        for proInd = 1:length(pro)
            tic
            proName = func2str(pro{1,proInd});
            folder = fullfile('Data','UEA');
            fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
            if ~isfile(fileName)
                data = cell(1,length(alg));
                count = zeros(1,length(alg));
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
                    sizeOfAlgUEA = size(dataAlg,1);
                    count(algInd) = sizeOfAlgUEA;
                    data{1,algInd} = dataAlg;
                    folder = fullfile('Data/UEA',algName);
                    [~,~]  = mkdir(folder);
                    fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
                    parsave(dataAlg,fileName);
                end
                Ref = [];
                for algInd = 1:length(alg)
                    Ref = [Ref;data{1,algInd}];
                end
                folder = fullfile('Data','UEA');
                [~,~]  = mkdir(folder);
                fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
                [FrontNo,~] = NDSort(Ref,1);
                Ref = Ref(FrontNo==1,:);
                save(fileName,'Ref');
                fprintf('%s_Runtime=%f\n',fileName,toc);
            else
                fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
                fprintf('%s\n',fileName);
            end
        end
    end
end

function parsave(Ref,fileName)
    save(fileName,'Ref');
end