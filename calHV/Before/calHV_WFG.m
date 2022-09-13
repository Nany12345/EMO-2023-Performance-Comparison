clc; clear;
alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','DEAGNG','RVEA','PREA','SparseEA','R2HCAEMOA'};
alg1 = [alg,'SMSEMOA1'];
alg2 = [alg,'HypE3'];
alg = {'SMSEMOA'};
pro = {'WFG1','WFG2','WFG3','WFG4','WFG5','WFG6','WFG7','WFG8','WFG9'};

runNum = 21;
obj = [3,5,8];
genNum = 5000;
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
        if proInd==3
            if M==3
                fmax = [1,2,6];
            elseif M==5
                fmax = [0.25,0.5,1.5,4,10];
            elseif M==8
                fmax = [0.03125,0.0625,0.1875,0.5,1.25,3,7,16];
            end
        else
            fmax = 2:2:2*M;
        end
        fmin = zeros(1,M);
        proName = pro{1,proInd};
        for algInd = 1:length(alg)
            algName = alg{1,algInd};
            folder = fullfile('Data','HV4');
            [~,~]  = mkdir(folder);
            fileName   = fullfile(folder,sprintf('M%d_%s_%s.mat',M,algName,proName));
%             if ~isfile(fileName)
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
%             end
        end
        fprintf('%s_M%d\n',proName,M);
    end
end