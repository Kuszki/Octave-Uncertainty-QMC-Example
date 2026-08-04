function [us, uc_u, uc_n, pd_u, pd_n, vu, vc] = gen_redtest(u_min, u_max, alpha)

  num = 3;
  u_df = (u_max - u_min);

  vu = rand(1, num) * u_df + u_min;
  vc = "ntu";

  vr = gen_randm(1e5, vc, vu, 'u', alpha);
  us = get_uncertainty(sum(vr), alpha);

  for j = 1 : num
    [vu(j), ~, vs(j)] = get_uncertainty(vr(j,:), alpha);
  end

  uc_u = get_unccalc(vu, vc, alpha);
  pd_u = 100 * (uc_u - us) / us;

  uc_n = norminv(1 - (1 - alpha/100) / 2) * sqrt(sum(vs.^2));
  pd_n = 100 * (uc_n - us) / us;

end
