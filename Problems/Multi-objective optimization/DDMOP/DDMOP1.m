classdef DDMOP1 < PROBLEM
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

    properties(Access = private)
        aPF;    % Approximated PF
    end
    methods
        %% Default settings of the problem
        function Setting(obj)
            if isempty(obj.M); obj.M = 9; end
            if isempty(obj.D); obj.D = 11; end
            obj.lower    = [0.5 0.45 0.5 0.5 0.875 0.4 0.4 -1.655 -1.808 -2 -2];
            obj.upper    = [1.5 1.35 1.5 1.5 2.625 1.2 1.2 2.345 2.192 2 2];
            obj.encoding = 'real';
            CallStack = dbstack('-completenames');
            load(fullfile(fileparts(CallStack(1).file),'DDMOP1_PF.mat'),'PF');
            obj.aPF = PF;
        end
        function PopObj = CalObj(obj,PopDec)
            [N,~]   = size(PopDec);
            M       = obj.M;
            PopObj  = zeros(N,M);
            PopObj(:,1) = 1.98 + 4.9.*PopDec(:,1) + 6.67.*PopDec(:,2) + 6.98.*PopDec(:,3) ...
            + 4.01.*PopDec(:,4) + 1.78.*PopDec(:,5) + 0.00001.*PopDec(:,5) + 2.73.*PopDec(:,2);

            PopObj(:,2) = 1.16 - 0.3717.*PopDec(:,2).*PopDec(:,4) - 0.00931.*PopDec(:,2).*PopDec(:,10) ...
                - 0.484.*PopDec(:,3).*PopDec(:,9) + 0.01343.*PopDec(:,6).*PopDec(:,10);

            PopObj(:,3) = 0.261 - 0.0159.*PopDec(:,1).*PopDec(:,2) - 0.188.*PopDec(:,1).*PopDec(:,8) ...
                - 0.019.*PopDec(:,2).*PopDec(:,7) + 0.0144.*PopDec(:,3).*PopDec(:,5) + 0.87570.*PopDec(:,5).*PopDec(:,10) ...
                + 0.08045.*PopDec(:,6).*PopDec(:,9) + 0.00139.*PopDec(:,8).*PopDec(:,11) + 0.00001575.*PopDec(:,10).*PopDec(:,11);

            PopObj(:,4) = 0.214 + 0.00817.*PopDec(:,5) - 0.131.*PopDec(:,1).*PopDec(:,8) - 0.0704.*PopDec(:,1).*PopDec(:,9) ...
                + 0.03099.*PopDec(:,2).*PopDec(:,6) -0.018.*PopDec(:,2).*PopDec(:,7) +0.0208.*PopDec(:,3).*PopDec(:,8) ...
                + 0.121.*PopDec(:,3).*PopDec(:,9) - 0.00364.*PopDec(:,5).*PopDec(:,6) + 0.0007715.*PopDec(:,5).*PopDec(:,10) ...
                - 0.0005354.*PopDec(:,6).*PopDec(:,10) + 0.00121.*PopDec(:,8).*PopDec(:,11) + 0.00184.*PopDec(:,9).*PopDec(:,10) ...
                - 0.018.*PopDec(:,2).^2;

            PopObj(:,5) = 0.74 - 0.61.*PopDec(:,2) -0.163.*PopDec(:,3).*PopDec(:,8) ...
                + 0.001232.*PopDec(:,3).*PopDec(:,10) - 0.166.*PopDec(:,7).*PopDec(:,9) ...
                + 0.227.*PopDec(:,2).^2;

            PopObj(:,6) = 109.2 -9.9.*PopDec(:,2) + 6.768.*PopDec(:,3) + 0.1792.*PopDec(:,10) ...
                - 9.256.*PopDec(:,1).*PopDec(:,2) -12.9.*PopDec(:,1).*PopDec(:,8) -11.*PopDec(:,2).*PopDec(:,8) ...
                + 0.1107.*PopDec(:,3).*PopDec(:,10) + 0.0207.*PopDec(:,5).*PopDec(:,10) +6.63.*PopDec(:,6).*PopDec(:,9) ...
                - 17.75.*PopDec(:,7).*PopDec(:,8) + 22.*PopDec(:,8).*PopDec(:,9) + 0.32.*PopDec(:,9).*PopDec(:,10);

            PopObj(:,7) = 4.72 - 0.5.*PopDec(:,4) - 0.19.*PopDec(:,2).*PopDec(:,3) - 0.0122.*PopDec(:,4).*PopDec(:,10) ...
                + 0.009325.*PopDec(:,6).*PopDec(:,10) + 0.000191.*PopDec(:,11).^2;

            PopObj(:,8) = 10.58 - 0.674.*PopDec(:,1).*PopDec(:,2) - 1.95.*PopDec(:,2).*PopDec(:,8) + 0.02054.*PopDec(:,3).*PopDec(:,10) ...
                - 0.0198.*PopDec(:,4).*PopDec(:,10) + 0.028.*PopDec(:,6).*PopDec(:,10);

            PopObj(:,9) = 16.45 - 0.489.*PopDec(:,3).*PopDec(:,7) - 0.843.*PopDec(:,5).*PopDec(:,6) + 0.0432.*PopDec(:,9).*PopDec(:,10);
        end
        function DrawObj(obj,Population)
            Draw(Population.objs);
        end
        function R = GetOptimum(obj,~)
            R = obj.aPF;
        end
    end
end
    