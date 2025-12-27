widthvsothers = function(){
# Way too many plots for one function to create
# First ones are width vs one factor at every level of all other factors
    
cat("Width vs n_vary\n")
pdf("figwvsrqmcsize.pdf")

#fset = unique(valframe[,"Function"])
fset = c("jmp","knk","smo","fin")
dset = unique(valframe[,"Dimension"])
Nset = unique(valframe[,"N_vary"])

print(fset)
print(dset)
print(Nset)

valbet = valframe[valframe[,"CI.Method"]=="Betting",]
for( f in fset ){
  for( d in dset ){
    for( N in Nset ){
      vals = valbet
      vals = vals[vals[,"Function"]==f,]
      vals = vals[vals[,"N_vary"]==N,]
      vals = vals[vals[,"Dimension"]==d,]
      if( nrow(vals) > 0 ){
          plot( range(valbet[,"n_vary"]),c(min(valbet[,"Width"]),1),log="xy",type="n",
              xlab="RQMC sample size n",ylab="Width",
          main = paste("Betting: f =",f,"d =",d,"N =",N))
        points(vals[,"n_vary"],vals[,"Width"])
      }else{
        print(paste("No data for",f,d,N))
      }
    }
  }
}
dev.off()

cat("Width vs N_vary\n")

pdf("figwvspopsize.pdf")

#fset = unique(valframe[,"Function"])
fset = c("jmp","knk","smo","fin")
dset = unique(valframe[,"Dimension"])
nset = unique(valframe[,"n_vary"])

print(fset)
print(dset)
print(nset)

valbet = valframe[valframe[,"CI.Method"]=="Betting",]
for( f in fset ){
  for( d in dset ){
    for( n in nset ){
      vals = valbet
      vals = vals[vals[,"Function"]==f,]
      vals = vals[vals[,"n_vary"]==n,]
      vals = vals[vals[,"Dimension"]==d,]
      if( nrow(vals) > 0 ){
          plot( range(valbet[,"N_vary"]),c(min(valbet[,"Width"]),1),log="xy",type="n",
              xlab="Total sample size N",ylab="Width",
          main = paste("Betting: f =",f,"d =",d,"n =",n))
        points(vals[,"N_vary"],vals[,"Width"])
      }else{
        print(paste("No data for",f,d,N))
      }
    }
  }
}
dev.off()

cat("Width vs dimension\n")

pdf("figwvsdimension.pdf")

#fset = unique(valframe[,"Function"])
fset = c("jmp","knk","smo","fin")
nset = unique(valframe[,"n_vary"])
Nset = unique(valframe[,"N_vary"])

print(fset)
print(nset)
print(Nset)

valbet = valframe[valframe[,"CI.Method"]=="Betting",]
for( f in fset ){
  for( n in nset ){
    for( N in Nset ){
      vals = valbet
      vals = vals[vals[,"Function"]==f,]
      vals = vals[vals[,"n_vary"]==n,]
      vals = vals[vals[,"N_vary"]==N,]
      if( nrow(vals) > 0 ){
          plot( range(valbet[,"Dimension"]),c(min(valbet[,"Width"]),1),log="xy",type="n",
              xlab="Dimension d",ylab="Width",
          main = paste("Betting: f =",f,"n =",n,"N =",N))
        points(vals[,"Dimension"],vals[,"Width"])
      }else{
        print(paste("No data for",f,n,N))
      }
    }
  }
}
dev.off()


# Now lump together different dimensions

cat("Width vs n_vary, ignore dimension\n")

pdf("figwvsrqmcsizenodim.pdf")

#fset = unique(valframe[,"Function"])
fset = c("jmp","knk","smo","fin")
Nset = unique(valframe[,"N_vary"])

print(fset)
print(Nset)

valbet = valframe[valframe[,"CI.Method"]=="Betting",]
for( f in fset ){
  for( N in Nset ){
    vals = valbet
    vals = vals[vals[,"Function"]==f,]
    vals = vals[vals[,"N_vary"]==N,]
    if( nrow(vals) > 0 ){
        plot( range(valbet[,"n_vary"]),c(min(valbet[,"Width"]),1),log="xy",type="n",
            xlab="RQMC sample size n",ylab="Width",
        main = paste("Betting: f =",f,"N =",N,"all dims"))
      points(vals[,"n_vary"],vals[,"Width"])
    }else{
      print(paste("No data for",f,N))
    }
  }
}
dev.off()


# Now lump together different dimensions
# Just plot the means
# This is for the article
cat("Mean widths vs n_vary given f\n")

pdf("figmeanwidths.pdf",6,6)
par(mfrow=c(2,2))
par(oma=c(0,0,0,0))

valbet = valframe[valframe[,"CI.Method"]=="Betting",]

fset = c("jmp","knk","smo","fin")
Nset = unique(valframe[,"N_vary"])
nset = unique(valframe[,"n_vary"])
nn   = length(nset)

nameoff = function(f){
  if( f=="jmp" )return("Jump")
  if( f=="knk" )return("Kink")
  if( f=="smo" )return("Smooth")
  if( f=="fin" )return("Finance")
  return("???")        
}


for( f in fset ){
  plot( range(nset),#c(.002,1),
   range(valbet[,"Width"]),
  type="n",log="xy",
        xlab="RQMC sample size n",ylab="Average CI Width",main=paste("Ridge function:",nameoff(f)))
  for( N in Nset ){
    vals = valbet
    vals = vals[vals[,"Function"]==f,]
    vals = vals[vals[,"N_vary"]==N,]
    mwidth = sigwidth = nset*0
    reps = nrow(vals)/nn # includes all dimensions
    for( i in 1:nn ){
      widths = vals[vals[,"n_vary"]==nset[i],"Width"]
      mwidth[i]   = mean(widths)
      sigwidth[i] = sd(widths)
      points( nset,mwidth,type="o",pch=20,cex=.5)
      points( nset[which.min(mwidth)],min(mwidth),pch=20,col="red")
      points( rep(nset[i],2),mwidth[i]+2*c(-1,1)*sigwidth[i]/sqrt(reps),type="l",col="blue")
    }
  }
}


dev.off()

# For smooth function on [0,1]
# Save the widths
cat("smooth_1d\n")

pdf("figsmooth1d.pdf",6,6)
val1d = sm1[sm1$CI.Method=="Betting",]

Nset = unique(val1d[,"N_vary"])
nset = unique(val1d[,"n_vary"])
nn   = length(nset)
nN   = length(Nset)

plot( range(nset),range(val1d[,"Width"]),type="n",log="xy",
        xlab="RQMC sample size n",ylab="Average CI Width",main=paste("Smooth 1d"))

smooth1dwidths = matrix(0,nN,nn)
rownames(smooth1dwidths) = Nset
colnames(smooth1dwidths) = nset

for( j in 1:nN ){
  N = Nset[j]
  print(N)
  vals = val1d
  vals = vals[vals[,"N_vary"]==N,]
  mwidth = sigwidth = nset*0
  for( i in 1:nn ){
    widths = vals[vals[,"n_vary"]==nset[i],"Width"]
    mwidth[i]   = mean(widths)
    sigwidth[i] = sd(widths)
  }
  smooth1dwidths[j,] = mwidth  
  points( nset,mwidth,type="o",pch=20,cex=.5)
  points( nset[which.min(mwidth)],min(mwidth),pch=20,col="red")
}

smooth1dwidths <<- smooth1dwidths

dev.off()


# For discontinuous function on [0,1]
# Save the widths
cat("nonsmooth_1d\n")
pdf("fignonsmooth1d.pdf",6,6)

ns1d = dis1[dis1$CI.Method=="Betting",]

Nset = unique(ns1d[,"N_vary"])
nset = unique(ns1d[,"n_vary"])
nn   = length(nset)
nN   = length(Nset)

plot( range(nset),range(ns1d[,"Width"]),type="n",log="xy",
        xlab="RQMC sample size n",ylab="Average CI Width",main=paste("Discontinuous 1d"))

disco1dwidths = matrix(0,nN,nn)
rownames(disco1dwidths) = Nset
colnames(disco1dwidths) = nset

for( j in 1:nN ){
  N = Nset[j]
  print(N)
  vals = ns1d
  vals = vals[vals[,"N_vary"]==N,]
  mwidth = sigwidth = nset*0
  for( i in 1:nn ){
    widths = vals[vals[,"n_vary"]==nset[i],"Width"]
    mwidth[i]   = mean(widths)
    sigwidth[i] = sd(widths)
  }
  disco1dwidths[j,] = mwidth  
  points( nset,mwidth,type="o",pch=20,cex=.5)
  points( nset[which.min(mwidth)],min(mwidth),pch=20,col="red")
}

disco1dwidths <<- disco1dwidths

dev.off()
}

