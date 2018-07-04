%vortex_rolls.m Free convection problem between to flat plates
%
% Author: Chloros2 <chloros2@gmx.de>
% Created: 2018-05-13
%
% Copyright (C) 2018 Chloros2 <chloros2@gmx.de>
%
% This program is free software: you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see
% <https://www.gnu.org/licenses/>.
%

clear all;

addpath('ffmatlib');

%Reads a FreeFem++ mesh created with the savemesh(Th,"mesh.msh"); command
[points,boundary,triangles]=ffreadmesh('convective_rolls.msh');
%Reads the PDE data
u=ffreaddata('convective_rolls_temperature.txt');
psi=ffreaddata('convective_rolls_stream.txt');
[vx,vy]=ffreaddata('convective_rolls_velocity.txt');

%%%%%% 2D Patch (density map) Plot

figure('Position', [20 50 1200 400]);
handles=ffpdeplot(points,boundary,triangles, ...
                  'XYData',u, ...
                  'Mesh','on', ...
                  'Edge','on', ...
                  'Title','Temperature');

title(handles(2),'T[degC]');
ylabel('y');
xlabel('x');
axis tight;


%%%%%% 3D Surf Plot

figure;

handles=ffpdeplot(points,boundary,triangles, ...
                  'XYData',u, ...
                  'ZStyle','continuous', ...
                  'Mesh','off', ...
                  'Title','Temperature');
ylabel('y');
xlabel('x');
zlabel('u');
title(handles(2),'T[degC]');
grid;


%%%%%% Combine Patch and Contour

figure('Position', [20 50 1200 400]);
handles=ffpdeplot(points,boundary,triangles, ...
                  'XYData',u, ...
                  'Mesh','off', ...
                  'Edge','on', ...
                  'Contour','on', ...
                  'CXYData',psi, ...
                  'CStyle','plain', ...
                  'XYStyle','interp', ...
                  'CGridParam',[150, 150], ...
                  'ColorMap','jet', ...
                  'Title','Stream lines + Temperature');

ylabel('y');
xlabel('x');
title(handles(3),'T[degC]');
axis tight;

%%%%%% Contour

figure('Position', [20 50 1200 400]);
handles=ffpdeplot(points,boundary,triangles, ...
                  'Mesh','off', ...
                  'Edge','on', ...
                  'Contour','on', ...
                  'CColor','auto', ...
                  'XYData',psi, ...
                  'CStyle','plain', ...
                  'XYStyle','off', ...
                  'CGridParam',[150, 150], ...
                  'ColorMap','jet', ...
                  'Title','Streamlines');

ylabel('y');
xlabel('x');
title(handles(2),'psi[(m^3/s)/m]');
axis tight;

%%%%%% Combine Quiver and Patch

figure('Position', [20 50 1200 400]);

handles=ffpdeplot(points,boundary,triangles, ...
                  'XYData',u, ...
                  'Mesh','off', ...
                  'Edge','on', ...
                  'ColorMap','jet', ...
                  'FlowData',[vx,vy], ...
                  'FGridParam',[60, 15], ...
                  'Title','Velocity + Temperature');

ylabel('y');
xlabel('x');
title(handles(2),'T[degC]');

axis tight;

% pause(20);
% close all;
