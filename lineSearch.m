function [x, N] = lineSearch(F,tol)


b = 2;
k_max=10000;
alpha=2;

b = bracketing(b,F,alpha,k_max);

[x, N] = golden_section(F, 0, b, tol);
if isnan(F(x)) || F(x)>F(0)
    error('Bad job of the line search!')
end
end