rqmcvar = function(n,thresh=4096,print=FALSE,skipthresh=TRUE){
# Compute variance of RQMC estimate with n = 2^m points 
# and f(x) = x*exp(x-1) 
#  
# It is very close to (5-exp(-2))/48n^3 for n >= 16 or so
# The exact formula can go negative for extremely large n due to cancellations
#
# Use asymptotic value if n > thresh
# print both if print = TRUE
# skip computing the exact value if skipthresh = TRUE and n > thresh
# don't skip if you want to print!
#
f1 = function(x){exp(x-1)*(x-1)}
f2 = function(x){exp(2*x-2)*(2*x^2-2*x+1)/4}


ansasympt = (5-exp(-2))/(48*n^3)

if( n <= thresh | !skipthresh ){
  b = (1:n)/n
  a = b-1/n

  theta = n*(f2(b)-f2(a))
  mu    = n*(f1(b)-f1(a))
  ansexact = (sum(theta)-sum(mu^2))/n^2
}

if(print)
  cat(ansexact,ansasympt,ansexact/ansasympt,"\n")

if( n <= thresh )
  ans = ansexact
else
  ans = ansasympt
ans
}
