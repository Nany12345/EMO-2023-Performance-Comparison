clc; clear;
alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','DEAGNG','RVEA','PREA','SparseEA','R2HCAEMOA'};
alg1 = [alg,'SMSEMOA1'];
alg2 = [alg,'HypE3'];
pro = {@RE21,@RE22,@RE23,@RE24,@RE25, ...
    @RE31,@RE32,@RE33,@RE34,@RE35,@RE36,@RE37, ...
    @RE41,@RE42,@RE61,@RE91};
popSize = [100*ones(1,5),91*ones(1,7),120*ones(1,2),112,174];
objNum = [2*ones(1,5),3*ones(1,7),4*ones(1,2),6,9];

runNum = 21;
obj = [3,5,8];
genNum = 500;

for proInd = 1:length(pro)
    proName = func2str(pro{1,proInd});
    M = objNum(proInd);
    N = popSize(proInd);
    r = (1+1/getH(M,N))*ones(1,M);
    if M>5
        alg = alg2;
    else
        alg = alg1;
    end
    fileName = sprintf('./Data/Ref/M%d_%s.mat',M,proName);
    refData = load(fileName).data;
    fmax = max(refData);
    fmin = min(refData);
    for algInd = 1:length(alg)
        algName = alg{1,algInd};
        folder = fullfile('Data','HV4');
        [~,~]  = mkdir(folder);
        fileName   = fullfile(folder,sprintf('M%d_%s_%s.mat',M,algName,proName));
%         if ~isfile(fileName)
            HV = -1*zeros(runNum,3);
            parfor runInd = 1:runNum
                if strcmp(algName,'SMSEMOA1') || strcmp(algName,'HypE3')
                    fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',[algName,'_500'],algName,proName,M,runInd);
                else
                    fileName = sprintf('./Data/%s/%s_%s_M%d_%d.mat',algName,algName,proName,M,runInd);
                end
                if isfile(fileName)
                    try
                        data = load(fileName).POP;
                        popObjs = data(:,:,[5,6,8]);
                        % remove all zeros point
                        solNum = zeros(1,3);
                        for i = 1:3
                            d = sum(popObjs(:,:,i),2);
                            d(d==0) = [];
                            solNum(1,i) = length(d);
                        end
                        % normalization
                        for setInd = 1:3
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
%         end
    end
    fprintf('%s_M%d\n',proName,M);
end