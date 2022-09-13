classdef RWMOP34 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>

%------------------------------- Reference --------------------------------
% Abhishek Kumar, Guohua Wu, Mostafa Ali, Qizhang Luo, Rammohan Mallipeddi,
% Ponnuthurai Suganthan, and Swagatam Das, A Benchmark-Suite of Real-World 
% Constrained Multi-Objective Optimization Problems and some Baseline Resu-
% -lts, submitted to Swarm and Evolutionary Computation, 2020.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    methods
        %% Initialization
        function Setting(obj)
            par = Cal_par(34);
            obj.M = par.fn+1;
            obj.D = par.n;
            obj.lower    = par.xmin;
            obj.upper    = par.xmax;
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            M = obj.M;
            [PopObj,~,~] = CEC2021_func(X,34); 
            [~,g,h] = CEC2021_func(X,34);
            PopCon = [g,abs(h)-1e-4];  
            PopCon = max(PopCon,0);
            PopObj(:,M) = sum(PopCon,2);        
        end
        %% Sample reference points on Pareto front
        function P = GetOptimum(obj,N)
            P = load('RefPoints/nadir_34.txt');
        end
    end
end