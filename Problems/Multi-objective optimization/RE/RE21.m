classdef RE21 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% a two-objective version of the reinforced concrete beam design problem.

%------------------------------- Reference --------------------------------
% This is a two-objective version of the reinforced concrete beam design problem.
% 
% Reference:
% H. M. Amir and T. Hasegawa, "Nonlinear Mixed-Discrete Structural Optimization," J. Struct. Eng., vol. 115, no. 3, pp. 626-646, 1989.
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
            F = 10;
            sigma = 10;
            tmpVar = (F / sigma);
            tmpVar2 = 3 * tmpVar;
            obj.lower    = [tmpVar sqrt(2)*tmpVar sqrt(2)*tmpVar tmpVar];
            obj.upper    = [tmpVar2 tmpVar2 tmpVar2 tmpVar2];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);
            x1 = PopDec(:,1);
            x2 = PopDec(:,2);
            x3 = PopDec(:,3);
            x4 = PopDec(:,4);

            F = 10;
            sigma = 10;
            E = 2 * 1e5;
            L = 200;

            PopObj(:,1) = L * ((2 * x1) + sqrt(2.0) * x2 + sqrt(x3) + x4);
            PopObj(:,2) = ((F * L) / E) * ((2.0 ./ x1) + (2.0 * sqrt(2.0) ./ x2) - (2.0 * sqrt(2.0) ./ x3) + (2.0 ./ x4));
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE21.dat');
        end
    end
end