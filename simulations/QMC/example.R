width = function(n,N,alpha=0.05,theta=3,sigmasq0=1/12){
# defaults are for f(x) = x    
# get Bernstein half-width
# and double it

R = N/n
sigmasq = sigmasq0 / n^theta

term1 = sqrt(2*sigmasq*log(2/alpha)/R)
term2 = log(2/alpha)/(3*R)

2*(term1+term2)
}

widthraw = function(n,N,sigmasq,alpha=0.05){
# like width but with actual variance not asymptotic

R = N/n

term1 = sqrt(2*sigmasq*log(2/alpha)/R)
term2 = log(2/alpha)/(3*R)

2*(term1+term2)
}



bestn = function(N,alpha=0.05,theta=3,sigmasq0=1/12){
    
nset = 2^(0:ceiling(log2(N)))
nset = nset[nset<=N]
nn   = length(nset)

widths = nset*0
for( j in 1:nn )
  widths[j] = width(nset[j],N,alpha,theta,sigmasq0)

best = which.min(widths)
c( nset[best],widths[best])
}

trimbestn = function(alpha=0.05,theta=3,sigmasq0=1/12,keepones = FALSE){

vals = matrix(0,31,5)

thepow = 1/2-(1-theta)/(2*theta+2)
print(thepow)

if( theta == 3 )
  thepowstr = "3/4"
else if( theta == 2 )
  thepowstr = "2/3"
else
  thepowstr = as.character(thepow)
colnames(vals) = c("m","N","n","w",paste("N^",thepowstr,"w ",sep=""))

for( i in 1:nrow(vals) ){
  N = 2^(i-1)
  bn = bestn(N,alpha,theta,sigmasq0) # n and width(n)
  vals[i,] = c(i-1,N,bn,N^thepow*bn[2])
}

nn = nrow(vals)
keep = rep(TRUE,nn)
for( j in 2:nn )
  if(vals[j,3]==vals[j-1,3]) 
    keep[j] = FALSE

if( keepones )
  for( j in 2:nn )
    if( vals[j,3]==1 )
      keep[j] = TRUE
vals[keep,]
   
}

xvsonethird = function(){
# case where f(x) = 1{ x <= 1/3 }
ans = trimbestn(theta=2,sigmasq0=(2/3)*(1/3))
ans[,4] = signif(ans[,4],3)
ans
}


xexpxbyexpone = function(){                                        
# case where f(x) = x*exp(x-1)
#ans = trimbestn(theta=3,sigmasq0 = (5/4 - 1/(4*exp(1)^2))/12)
ans = trimbestn(theta=3,sigmasq0 = 1/12)
#ans[,4] = signif(ans[,4],3)
ans
    
}

formattrimmed = function(vals){
vals[,"w"] = signif(vals[,"w"],3)
vals
}


sigmasq0fromomega = function(omega){
# Integral of f'(x)^2 over 0 <= x <= 1
# for f(x) = (1+sin(2*pi*omega*x))/2

ans = sin(4*pi*omega)/(pi*omega)
ans = ans+4
ans = ans/8
ans = ans * pi^2 * omega^2
ans = ans/12
ans
}

nstar = function(theta, sigmasq0,N,alpha=0.05){

num = 9*(theta-1)^2*sigmasq0*N
den = 2*log(2/alpha)

ans = (num/den)^(1/(theta+1))

ans
}

                                        
# Modify trimbestn to use the actual non-asymptotic variances for f(x) = x * exp(x-1)
trimbestnxexpxminusone = function(alpha=0.05,keepones = FALSE){

vals = matrix(0,31,5)

thepow = 1/2-(1-3)/(2*3+2)
print(thepow)

thepowstr = "3/4"
colnames(vals) = c("m","N","n","w",paste("N^",thepowstr,"w ",sep=""))

for( i in 1:nrow(vals) ){
  N = 2^(i-1)
  bestn  = 1
  bestwidth = widthraw(1,N,rqmcvar(1))
  for( j in 0:(i-1) ){
    n = 2^j
#    cat(N,n,"\n")
    widthn = widthraw(n,N,rqmcvar(n))
    if( widthn < bestwidth ){
      bestn = n
      bestwidth = widthn
    }
  }
  vals[i,] = c(i-1,N,bestn,bestwidth,N^thepow*bestwidth)
}

nn = nrow(vals)
keep = rep(TRUE,nn)
for( j in 2:nn )
  if(vals[j,3]==vals[j-1,3]) 
    keep[j] = FALSE

if( keepones )
  for( j in 2:nn )
    if( vals[j,3]==1 )
      keep[j] = TRUE
vals[keep,]
   
}

table3 = function(){
# Make values that go into Table 3 of the paper
    
ans = matrix(0,5,5)
colnames(ans) = c("N","nstar x<1/3","nopt n<1/3","nstar xexpxmone","nopt xexpxmone")

smoovals = allvals[allvals[,"Function"]=="smooth_1d",]
smoovals = smoovals[smoovals[,"CI.Method"]=="Betting",]
smoovals[,"avg"] = apply(smoovals[,6:25],1,mean)
smoovals = smoovals[,-(6:25)]

discvals = allvals[allvals[,"Function"]=="discontinuous_1d",]
discvals = discvals[discvals[,"CI.Method"]=="Betting",]
discvals[,"avg"] = apply(discvals[,6:25],1,mean)
discvals = discvals[,-(6:25)]


ans[,1] = 2^c(8,10,12,14,16)
for( i in 1:5 ){
  ans[i,2] = bestn(ans[i,1],theta=2,sigmasq0=2/9)[1]
  ans[i,4] = bestn(ans[i,1])[1]
  keep = smoovals[,"N_vary"]==ans[i,"N"]
  ans[i,5] = smoovals[,"n_vary"][which.min(smoovals[keep,"avg"])]
  ans[i,3] = smoovals[,"n_vary"][which.min(discvals[keep,"avg"])]
}

ans
}
