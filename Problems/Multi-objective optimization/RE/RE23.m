classdef RE23 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% a two-objective version of the pressure vessel design problem.

%------------------------------- Reference --------------------------------
% This is a two-objective version of the pressure vessel design problem.
% 
% Reference:
% B. K. Kannan and S. N. Kramer, "An Augmented Lagrange Multiplier Based Method for Mixed Integer Discrete Continuous Optimization and Its Applications to Mechanical Design, Journal of Mechanical Design, vol. 116, no. 2, pp. 405-411, 1994.
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
                obj.M = 2;
            end
            if isempty(obj.D)
                obj.D = 4;
            end

            obj.lower    = [1 1 10 10];
            obj.upper    = [100 100 200 240];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);

            for i = 1:size(PopDec,1)
                x1 = 0.0625 * round(PopDec(i,1));
                x2 = 0.0625 * round(PopDec(i,2));
                x3 = PopDec(i,3);
                x4 = PopDec(i,4);		 

                % First original objective function
                PopObj(i,1) = (0.6224 * x1 * x3* x4) + (1.7781 * x2 * x3 * x3) + (3.1661 * x1 * x1 * x4) + (19.84 * x1 * x1 * x3);

                g(1) = x1 - (0.0193 * x3);
                g(2) = x2 - (0.00954 * x3);
                g(3) = (pi * x3 * x3 * x4) + ((4.0/3.0) * (pi * x3 * x3 * x3)) - 1296000;

                % Calculate the constratint violation values
                g(g>=0)=0;
                g(g<0)=-g(g<0); 

                PopObj(i,2) = g(1) + g(2) + g(3);	
            end
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE23.dat');
        end
    end
end