classdef RE31 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% a three-objective version of the two bar truss design problem

%------------------------------- Reference --------------------------------
% This is a three-objective version of the two bar truss design problem
% 
% Reference:
%  C. A. C. Coello and G. T. Pulido, "Multiobjective structural optimization using a microgenetic algorithm," Stru. and Multi. Opt., vol. 30, no. 5, pp. 388-403, 2005.
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
                obj.D = 3;
            end

            obj.lower    = [0.00001 0.00001 1.0];
            obj.upper    = [100.0 100.0 3.0];
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

                % First original objective function
                PopObj(i,1) = x1 * sqrt(16.0 + (x3 * x3)) + x2 * sqrt(1.0 + x3 * x3);

                % Second original objective function
                PopObj(i,2) = (20.0 * sqrt(16.0 + (x3 * x3))) / (x1 * x3);

                % Constraint functions 
                g(1) = 0.1 - PopObj(i,1);
                g(2) = 100000.0 - PopObj(i,2);
                g(3) = 100000 - ((80.0 * sqrt(1.0 + x3 * x3)) / (x3 * x2));

                % Calculate the constratint violation values
                g(g>=0)=0;
                g(g<0)=-g(g<0); 

                PopObj(i,3) = g(1) + g(2) + g(3);	
            end
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE31.dat');
        end
    end
end