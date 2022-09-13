classdef DDMOP7 < PROBLEM
% <problem> <DDMOP>
% <multi/many> <real> <large/none> <expensive/none>
% A repository of real-world datasets for data-driven evolutionary multiobjective optimization

%------------------------------- Reference --------------------------------
% He C, Tian Y, Wang H, et al. A repository of real-world datasets for 
% data-driven evolutionary multiobjective optimization[J]. 
% Complex & Intelligent Systems, 2019: 1-9.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% The datasets are taken from the UCI machine learning repository in
% http://archive.ics.uci.edu/ml/index.php
% No.   Name                              Samples Features Classes
% 1     Statlog_Australian                  690      14       2
% 2     Climate                             540      18       2
% 3     Statlog_German                     1000      24       2
% 4     Breast_cancer_Wisconsin_Diagnostic	569      30       2
% 5     Connectionist_bench_Sonar           208      60       2

    properties(Access = private)
        aPF;    % Approximated PF for dataNo=1
        nHidden = 1;
        TrainIn;
        TrainOut;
    end
    methods
        function Setting(obj)
            dataNo = obj.ParameterSet(1);
            str = {'Statlog_Australian','Climate','Statlog_German','Breast_cancer_Wisconsin_Diagnostic','Connectionist_bench_Sonar'};
            CallStack = dbstack('-completenames');
            load(fullfile(fileparts(CallStack(1).file),'DDMOP7.mat'),'Dataset');
            Data = Dataset.(str{dataNo});
            Mean = mean(Data(:,1:end-1),1);
            Std  = std(Data(:,1:end-1),[],1);
            Data(:,1:end-1) = (Data(:,1:end-1)-repmat(Mean,size(Data,1),1))./repmat(Std,size(Data,1),1);
            Data(:,end)     = Data(:,end) == Data(1,end);
            obj.TrainIn     = Data(:,1:end-1);
            obj.TrainOut    = Data(:,end);
       
            obj.D = (size(obj.TrainIn,2)+1)*obj.nHidden + (obj.nHidden+1)*size(obj.TrainOut,2);
            obj.M = 2;
            obj.lower = zeros(1,obj.D) - 1;
            obj.upper = zeros(1,obj.D) + 1;
            obj.encoding = 'real';
            load(fullfile(fileparts(CallStack(1).file),'DDMOP7_PF.mat'),'PF');
            obj.aPF = PF;
        end
		
		function PopObj = CalObj(obj,PopDec)
            PopObj = zeros(size(PopDec,1),2);
            for i = 1 : size(PopDec,1)
                W1      = reshape(PopDec(i,1:(size(obj.TrainIn,2)+1)*obj.nHidden),size(obj.TrainIn,2)+1,obj.nHidden);
                W2      = reshape(PopDec(i,(size(obj.TrainIn,2)+1)*obj.nHidden+1:end),obj.nHidden+1,size(obj.TrainOut,2));
                % Fine-tune each offspring by gradient descent
                % This line can be removed to increase the difficulty
                [W1,W2] = Train(obj.TrainIn,obj.TrainOut,W1,W2,1);
                % --------------------------------------------
                Z       = Predict(obj.TrainIn,W1,W2);
                PopDec(i,:) = [W1(:)',W2(:)'];
                % The first objective is the complexity of the network,
                % i.e., the ratio of nonzero weights
                PopObj(i,1) = mean(PopDec(i,:)~=0);
                % The second objective is the error rate of the network on
                % training set
                PopObj(i,2) = mean(round(Z)~=obj.TrainOut);
            end
        end
        function R = GetOptimum(obj,~)
            R = obj.aPF;
        end
    end
end


function [W1,W2] = Train(X,T,W1,W2,nEpoch)
    for epoch = 1 : nEpoch
        [Z,Y] = Predict(X,W1,W2);
        P     = (Z-T).*Z.*(1-Z);
        Q     = P*W2(2:end,:)'.*(1-Y.^2);
        D1    = 0;
        D2    = 0;
        for i = 1 : size(X,1)
            D2 = D2 + [1,Y(i,:)]'*P(i,:);
            D1 = D1 + [1,X(i,:)]'*Q(i,:);
        end
        W1 = W1 - D1/size(X,1);
        W2 = W2 - D2/size(X,1);
    end
end

function [Z,Y] = Predict(X,W1,W2)
    Y = 1 - 2./(1+exp(2*[ones(size(X,1),1),X]*W1));
    Z = 1./(1+exp(-[ones(size(Y,1),1),Y]*W2));
end