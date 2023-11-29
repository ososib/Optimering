function [x_optimal, fval, iter, normg] = nonlinearmin(func, x0, method, tol, restart, printout)
    % Initialize variables
    iter_restart = length(x0); %TODO set 
    maxIter = 10000; %TODO 
    x = x0';
    H = eye(length(x0)); % Hessian approximation
    iter = 0;
    gradient = grad(func, x);

    % Main loop
    while true
        % Check convergence
        if norm(gradient) < tol
            break;
        end

        % Determine search direction
        d = -H * gradient;

        % Line search
        F =@(lambda) func(x+lambda*d);
        alpha = lineSearch(F, tol/100); % Sample parameters

        % Update variables
        s = alpha * d;
        x_new = x + s;
        grad_new = grad(func, x_new);
        q = grad_new - gradient;
        p=x-x_new;

        % Update Hessian approximation
        if strcmpi(method, 'BFGS')

            test = 1/(p'*q);
            test1 = (1+(q'*H*q)/(p'*q));
            test2 = (p*p');
            test3= H*(q*p');
            test4= p*q'*H; 

            H = H + 1/(p'*q)*((1+(q'*H*q)/(p'*q))*(p*p') - H*q*p' - p*q'*H);
        elseif strcmpi(method, 'DFP')
            H = H + (p*p')/(p'*q) - ((H*(q*q')*H)/(q'*H*q));
        end

        % Update for next iteration
        x = x_new;
        gradient = grad_new;
        iter = iter + 1;

        % Check for max iterations
        if iter >= maxIter
            break;
        end
        
        % Restart logic
        if restart && mod(iter, iter_restart) == 0 %|| (grad' * p) <= 0
            H = eye(length(x)); % R eset Hessian approximation
        end

    end

    % Prepare output
    x_optimal = x
    iter
    fval = func(x_optimal);
    normg = norm(gradient);
end