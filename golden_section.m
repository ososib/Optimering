function [x, fval, N] = golden_section(F, a, b, tol)
    % Initialize the variables
    N = 0; % Function evaluation counter
    X = []; % Matrix to store the interval updates
    tau = (sqrt(5) - 1) / 2; % Golden ratio constant

    % Calculate the initial points
    x1 = a + (1 - tau) * (b - a);
    x2 = a + tau * (b - a);
    % Evaluate the function at x1 and x2
    f1 = F(x1);
    f2 = F(x2);

    % Update the counter two times beacuse call function two time lol
    N = N + 2;

    while (b - a) > tol
        % now only have to call them once each iteration=good
        if f1 < f2
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = a + (1 - tau) * (b - a);
            f1 = F(x1);
        else
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = a + tau * (b - a);
            f2 = F(x2);
        end

        % Update the counter
        N = N + 1;

        % Store the current a, b, and (b-a)
        X = [X; a, b, b - a];
        
    end
    x = (a+b)/2;
    fval=F(x); 
end
