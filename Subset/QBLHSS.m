function [selDataSet,selInd] = QBLHSS(data,selNum,seed,threhold,ref)
    rng(seed);
    tic;
    interval = 10;
    sequence = 10;
    alpha = 50;
    alpha = min(alpha,size(data,1)-selNum);
    [N,M] = size(data);
    % initialization
    runTime = [];
    selDataSet = [];
    iteration = 0;
    selInd = zeros(1,selNum+1);
    selData = zeros(selNum+1,M);
    HVC = zeros(1,selNum+1);
    % get initial selected set and unselected set
    selInd(1:selNum) = randperm(N,selNum);
    selInd(1:selNum) = sort(selInd(1:selNum));
    selData(1:selNum,:) = data(selInd(1:selNum),:);
    restInd = 1:N;
    restInd(selInd(1:selNum)) = [];
    affected = zeros(2,selNum);
    oldRemovedSol = zeros(1,M);
    changeRate = [];
    while true
        selDataSet(:,:,iteration+1) = selData(1:selNum,:);
        if iteration==0
            runTime(1,iteration+1) = toc;
            tic;
            initialHV = stk_dominatedhv(selDataSet(:,:,1),ref);
        else
            runTime(1,iteration+1) = runTime(1,iteration)+toc;
            tic;
        end
        if mod(iteration,interval)==0 && iteration~=0
            HVInitial = stk_dominatedhv(selDataSet(:,:,iteration-interval+1),ref); 
            HVCurrent = stk_dominatedhv(selDataSet(:,:,iteration+1),ref);
            changeRate(1,iteration/interval) = HVCurrent-HVInitial;
            if iteration/interval>sequence
                count = 0;
                for i = 1:sequence
                    if changeRate(1,iteration/interval-i+1)<=threhold*initialHV
                        count = count+1;
                    end
                end
                if count==sequence
                    break;
                end
            end
        end
        indSelSet = randperm(N-selNum,alpha);
        solIndSet = restInd(indSelSet);
        HVCSel = CalHVCSel(selData(1:selNum,:),data(solIndSet,:),ref);
        [~,maxInd] = max(HVCSel);
        indSel = indSelSet(maxInd);
        solInd = solIndSet(maxInd);
        newSol = data(solInd,:);
        selInd(1,selNum+1) = solInd;
        selData(selNum+1,:) = newSol;
        if iteration==0
            HVC = calHVC(selData,ref);
        else
            affected(2,:) = detect(selData,selNum+1);
            HVC = updateHVC(selData(1:selNum,:),ref,HVC,affected,oldRemovedSol,newSol);
        end
        [~,minInd] = min(HVC);
        oldRemovedSol = selData(minInd,:);
        affected(1,:) = detect(selData,minInd);
        if minInd<selNum+1 % this iterationis useful
            restInd(indSel) = selInd(minInd);
            selData(minInd:selNum,:) = selData(minInd+1:selNum+1,:);
            selInd(minInd:selNum) = selInd(minInd+1:selNum+1);
            HVC(minInd:selNum) = HVC(minInd+1:selNum+1);
        end
        iteration = iteration+1;
    end
    selInd = selInd(1:end-1);
end

function HVC = calHVC(data,ref)
    [N,~] = size(data);
    HVC = zeros(1,N);
    for i=1:N
        dataT = data;
        s = dataT(i,:);
        dataT(i,:) = [];
        dataPro = max(s,dataT);        
        HVC(1,i) = prod(ref-s)-stk_dominatedhv(dataPro,ref); 
    end
end

function HVC = updateHVC(selData,ref,oldHVC,affected,removedSol,addedSol)
    [N,~] = size(selData);
    HVC = zeros(1,N+1);
    for solInd = 1:N
        if affected(1,solInd)==1 && affected(2,solInd)==0 % only affected by removal
            s = selData(solInd,:);
            dataT = selData;
            dataT(solInd,:) = [];
            dataTPro = max(dataT,s);
            removedPro = max(removedSol,s);
            dataTPro2 = max(dataTPro,removedPro);
            HVCDiff = prod(ref-removedPro)-stk_dominatedhv(dataTPro2,ref);
            HVC(1,solInd) = oldHVC(1,solInd)+HVCDiff;
        elseif affected(1,solInd)==0 && affected(2,solInd)==1 % only affected by addition
            s = selData(solInd,:);
            dataT = selData;
            dataT(solInd,:) = [];
            dataTPro = max(dataT,s);
            addedPro = max(addedSol,s);
            dataTPro2 = max(dataTPro,addedPro);
            HVCDiff = prod(ref-addedPro)-stk_dominatedhv(dataTPro2,ref);
            HVC(1,solInd) = oldHVC(1,solInd)-HVCDiff;
        elseif affected(1,solInd)==1 && affected(2,solInd)==1 % affected by both removal and addition
            s = selData(solInd,:);
            dataT = selData;
            dataT(solInd,:) = [];
            dataTPro = max([dataT;addedSol],s);
            HVC(1,solInd) = prod(ref-s)-stk_dominatedhv(dataTPro,ref); 
        else % not affected by either one
            HVC(1,solInd) = oldHVC(1,solInd);
        end
    end
    HVC(1,end) = prod(ref-addedSol)-stk_dominatedhv(max(selData,addedSol),ref); 
end
function affected = detect(data,index)
    s = data(index,:);
    data(index,:) = [];
    dataPro = max(data,s);
    affected = NDSort(dataPro,1)==1;
end
function HVC = CalHVCSel(data,dataSel,ref)
    N = size(dataSel,1);
    HVC = zeros(1,N);
    for i=1:N
        s = dataSel(i,:);
        dataPro = max(s,data);
        HVC(1,i) = prod(ref-s)-stk_dominatedhv(dataPro,ref); 
    end
end