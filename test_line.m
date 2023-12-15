%% test line search

a=[2, -2, 5, -5, 10, -10];

for i = a
    F=@(x) (1-10^i*x)^2;
    i
    [x, N] = lineSearch(F, 0.001)
end