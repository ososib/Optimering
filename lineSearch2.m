function alpha = lineSearch2(func, x, d, alpha_init, rho, c)
    % Initialize step size
    alpha = alpha_init;
    % Calculate the initial function value and gradient
    f_x = func(x);
    grad_f_x = numericalGradient(func, x);

    % Armijo rule: iterate until the condition is met
    while func(x + alpha * d) > f_x + c * alpha * (grad_f_x' * d)
        % Reduce alpha by a factor of rho
        alpha = rho * alpha;
    end
end

function grad = numericalGradient(func, x)
    % Numerical gradient calculation
    epsilon = 1e-6;
    grad = zeros(size(x));
    fx = func(x);
    for i = 1:length(x)
        x1 = x;
        x1(i) = x1(i) + epsilon;
        grad(i) = (func(x1) - fx) / epsilon;
    end
end