% https://www.youtube.com/watch?v=98VixA3MjAc

clear all
close all
clc

L = 10;
N = 1024;
dx = L/(N-1);
x = 0:dx:L;

f = zeros(size(x));
f(256:768) = 1;

A0 = sum(f.*ones(size(x)))*dx*2/L;

figure('Position', [10 10 600 500])
counter=1;
for term=[1, 5, 15, 25, 50, 75]
    fFS = A0/2;
    for k = 1:term
        Ak = sum(f.*cos(2*pi*k*x/L))*dx*2/L;
        Bk = sum(f.*sin(2*pi*k*x/L))*dx*2/L;
        fFS = fFS + Ak*cos(2*k*pi*x/L) + Bk*sin(2*k*pi*x/L);
    end
    subplot(3, 2, counter)
    plot(x, f, 'k','linewidth', 2);
    hold on;
    plot(x, fFS, 'linewidth', 1.5);
    title(['$N$=',num2str(term)], 'Interpreter', 'latex', 'fontsize', 12);
    xticks([]); yticks([]);
    xline(5, 'k'); yline(0, 'k');
    
    counter = counter + 1;
end


