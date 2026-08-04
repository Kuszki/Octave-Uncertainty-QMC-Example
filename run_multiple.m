clear

pkg load parallel
pkg load statistics

addpath("./fwtutils/")

# number of single experiment iterations
num = 1e5

# selected confidence level (in percentage)
cl = 95

# range of expanded uncertainty values
u_min = 1
u_max = 25

# create function to enable parallel execution for iterations
fn = @(x) gen_redtest(u_min, u_max, cl);

# run experiment using all cpu cores
[~, ~, ~, errs_u, errs_n] = pararrayfun(nproc-1, fn, 1:num);

# print table header
printf("\nMETHOD\t[   U-  ;   U+  ] (mean ; std)\n");

# calculate 95% expanded uncertainty for expanded uncertainty estimation error
# in case of using RIA method, then print info about all parameters
[up, um] = get_uncertainty(errs_u, 95, false);
printf("RII:\t[ %0.2f ; %0.2f ] (%0.2f ; %0.2f)\n", um, up, mean(errs_u), std(errs_u));

# calculate 95% expanded uncertainty for expanded uncertainty estimation error
# in case CLT is met assumption, then print info about all parameters
[up, um] = get_uncertainty(errs_n, 95, false);
printf("CLT:\t[ %0.2f ; %0.2f ] (%0.2f ; %0.2f)\n", um, up, mean(errs_n), std(errs_n));

save(sprintf("./wyniki/list_art_%d.dat", cl), "errs_u", "errs_n");