dolm = function(){
# Do the linear model computations that show
# the dimension doesn't matter

par(mfrow=c(1,2))
valbet = valframe[valframe[,"CI.Method"]=="Betting",]
keep = valbet[,"Function"] %in% c("jmp","knk","smo","fin")
valbet = valbet[keep,]

print(names(valbet))
print(var(log(valbet[,"Width"])))

thelm = lm( log(Width) ~ as.factor(Function) + as.factor(Dimension) + as.factor(N_vary) + as.factor(n_vary),data=valbet)
print(summary(thelm))    
qqnorm(thelm$residuals)

thelmnodim = lm( log(Width) ~ as.factor(Function) + as.factor(N_vary) + as.factor(n_vary),data=valbet)
print(summary(thelmnodim))    
qqnorm(thelmnodim$residuals)

thelmnodimnofun = lm( log(Width) ~ as.factor(N_vary) + as.factor(n_vary),data=valbet)
print(summary(thelmnodimnofun))    
qqnorm(thelmnodimnofun$residuals)

thelmnodimnofuninter = lm( log(Width) ~ as.factor(N_vary) * as.factor(n_vary),data=valbet)
print(summary(thelmnodimnofuninter))    
qqnorm(thelmnodimnofuninter$residuals)

thelmnotlog = lm( Width ~ as.factor(Function) + as.factor(Dimension) + as.factor(N_vary) + as.factor(n_vary),data=valbet)
print(summary(thelmnotlog))    
qqnorm(thelmnotlog$residuals)
}



