%% Starting point

%for time complexity: tic toc
%use the numerical differentiation in the file grad.m
% debugging is from MATLAB’s editor graphical interface
% use func.m to compute f(x) at a point x by func(x)

func = @(x)rosenbrock(x);
x=[-2 2];
%x = [-2 2 2 -1 -1];
method='BFGS';
tol=0.01;
restart=0;
printout=1;


mu=1;

P= @(x) (sum(x.^2 ) -10)^2 + (x(2)*x(3)-5*x(4)*x(5))^2 + (x(1)^3 + x(3)^3 + 1)^2;

f = @(x) exp(prod(x));

fun= @(x) f(x) + mu* P(x);

nonlinearmin(func, x, method , tol , restart , printout)