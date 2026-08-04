pkg load stk

h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

set(h, "paperunits", "centimeters")
set(h, "papersize", [8.85 5.75])
set(h, "paperposition", [0, 0, [8.85 5.75]])

set(0, "defaultaxesposition", [0.055, 0.115, 0.915, 0.865])
set(0, "defaultaxesfontsize", 7)
set(0, "defaultaxesfontsize", 7)
set(0, "defaulttextfontname", "Arial")
set(0, "defaultaxesfontname", "Arial")
set(0, "defaulttextcolor", "black")

DIM = 2;
BOX = [0 0; 5 4];
N   = 64;

W = 3;
H = 2;

PLOT_OPTIONS = {'ko', 'MarkerSize', 2, 'MarkerFaceColor', 'k'};

x = stk_sampling_regulargrid (N, DIM, BOX);
subplot (H, W, 1);  plot (x(:, 1), x(:, 2), PLOT_OPTIONS{:});
title ('a)\rm Równomiernie'); grid on;

x = stk_sampling_sobol (N, DIM, BOX);
subplot (H, W, 2);  plot (x(3:end, 1), x(3:end, 2), PLOT_OPTIONS{:});
title ('b)\rm Sobol'); grid on;

x = double(stk_sampling_halton_rr2 (N, DIM, BOX));
subplot (H, W, 3);  plot (x(3:end, 1), x(3:end, 2), PLOT_OPTIONS{:});
title ('c)\rm Halton'); grid on;

x = stk_sampling_maximinlhs (N, DIM, BOX);
subplot (H, W, 4);  plot (x(3:end, 1), x(3:end, 2), PLOT_OPTIONS{:});
title ('d)\rm Maximin LHS'); grid on;

x = stk_sampling_randomlhs (N, DIM, BOX);
subplot (H, W, 5);  plot (x(3:end, 1), x(3:end, 2), PLOT_OPTIONS{:});
title ('e)\rm Random LHS'); grid on;

x = stk_sampling_randunif (N, DIM, BOX);
subplot (H, W, 6);  plot (x(3:end, 1), x(3:end, 2), PLOT_OPTIONS{:});
title ('f)\rm Klasycznie'); grid on;

print("./obrazki/qmc_demo.png", "-r1200");

