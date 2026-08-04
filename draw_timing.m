clear;

addpath("./fwtutils/")

h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 5])
set(h, "paperposition", [0, 0, [16 5]])

set(0, "defaultaxesposition", [0.065, 0.115, 0.915, 0.865])
set(0, "defaultaxesfontsize", 7)
set(0, "defaultaxesfontsize", 7)
set(0, "defaulttextfontname", "Arial")
set(0, "defaultaxesfontname", "Arial")
set(0, "defaulttextcolor", "black")


A = [ 1 10 100 ];
j = 0;

for i = A

d1 = load(sprintf("./wyniki/normal_%d.dat", i));
d2 = load(sprintf("./wyniki/quasi_%d.dat", i));
d3 = load(sprintf("./wyniki/mixed_%d.dat", i));

dd(:,1) = d1(:,4);
dd(:,2) = d2(:,4);
dd(:,3) = d3(:,4);

subplot(1, 3, j+1)
p = bar(dd, 'basevalue', 1e-3);
title(sprintf("%c)\\rm %d próbek", char('a' + j++), 8*i));
xlabel("Liczba iteracji");
ylabel("Czas obliczeń, s");
ylim([1e-3 1e3]);
grid on;

h = legend ("MC", "QMC", "Miks");
set(h, "location", "none", "position", [ (0.075+(j-1)*1.01*(1/3))   0.57   0.080   0.095], "units", "normalized");

set(gca, 'yscale', 'log');
set(gca, 'xticklabel', arrayfun(@(x) strrep(sprintf('10^{%g}', log10(x)), '-', '−'), d2(:,1), 'UniformOutput', false));

end

print("./obrazki/res_timing.png", "-r1200");
