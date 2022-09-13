classdef DDMOP6 < PROBLEM
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

% The datasets are the minutely prices of EUR/GBP taken from MT4
% No.   Assets Minutes
% 1       10     100
% 2       20     100
% 3       50     200
% 4      100     200
% 5      100     500

    properties(Access = private)
        aPF;    % Approximated PF for dataNo=1
        Yield;
        Risk;
    end
    methods
        function Setting(obj)
            dataNo = obj.ParameterSet(1);
            str = {'Data1','Data2','Data3','Data4','Data5'};
            CallStack = dbstack('-completenames');
            load(fullfile(fileparts(CallStack(1).file),'DDMOP6.mat'),'Dataset');
            Data  = Dataset.(str{dataNo});
            obj.Yield = log(Data(:,2:end)) - log(Data(:,1:end-1));
            obj.Risk  = cov(obj.Yield');
            
            obj.D = size(obj.Yield,1);
            if isempty(obj.M); obj.M = 3; end
            obj.D = size(obj.Yield,1);
            obj.M = 2;
            obj.lower = zeros(1,obj.D) - 1;
            obj.upper = zeros(1,obj.D) + 1;
            obj.encoding = 'real';
            load(fullfile(fileparts(CallStack(1).file),'DDMOP6_PF.mat'),'PF');
            obj.aPF = PF;
        end
		
		function PopObj = CalObj(obj,PopDec)
            input = PopDec;
            M = obj.M;
            PopDec = input./repmat(max(sum(abs(input),2),1),1,size(input,2));
            PopObj = zeros(size(PopDec,1),2);
            for i = 1 : size(PopDec,1)
                % The first objective is the total risk
                PopObj(i,1) = PopDec(i,:)*obj.Risk*PopDec(i,:)';
                % The second objective is the negative value of the total
                % yield
                PopObj(i,2) = -sum(PopDec(i,:)*obj.Yield);
            end
        end
        function R = GetOptimum(obj,~)
            R = obj.aPF;
        end
    end
end