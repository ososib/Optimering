function b = bracketing(b,F,alpha,k_max)


while F(b)>F(0)
    b=b/alpha;
end
k=0;
while F(b)<F(0) && k < k_max
    k=k+1;
    b=b*alpha;
end
if k==k_max
    error('minimizer may not exist')
 
end