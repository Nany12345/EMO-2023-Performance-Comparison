classdef DDMOP2 < PROBLEM
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
        function Setting(obj)
            if isempty(obj.M); obj.M = 3; end
            if isempty(obj.D); obj.D = 5; end
            obj.lower    = ones(1,5);
            obj.upper    = 3.*ones(1,5);
            obj.encoding = 'real';
            CallStack = dbstack('-completenames');
            load(fullfile(fileparts(CallStack(1).file),'DDMOP2_PF.mat'),'PF');
            obj.aPF = PF;
        end
		
		function PopObj = CalObj(obj,PopDec)
		
				PopObj = zeros(size(PopDec,1),obj.M);
				PopObj(:,1) = 1640.2823 + 2.3573285.*PopDec(:,1) + 2.3220035.*PopDec(:,2) ...
				+ 4.5688768.*PopDec(:,3) + 7.7213633.*PopDec(:,4) + 4.4559504.*PopDec(:,5);
			
				PopObj(:,2) = 6.5856 + 1.15.*PopDec(:,1) - 1.0427.*PopDec(:,2) ...
				+ 0.9738.*PopDec(:,3) + 0.8364.*PopDec(:,4) - 0.3695.*PopDec(:,1).*PopDec(:,4) ...
				+ 0.0861.*PopDec(:,1).*PopDec(:,5) + 0.3628.*PopDec(:,2).*PopDec(:,4) - 0.1106.*PopDec(:,1).^2 ...
				- 0.3437.*PopDec(:,3).^2 + 0.1764.*PopDec(:,4).^2;
			
				PopObj(:,3) = -0.0551 + 0.0181.*PopDec(:,1) + 0.1024.*PopDec(:,2) ...
				+ 0.0421.*PopDec(:,3) - 0.0073.*PopDec(:,1).*PopDec(:,2) + 0.024.*PopDec(:,2).*PopDec(:,3) ...
				- 0.0118.*PopDec(:,2).*PopDec(:,4) - 0.0204.*PopDec(:,3).*PopDec(:,4) - 0.008.*PopDec(:,3).*PopDec(:,5) ...
				- 0.0241.*PopDec(:,2).^2 + 0.0109.*PopDec(:,4).^2;
        end
        function R = GetOptimum(obj,~)
            R = obj.aPF;
        end
    end
end