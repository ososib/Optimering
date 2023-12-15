%% Test
func = @(x) rosenbrock(x);
%x = rand(2,1)*20
x= [200, 500];
nonlinearmin(func, x, 'DFP', 0.0001, 1, 1)

%% test shit penalty inshalla
[x_opt, f_opt] = solvePenaltyProblem([-2 2 2 -1 -1], 'BFGS', 1e-4, 1, 1);


function [x_opt, f_opt] = solvePenaltyProblem(initialPoint, method, tol, restart, printout)
    % Set initial penalty parameter and scaling factor for increasing it
    penaltyParam = 1;
    scaleFactor = 10;

    % Define tolerance for constraint satisfaction
    constraintTol = 1e-4;

    % Initialize variables
    x_current = initialPoint;
    penaltySatisfied = false;

    while ~penaltySatisfied
        % Define the penalty function
        penaltyFunc = @(x) objectiveWithPenalty(x, penaltyParam);

        % Use nonlinearmin to minimize the penalty function
        [x_opt, ~, ~, ~] = nonlinearmin(penaltyFunc, x_current, method, tol, restart, printout);

        % Check if the constraints are satisfied to within the tolerance
        if checkConstraints(x_opt) < constraintTol
            penaltySatisfied = true;
        else
            % Increase the penalty parameter and update current point
            penaltyParam = penaltyParam * scaleFactor;
            x_current = x_opt;
        end
    end

    % Final optimal function value
    f_opt = exp(prod(x_opt));
end

function f = objectiveWithPenalty(x, penaltyParam)
    % Original objective function
    f = exp(prod(x));

    % Add penalty for each constraint violation
    f = f + penaltyParam * (sum(x.^2) - 10)^2; % Constraint 1
    f = f + penaltyParam * (x(2)*x(3) - 5*x(4)*x(5))^2; % Constraint 2
    f = f + penaltyParam * (x(3)^1 + x(3)^3 + 1)^2; % Constraint 3
end

function constraintViolation = checkConstraints(x)
    % Evaluate the magnitude of constraint violations
    c1 = (sum(x.^2) - 10)^2;
    c2 = (x(2)*x(3) - 5*x(4)*x(5))^2;
    c3 = (x(3)^1 + x(3)^3 + 1)^2;

    % Sum of squared constraint violations
    constraintViolation = c1 + c2 + c3;
end


