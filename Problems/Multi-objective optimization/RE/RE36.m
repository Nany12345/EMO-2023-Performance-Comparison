classdef RE36 < PROBLEM
% <multi/many> <real> <large/none> <expensive/none>
% a three objective version of the gear train design problem.

%------------------------------- Reference --------------------------------
% This is a three objective version of the gear train design problem.
% 
% Reference:
% Kalyanmoy Deb and Aravind Srinivasan, "Innovization: Innovative Design Principles Through Optimization," KanGAL Report Number 2005007, Indian Institute of Technology Kanpur (2005).
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
                obj.D = 4;
            end

            obj.lower    = [12 12 12 12];
            obj.upper    = [60 60 60 60];
            obj.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            M      = obj.M;
            PopObj = zeros(size(PopDec,1),M);

            for i = 1:size(PopDec,1)            
                x1 = round(PopDec(i,1));
                x2 = round(PopDec(i,2));
                x3 = round(PopDec(i,3));
                x4 = round(PopDec(i,4));

            	% First original objective function
                PopObj(i,1) = abs(6.931 - ((x3 / x1) * (x4 / x2)));

                % Second original objective function (the maximum value among the four variables)
                A = [x1 x2 x3 x4];
                PopObj(i,2) = max(A);

                g(1) = 0.5 - (PopObj(i,1) / 6.931);

                % Calculate the constratint violation values
                g(g>=0)=0;
                g(g<0)=-g(g<0); 

                PopObj(i,3) = g(1);
            end
        end
        %% Generate points on the Pareto front
        function R = GetOptimum(obj,N)
            R = load('reference_points_RE36.dat');
        end
    end
end