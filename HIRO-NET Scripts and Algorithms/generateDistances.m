function [DISTANCE_BASE,DISTANCE_POI] = generateDistances(x_base,y_base,x_pois,y_pois,N_poi)
% GENERATEDISTANCES This function computes the Euclidian distance between a given base located at (x_base,y_base) and the PoIs. 
% This function computes the Euclidian distance between a given base located at (x_base,y_base) and the PoIs. 

DISTANCE_BASE = sqrt((x_base-x_pois).^2+(y_base-y_pois).^2);
DISTANCE_POI = zeros(N_poi,N_poi);
for p = 1 : N_poi
    DISTANCE_POI(:,p)=sqrt((x_pois-x_pois(p)).^2+(y_pois-y_pois(p)).^2);
end
end

% my_frame
% LPD/LPI Scheme Transmitter
% Copyright (c) 2016 Emrecan Demirors and Tommaso Melodia, WiNES Lab, Northeastern University,
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
