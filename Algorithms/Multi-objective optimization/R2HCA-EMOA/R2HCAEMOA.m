classdef R2HCAEMOA < ALGORITHM
% <multi> <real>
% A new hypervolume-based evolutionary
% algorithm for many-objective optimization

%------------------------------- Reference --------------------------------
% K. Shang and H. Ishibuchi, A new hypervolume-based evolutionary
% algorithm for many-objective optimization, IEEE Transactions on
% Evolutionary Computation, 2020, 24(5): 839-852.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2022 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

   methods
       function main(Algorithm,Problem)
            %% Paremeter settings
            num_vec = Algorithm.ParameterSet(100);  
            r = 1+1/getH(Problem.M,Problem.N);

            %% Generate initial population
            Population = Problem.Initialization();

            %% Generate direction vectors
            [W,num_vec] = UniformVector(num_vec,Problem.M);

            %% Initialize tensor
            PopObj = Population.objs;
            fmax   = max(PopObj,[],1);
            fmin   = min(PopObj,[],1);
            PopObj  = (PopObj-repmat(fmin,size(PopObj,1),1))./repmat(fmax-fmin,size(PopObj,1),1);
            PopObj = [PopObj;zeros(1,Problem.M)];
            tensor = InitializeUtilityTensor(Problem,PopObj,W,r,num_vec);
            worst = Problem.N+1;  

            %% Optimization
            while Algorithm.NotTerminated(Population)                  
                for i = 1 : Problem.N
                    Offspring = OperatorGAhalf(Population(randperm(end,2)));
                    if worst == 1
                        Population1 = [Offspring,Population];
                    elseif worst == Problem.N+1
                        Population1 = [Population,Offspring];
                    else
                        Population1 = [Population(1:worst-1),Offspring,Population(worst:end)];
                    end
                    [Population,worst,tensor] = Reduce(Problem,Population1,W,worst,tensor,r,num_vec);
                end
            end
       end
   end
end