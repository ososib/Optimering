function x = lineSearch(F,tol)


b = 2;
k_max=10000;
alpha=2;

b = bracketing(b,F,alpha,k_max);

x = dichotomous_search(F, 0, b, tol);
if isnan(F(b)) || F(b)>F(0)
    error('Bad job of the line search!')
end
end