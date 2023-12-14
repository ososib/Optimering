function [x_optimal, fval, iter, normg] = nonlinearmin(func, x0, method, tol, restart, printout)
    % Initialize variables
    if isrow(x0)
    % Convert row vector to column vector
        x = x0';
    else
        % If it's already a column vector or not a vector, leave it unchanged
        x = x0;
    end
    iter_restart = length(x0); %TODO set 
    maxIter = 10000; %TODO 
    H = eye(length(x0)); % Hessian approximation
    iter = 0;
    gradient =  grad(func, x);
    N_fun_eval=0;
    N_iter=0;

        % Print header if printout is enabled
    if printout
        fprintf('iteration\t x\t\t f(x)\t\t norm(grad)\t ls fun evals\t lambda\n');
    end



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
        [alpha N_fun_eval] = lineSearch(F, tol); % Sample parameters

        % Update variables
        s = alpha * d;
        x_new = x + s;
        grad_new = grad(func, x_new);
        q = grad_new - gradient;
        p=x_new-x;

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

        %TODO evaluera ej, få den från  metoden lineS

        fval=func(x);
        norm_grad=norm(gradient);

        
        % N_iter counter add +1 and fin fvals
        N_iter = N_iter +  1;
        % Print current iteration details if printout is enabled
        if printout && N_iter > 1
            fprintf('%d\t\t %.4f\t\t %.4f\t\t %.4f\t\t %d\t\t %.4f\n', N_iter, x(1), fval, norm(gradient), N_fun_eval, alpha);
            for i = 2:length(x)
                fprintf('\t\t %.4f\n', x(i));
            end
        end


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