maurerpontilciwidth = function(sigmasq,m,alpha=.05){
# Width of a Bennett interval
  2*sqrt(2*sigmasq*log(2/alpha)/m)+log(2/alpha)/(3*m)
}

rqmcbennettwidth = function(n,N,sigmasq0,theta,alpha=.05){
  R = N/n
  maurerpontilciwidth(sigmasq = sigmasq0/(n^theta),m=R,alpha=alpha)
}

widthsxexpxbye = function(n,N){
  rqmcbennettwidth(n,N,sigmasq0=(5-exp(-2))/48,theta=3)
}

widthislessthanonethird = function(n,N){
  rqmcbennettwidth(n,N,sigmasq0=2/9,theta=2)
}


comparewidthstoEB = function(){
# Compare betting widths to EB from Bennett's formula
    
pdf("figwidthstoeb.pdf",6.8)
par(mfrow=c(2,1))
par(oma=c(0,0,0,0))
par(mar=c(4,4,3,1))

smooth1dEB = smooth1dwidths*0
nset = as.integer(colnames(smooth1dEB))
nn   = length(nset)

for( i in 1:nrow(smooth1dEB) ){
  N = as.integer(rownames(smooth1dEB)[i])
#  smooth1dEB[i,] = widthsxexpxbye(nset,N)
  for( j in 1:nn )
    smooth1dEB[i,j] = maurerpontilciwidth(sigmasq=rqmcvar(nset[j]),m=N/nset[j])
}

print(smooth1dEB)
ratio = smooth1dwidths/smooth1dEB
print(ratio)

# was 1.5*max(nset) to put numbers on right hand side (they overlap badly)
plot(c(min(nset),max(nset)),range(ratio),log="x",type="n",
  xlab="RQMC sample size n",
  ylab="Betting width / Bennett",    
  main="f(x) = x*exp(x-1)")

# Fiddle with display heights for text
#hts = ratio[,ncol(ratio)]
#hts = hts-.1
#hts[4] = hts[4]+.2
#hts[5] = hts[5]+.1
for( i in 1:nrow(ratio)){
  lines(nset,ratio[i,],type="o",pch=20,col=i)
#  text(64,hts[i],rownames(ratio)[i],pos=4,cex=.9)
}
legend("topleft",paste("N =",as.character(4^(4:8))),col=1:5,lty=1,pch=20)

disc1dEB = disco1dwidths*0
for( i in 1:nrow(disc1dEB) ){
  N = as.integer(rownames(disc1dEB)[i])
  disc1dEB[i,] = widthislessthanonethird(nset,N)
}

lines( range(nset),rep(1,2),col="gray20")
print(disc1dEB)
ratio = disco1dwidths/disc1dEB
print(ratio)

plot(c(min(nset),max(nset)),range(ratio),log="x",type="n",
  xlab="RQMC sample size n",
  ylab="Betting width / Bennett",    
  main="f(x) = 1{ x<1/3 }")

hts = ratio[,ncol(ratio)]
hts[2] = hts[2]-.05
for( i in 1:nrow(ratio)){
  lines(nset,ratio[i,],type="o",pch=20,col=i)
#  text(64,hts[i],rownames(ratio)[i],pos=4,cex=.9)
}
legend("topleft",paste("N =",as.character(4^(4:8))),col=1:5,lty=1,pch=20)
lines( range(nset),rep(1,2),col="gray20")

dev.off()


}













    






    
