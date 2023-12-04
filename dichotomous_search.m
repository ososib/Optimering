function [x N] = dichotomous_search(F, a, b, tol)
    % Initialize the variables
    delta = 10e-10; % Small delta for non-overlapping intervals
    N = 0; % Function evaluation counter
    X = []; % Matrix to store the interval updates
    
    while (b - a) > tol
        ml = (a + b)/2 - delta;
        mr = (a + b)/2 + delta;
        
        % Evaluate the function at ml and mr
        fml = F(ml);
        fmr = F(mr);
        
        % Update the counter
        N = N + 2;
        
        % Update the interval
        if fml < fmr
            b = mr;
        else
            a = ml;
        end

        % Store the current a, b, and (b-a)
        X = [X; a, b, b - a];
        
    end
    x=(a+b)/2;
end