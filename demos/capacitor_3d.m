%capacitor_3d.m The parallel plate capacitor problem
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

[p,b,t,nv,nbe,nt,labels]=ffreadmesh('cap3d.mesh');
[u]=ffreaddata('cap3dpot.txt');
[Ex,Ey,Ez]=ffreaddata('cap3dvec.txt');

S1=[-0 0.375 0.0; ...
    0.375 0 0.0];
S2=[0.0 0.375 0.5; ...
    0.375 0 0.5];
S3=[0.75 0.375 0.0; ...
    0.375 0.75 0.0];

figure;
ffpdeplot3D(p,b,t,'XYZData',u,'Slice',S1,S2,S3,'SGridParam',[30,30], ...
            'Boundary','off','ColorMap','jet','ColorBar','on','BoundingBox','on');

figure;
ffpdeplot3D(p,b,t,'XYZData',u,'Slice',S1,S2,S3,'BDLabels',[30,31],'ColorMap','jet');

figure;
ffpdeplot3D(p,b,t,'XYZData',u,'Slice',S1,S2,S3,'BDLabels',[30,31], ...
            'XYZStyle','monochrome','ColorMap','jet');

figure;
ffpdeplot3D(p,b,t,'XYZData',u,'Slice',S1,S2,S3,'BDLabels',[40,42,43,55], ...
            'XYZStyle','noface','ColorMap','jet');

%\TODO: Handle Quiver and multiple slices
figure;
ffpdeplot3D(p,b,t,'FlowData',[Ex,Ey,Ez],'Slice',S1,S2,S3,'BDLabels',[30,31], ...
            'XYZStyle','noface','ColorMap','jet');

S1=[0.0 0.0 0.25];
S2=[0.0 0.75 0.25];
S3=[0.75 0.0 0.25];

figure;
ffpdeplot3D(p,b,t,'FlowData',[Ex,Ey,Ez],'Slice',S1,S2,S3,'Boundary','off', ...
            'ColorMap','jet','BoundingBox','on');

S1=[0.0 0.375 0.0];
S2=[0.0 0.375 0.5];
S3=[0.75 0.375 0.0];

figure;
ffpdeplot3D(p,b,t,'XYZData',u,'FlowData',[Ex,Ey,Ez],'Slice',S1,S2,S3,
            'BDLabels',[30,31],'XYZStyle','noface','ColorMap','jet','BoundingBox','on');

%plot all boundaries and color the plot
figure;
ffpdeplot3D(p,b,t,'XYZData',u,'ColorMap','jet');
%axis off;

%plot all boundaries and do not color
figure;
ffpdeplot3D(p,b,t,'XYZStyle','monochrome');
str={sprintf('nVertex: %i',nv);
     sprintf('nTets:   %i',nt);
     sprintf('nTris:   %i',nbe)};
annotation('textbox',[0.05 0.05 0.2 0.15],'String',str, ...
           'FitBoxToText','on','FontName','Courier','EdgeColor',[1 1 1]);

%plot electrodes only
figure;
ffpdeplot3D(p,b,t,'XYZData',u,'ColorMap','jet','BDLabels',[30,31]);

figure;
%plot all boundaries and color the plot
ffpdeplot3D(p,b,t,'BDLabels',[30,31],'XYZStyle','monochrome');
