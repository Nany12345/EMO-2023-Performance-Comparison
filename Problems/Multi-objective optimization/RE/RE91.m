classdef RE91 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% the car cab design problem.

%------------------------------- Reference --------------------------------
% This is the car cab design problem.
% 
% Reference:
% K. Deb and H. Jain, "An evolutionary many-objective optimization algorithm using reference-point-based nondominated sorting approach, part I: solving problems with box constraints," IEEE TEVC, vol. 18, no. 4, pp. 577-601, 2014
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
        %% Initialization
        function Setting(obj)
            if isempty(obj.M)
                obj.M = 9;
            end
            if isempty(obj.D)
                obj.D = 7;
            end

            obj.lower    = [0.5 0.45 0.5 0.5 0.875 0.4 0.4];
            obj.upper    = [1.5 1.35 1.5 1.5 2.625 1.2 1.2];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);

            for i = 1:size(PopDec,1)           
                x0 = PopDec(i,1);
                x1 = PopDec(i,2);
                x2 = PopDec(i,3);
                x3 = PopDec(i,4);
                x4 = PopDec(i,5);	
                x5 = PopDec(i,6);	
                x6 = PopDec(i,7);
                
                x7 = 0.006 * randn + 0.345;
                x8 = 0.006 * randn + 0.192;
                x9 = 10 * randn + 0.0;
                x10 = 10 * randn + 0.0;
                
                % First original objective function
                PopObj(i,1) = 1.98 + 4.9 * x0 + 6.67 * x1 + 6.98 * x2 +  4.01 * x3 +  1.75 * x4 +  0.00001 * x5  +  2.73 * x6;                % Second original objective function
                PopObj(i,2) = max(0.0, (1.16 - 0.3717* x1 * x3 - 0.00931 * x1 * x9 - 0.484 * x2 * x8 + 0.01343 * x5 * x9 )/1.0) ;

                % Third original objective function
                PopObj(i,3) = max(0.0, (0.261 - 0.0159 * x0 * x1 - 0.188 * x0 * x7 - 0.019 * x1 * x6 + 0.0144 * x2 * x4 + 0.87570001 * x4 * x9 + 0.08045 * x5 * x8 + 0.00139 * x7 * x10 + 0.00001575 * x9 * x10)/0.32);

                PopObj(i,4) = max(0.0, (0.214 + 0.00817 * x4  - 0.131 * x0 * x7 - 0.0704 * x0 * x8 + 0.03099 * x1 * x5 - 0.018 * x1 * x6 + 0.0208 * x2 * x7 + 0.121 * x2 * x8 - 0.00364 * x4 * x5 + 0.0007715 * x4 * x9 - 0.0005354 * x5 * x9 + 0.00121 * x7 * x10 + 0.00184 * x8 * x9 - 0.018 * x1 * x1)/0.32);

                PopObj(i,5) =  max(0.0, (0.74 - 0.61* x1 - 0.163 * x2 * x7 + 0.001232 * x2 * x9 - 0.166 * x6 * x8 + 0.227 * x1 * x1)/0.32);

                temp = (( 28.98 + 3.818 * x2 - 4.2 * x0 * x1 + 0.0207 * x4 * x9 + 6.63 * x5 * x8 - 7.77 * x6 * x7 + 0.32 * x8 * x9) + (33.86 + 2.95 * x2 + 0.1792 * x9 - 5.057 * x0 * x1 - 11 * x1 * x7 - 0.0215 * x4 * x9 - 9.98 * x6 * x7 + 22 * x7 * x8) + (46.36 - 9.9 * x1 - 12.9 * x0 * x7 + 0.1107 * x2 * x9) )/3;

                PopObj(i,6) =  max(0.0, temp/32);           

                PopObj(i,7) =  max(0.0, (4.72 - 0.5 * x3 - 0.19 * x1 * x2 - 0.0122 * x3 * x9 + 0.009325 * x5 * x9 + 0.000191 * x10 * x10)/4.0);

                PopObj(i,8) =  max(0.0, (10.58 - 0.674 * x0 * x1 - 1.95  * x1 * x7  + 0.02054  * x2 * x9 - 0.0198  * x3 * x9  + 0.028  * x5 * x9)/9.9) ;

                PopObj(i,9) =  max(0.0, (16.45 - 0.489 * x2 * x6 - 0.843 * x4 * x5 + 0.0432 * x8 * x9 - 0.0556 * x8 * x10 - 0.000786 * x10 * x10)/15.7);  
            end
        end
        %% Sample reference points on Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE91.dat');
        end
    end
end