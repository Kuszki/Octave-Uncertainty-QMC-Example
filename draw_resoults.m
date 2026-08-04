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

subplot(1, 3, j+1)
p = errorbar(...
  d1(:,1)*0.65, d1(:,2), 2*d1(:,3), 'x', ...
  d2(:,1), d2(:,2), 2*d2(:,3), '+', ...
  d3(:,1)*1.55, d3(:,2), 2*d3(:,3), '*' ...
);
title(sprintf("%c)\\rm %d próbek", char('a' + j++), 8*i));
xlim([ 0.5*d2(1,1) 2*d2(end,1) ]);
xticks(d2(:,1));
xlabel("Liczba iteracji");
ylabel("Błąd względny, %");
grid on;

set(gca, 'xscale', 'log');
set(p, 'markersize', 4);
set(p, 'linewidth', 1);

h = legend ("MC", "QMC", "Miks");
set(h, "location", "none", "position", [ (0.2+(j-1)*1.01*(1/3))   0.2   0.080   0.095], "units", "normalized");

set_format(gca, 'Y', true)

end

print("./obrazki/res_all.png", "-r1200");
