classdef RE35 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% the vehicle crashworthiness design problem.

%------------------------------- Reference --------------------------------
% This is the vehicle crashworthiness design problem.
% 
% Reference:
% X. Liao, Q. Li, X. Yang, W. Zhang, and W. Li, "Multiobjective optimization for crash safety design of vehicles using stepwise regression model," Struct. Multidiscipl. Optim., vol. 35, no. 6, pp. 561-569, 2008.
%
%  Copyright (c) 2018 Ryoji Tanabe
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------

    methods
        %% Default settings of the problem
        function Setting(obj)
            if isempty(obj.M)
                obj.M = 3;
            end
            if isempty(obj.D)
                obj.D = 7;
            end

            obj.lower    = [2.6 0.7 17 7.3 7.3 2.9 5.0];
            obj.upper    = [3.6 0.8 28 8.3 8.3 3.9 5.5];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);

            for i = 1:size(PopDec,1)             
                x1 = PopDec(i,1);
                x2 = PopDec(i,2);
                x3 = PopDec(i,3);
                x4 = PopDec(i,4);
                x5 = PopDec(i,5);
                x6 = PopDec(i,6);
                x7 = PopDec(i,7);

                % First original objective function (weight)
                PopObj(i,1) = 0.7854 * x1 * (x2 * x2) * (((10.0 * x3 * x3) / 3.0) + (14.933 * x3) - 43.0934) - 1.508 * x1 * (x6 * x6 + x7 * x7) + 7.477 * (x6 * x6 * x6 + x7 * x7 * x7) + 0.7854 * (x4 * x6 * x6 + x5 * x7 * x7);

                % Second original objective function (stress)
                tmpVar = power((745.0 * x4) / (x2 * x3), 2.0)  + 1.69 * 1e7;
                PopObj(i,2) =  sqrt(tmpVar) / (0.1 * x6 * x6 * x6);

                % Constraint functions 	
                g(1) = -(1.0 / (x1 * x2 * x2 * x3)) + 1.0 / 27.0;
                g(2) = -(1.0 / (x1 * x2 * x2 * x3 * x3)) + 1.0 / 397.5;
                g(3) = -(x4 * x4 * x4) / (x2 * x3 * x6 * x6 * x6 * x6) + 1.0 / 1.93;
                g(4) = -(x5 * x5 * x5) / (x2 * x3 * x7 * x7 * x7 * x7) + 1.0 / 1.93;
                g(5) = -(x2 * x3) + 40.0;
                g(6) = -(x1 / x2) + 12.0;
                g(7) = -5.0 + (x1 / x2);
                g(8) = -1.9 + x4 - 1.5 * x6;
                g(9) = -1.9 + x5 - 1.1 * x7;
                g(10) =  -PopObj(i,2) + 1300.0;
                tmpVar = power((745.0 * x5) / (x2 * x3), 2.0) + 1.575 * 1e8;
                g(11) = -sqrt(tmpVar) / (0.1 * x7 * x7 * x7) + 1100.0;


                % Calculate the constratint violation values
                g(g>=0)=0;
                g(g<0)=-g(g<0); 

                PopObj(i,3) = g(1) + g(2) + g(3) + g(4) + g(5) + g(6) + g(7) + g(8) + g(9) + g(10) + g(11);
            end
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE35.dat');
        end
    end
end