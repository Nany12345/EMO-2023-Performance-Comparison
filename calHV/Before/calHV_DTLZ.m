clc; clear;
alg = {'NSGAII','MOEAD','NSGAIII','MOEADD','DEAGNG','RVEA','PREA','SparseEA','R2HCAEMOA'};
alg1 = [alg,'SMSEMOA1'];
alg2 = [alg,'HypE3'];
pro = {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','DTLZ5','DTLZ6','DTLZ7'};

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
        if proInd==1
            fmax = 0.5*ones(1,M);
        elseif proInd<5
            fmax = ones(1,M); 
        elseif proInd==5 || proInd==6
            if M==3
                fmax = [0.7071,0.7071,1];
            elseif M==5
                fmax = [0.3536,0.3536,0.5,0.7071,1];
            elseif M==8
                fmax = [0.1250,0.1250,0.1768,0.25,0.3536,0.5,0.7071,1];
            end
        elseif proInd==7
            if M==3
                fmax = [0.8594,0.8594,6];
            elseif M==5
                fmax = [0.8594,0.8594,0.8594,0.8594,10.0000];
            elseif M==8
                fmax = [0.8594*ones(1,7),16];
            end
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