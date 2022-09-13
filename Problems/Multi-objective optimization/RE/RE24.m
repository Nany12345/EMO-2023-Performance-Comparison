classdef RE24 < PROBLEM
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
                obj.D = 2;
            end

            obj.lower    = [0.5 0.5];
            obj.upper    = [4 50];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);

            for i = 1:size(PopDec,1)
                x1 = PopDec(i,1);
                x2 = PopDec(i,2);

                % First original objective function
                PopObj(i,1) = x1 + (120 * x2);

                E = 700000;
                sigmaBMax = 700;
                tauMax = 450;
                deltaMax = 1.5;
                sigmaK = (E * x1 * x1) / 100;
                sigmaB = 4500 / (x1 * x2);
                tau = 1800 / x2;
                delta = (56.2 * 10000) / (E * x1 * x2 * x2);

                g(1) = 1 - (sigmaB / sigmaBMax);
                g(2) = 1 - (tau / tauMax);
                g(3) = 1 - (delta / deltaMax);
                g(4) = 1 - (sigmaB / sigmaK);

                % Calculate the constratint violation values
                g(g>=0)=0;
                g(g<0)=-g(g<0); 

                PopObj(i,2) = g(1) + g(2) + g(3) + g(4);
            end
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE24.dat');
        end
    end
end