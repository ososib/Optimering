%% Starting point

%for time complexity: tic toc
%use the numerical differentiation in the file grad.m
% debugging is from MATLAB’s editor graphical interface
% use func.m to compute f(x) at a point x by func(x)
F = @(lambda) f(x+lambda*d);