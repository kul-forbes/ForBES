function [g, v, H] = compute_gradient(obj, x)
    g = obj.w .* x;
    v = 0.5*(x(:)'*g(:));
    if nargout >= 3
        H = @(x) obj.w .* x;
    end
end
