function [p, v] = compute_prox(obj, x, gam)
    p = min(obj.hi, max(obj.lo, x));
    v = 0;
end
