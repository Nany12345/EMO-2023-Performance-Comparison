clc;clear;
% pro = {@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7};
pro = {@MinusDTLZ5,@MinusDTLZ6,@MinusDTLZ7,@MinusWFG1,@MinusWFG2,@MinusWFG3};
alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','DEAGNG','RVEA','PREA','SparseEA','R2HCAEMOA'};
alg1 = [alg,'SMSEMOA1'];
alg2 = [alg,'HypE3'];
runNum = 21;
obj = [3,5,8];
genNum = 500;
popSize = [91,210,156];

for objInd = 1:3
    M = obj(objInd);
    N = popSize(objInd);
    r = (1+1/getH(M,N))*ones(1,M);
    if M==8
        alg = alg2;
    else
        alg = alg1;
    end
    for proInd = 1:length(pro)
        proName = func2str(pro{1,proInd});
        data = [];
        for algInd = 1:length(alg)
            algName = alg{1,algInd};
            dataAlg = [];
            for runInd = 1:runNum
                if strcmp(algName,'SMSEMOA1') || strcmp(algName,'HypE3')
                    fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',[algName,'_500'],algName,proName,M,runInd);
                else
                    fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                end

                if isfile(fileName)
                    try
                        dataInstance = load(fileName).POP;
                        popObjs = dataInstance(:,:,6);
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
        folder = fullfile('Data','Ref');
        [~,~]  = mkdir(folder);
        fileName   = fullfile(folder,sprintf('M%d_%s.mat',M,proName));
        fprintf('%s\n',fileName);
        [FrontNo,~] = NDSort(data,1);
        data = data(FrontNo==1,:);
        save(fileName,'data');
    end
end