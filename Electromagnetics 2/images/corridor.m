%% solve Laplace equation for electric field
% Binghuan Li, 05/10/2025

clear all
close all
clc

% constants
a = 1; % width
b = 3; % height
V = 300;% roof potential

model = createpde;
% geometry
% [3 = rect, 4 vertices, xxxx, yyyy]
R = [3, 4, ...
    0, 0, a, a, ...
    0, b, b, 0]';

g = decsg(R);
geometryFromEdges(model, g);
figure(1)
pdegplot(model, Edgelabel='on');
axis equal

applyBoundaryCondition(model, "dirichlet", ...
    "Edge", [1, 3, 4], 'u', 0);
applyBoundaryCondition(model, "dirichlet", ...
    "Edge", 2, 'u', V);

% const. Laplace eqn
specifyCoefficients(model, ...
    m=0, d=0, c=1, a=0, f=0);

figure(2) % plot mesh
generateMesh(model, Hmax=.05);
pdemesh(model);

result = solvepde(model);
u = result.NodalSolution();

%--------------------------------------
figure(3)
subplot(1, 2, 2)
pdeplot(result.Mesh, XYData=result.NodalSolution, ...
    colormap='jet', mesh='on');
axis equal tight
xlim([0, a]);
ylim([0, b]);
xlabel("$x$ [m]", interpreter='latex');
ylabel("$y$ [m]", interpreter='latex');
title("Simulated Solution");

% analytical solution
xx = linspace(0, a, 100);
yy = linspace(0, b, 100);
[XX, YY] = meshgrid(xx, yy);
V_analy = zeros(size(XX));
nterms = 81;
for n = 1:2:nterms
    k = n*pi/a;

    % numerically stable ratio: sinh(k*YY)/sinh(k*b)
    % r = exp(k*(YY-b)) * (1 - exp(-2*k*YY)) / (1 - exp(-2*k*b));
    num = exp(k*(YY-b)) .* (1 - exp(-2*k*YY));
    den = (1 - exp(-2*k*b));
    r = num ./ den;
    V_analy = V_analy + (4*V/(n*pi)) * sin(k*XX) .* r;
end

subplot(1, 2, 1)
levels = linspace(0,V,60);
contourf(XX, YY, V_analy, levels,'LineColor', 'none');
caxis([0 V]);
colorbar;
axis equal tight
xlim([0, a]);
ylim([0, b]);
xlabel("$x$ [m]", interpreter='latex');
ylabel("$y$ [m]", interpreter='latex');
title("Analytical Solution");
