classdef DDMOP4 < PROBLEM
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
            Prate   = 65000;
            El      = 400;
            w0      = 2*pi*50;
            ws      = 2*pi*16000;
            Vdc     = 800;
            Rb      = El^2/Prate;
            Iref    = 141;
            K       = 9;
            if isempty(obj.M); obj.M = 10; end
            if isempty(obj.D); obj.D = 13; end
            obj.lower    = [2*pi*Vdc/(3.2*ws*Iref) 0.001*Rb/w0 0.001/(Rb*w0) 0.001/(Rb*w0) 0.001/(Rb*w0).*ones(1,obj.M-1)];
            obj.upper    = [2*pi*Vdc/(1.6*ws*Iref) 0.1*El^2/(Prate*w0) 0.1*El^2/(Prate*w0) 0.05*Prate/(El^2*w0) 0.05*Prate/(El^2*w0).*ones(1,obj.M-1)];
            obj.encoding = 'real';
            CallStack = dbstack('-completenames');
            load(fullfile(fileparts(CallStack(1).file),'DDMOP4_PF.mat'),'PF');
            obj.aPF = PF;
        end
		function PopObj = CalObj(obj,PopDec)

            Prate   = 65000;
            El      = 400;
            w0      = 2*pi*50;
            ws      = 2*pi*16000;
            Vdc     = 800;
            Rb      = El^2/Prate;
            Iref    = 141;
            K       = 9;
            M       = obj.M; 
            L       = PopDec(:,1:3);
            Cf      = PopDec(:,4);
            C       = PopDec(:,5:end);
            Lf      = 1./(repmat((1:K).^2.*ws^2,size(C,1),1).*C);
            PopObj  = zeros(size(PopDec,1),M);
            for i = 1 : M-1
                PopObj(:,i) = 20.*log(abs(Transfer(i*ws*1i,PopDec,M-1)));
            end
            PopObj(:,M) = sum(L,2) + sum(Lf,2);
        end
        function R = GetOptimum(obj,~)
            R = obj.aPF;
        end
    end
end


function G = Transfer(s,X,n)
    L   = X(:,1:3);
    Cf	= X(:,4);
    C   = X(:,5:end);
    ws  = 2*pi*16000;
    Lf  = 1./(repmat((1:n).^2.*ws^2,size(C,1),1).*C);
    RL  = 0.005;
    Glc = sum(repmat((L(:,2).*s.*(L(:,3).*Cf.*s.^2+1) + L(:,3).*s),1,n)./(Lf.*s + RL + 1./(C.*s)),2);
    G = 1./(L(:,1).*s.*Glc + L(:,2).*s.*(L(:,3).*Cf.*s.^2+1) + L(:,3).*s);
end
       

