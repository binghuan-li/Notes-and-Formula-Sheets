%% plot the sign function
clear all;
close all;
clc;

x = -5:0.001:5;
figure('position', [100 100 500 250]);
plot(x, sign(x), 'LineWidth', 3);
ylim([-2, 2]);
grid on;
grid minor;
hold on;
yline(0, '--');
xline(0, '--');
xlabel('$x$', 'Interpreter', 'latex', 'fontsize', 14);
ylabel('$\mathrm{sign}(x)$', 'Interpreter', 'latex', 'fontsize', 14);