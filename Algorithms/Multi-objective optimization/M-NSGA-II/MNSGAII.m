classdef MNSGAII < ALGORITHM
% <multi/many> <real/binary/permutation>
% NSGA-II with simple modification works well on a wide variety of 
% many-objective problems

%------------------------------- Reference --------------------------------
% L. M. Pang, H. Ishibuchi, and K. Shang, NSGA-II with simple modification
% works well on a wide variety of many-objective problems, IEEE Access 2020,
% 8: 190240-190250.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        function main(Algorithm,Problem)
            Population = Problem.Initialization();
            alpha=0.5; 
            M=Problem.M;
            Mod_obj=(1-alpha).*Population.objs +(alpha/M)*sum(Population.objs,2);
            [~,FrontNo,CrowdDis] = EnvironmentalSelection_Mod(Population, Mod_obj,Problem.N);

            %% Optimization
            while Algorithm.NotTerminated(Population)
                MatingPool = TournamentSelection(2,Problem.N,FrontNo,-CrowdDis);
                Offspring  = OperatorGA(Population(MatingPool));
                combined=[Population,Offspring]; 
                Mod_obj=(1-alpha).*combined.objs +(alpha/M)*sum(combined.objs,2);
                [Population,FrontNo,CrowdDis] = EnvironmentalSelection_Mod([Population,Offspring],Mod_obj,Problem.N);
            end
        end
    end
end