%% Starting point

%for time complexity: tic toc
%use the numerical differentiation in the file grad.m
% debugging is from MATLAB’s editor graphical interface
% use func.m to compute f(x) at a point x by func(x)

func = @(x)rosenbrock(x);
%x=[100 100];
%[-0.6995 -2.7896 -0.8703 -0.6975 -0.6963];
%[-0.7000 2.7892 -0.8709 0.6969 -0.6976];
%[-0.7000 2.7892 -0.8709 -0.6969 0.6976];
x = [11 11 4 4 8];
method='BFGS';
tol=0.1;
restart=0;
printout=1;


mu=100;

P= @(x) (sum(x.^2 ) -10)^2 + (x(2)*x(3)-5*x(4)*x(5))^2 + (x(1)^3 + x(3)^3 + 1)^2;

f = @(x) prod(x);

fun= @(x) f(x) + mu* P(x);

nonlinearmin(fun, x, method , tol , restart , printout)


xtra=10*7;
options = optimset('MaxIter', 200*length(x)*xtra); % Set the maximum number of iterations