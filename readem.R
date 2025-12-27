setup = function(){

readem()
vals2frame()
makedsets()

}

#readem = function(fn="bettingdata.tsv"){
readem = function(fn="qmc_combined_results.csv"){
    
#vals = read.csv(fn,head=TRUE,sep="\t")
vals = read.csv(fn,head=TRUE,sep=",")

vals[vals[,"Function"]=="smooth_1d","Dimension"]=1
vals[vals[,"Function"]=="discontinuous_1d","Dimension"]=1
vals[vals[,"Function"]=="discontinuous_2d","Dimension"]=2

allvals <<- vals
}

vals2frame = function(vals=allvals){
    
tags = vals[,1:5]      # N_vary n_vary Function Dimension CI.Method
wids = vals[,-c(1:5)]

M = ncol(wids)
     
initdf = as.data.frame( vals[1,1:7],drop=FALSE)
colnames(initdf)[6] = "Width"
    
# ad hoc way to get replicate number in
colnames(initdf)[7] = "Rep"
initdf[1,7] = 1

print(initdf)
ind = 1
for( i in 1:nrow(tags) ){
  cat(".")
  for( j in 1:M ){
    initdf[ind,1:5] = tags[i,1:5]
    initdf[ind,6]   = wids[i,j]
    initdf[ind,7]   = j
    ind = ind+1
  }
}
cat("\n")    

valframe <<- initdf
}


makedsets = function(){
    
knk <<- valframe[valframe[,"Function"]=="knk",]
jmp <<- valframe[valframe[,"Function"]=="jmp",]
smo <<- valframe[valframe[,"Function"]=="smo",]
fin <<- valframe[valframe[,"Function"]=="fin",]

knkb <<- knk[knk[,"CI.Method"]=="Betting",]
jmpb <<- jmp[jmp[,"CI.Method"]=="Betting",]
smob <<- jmp[jmp[,"CI.Method"]=="Betting",]
finb <<- jmp[jmp[,"CI.Method"]=="Betting",]


sm1  <<- valframe[valframe[,"Function"]=="smooth_1d",]
dis1 <<- valframe[valframe[,"Function"]=="discontinuous_1d",]
dis2 <<- valframe[valframe[,"Function"]=="discontinuous_2d",]

N08 <<- valframe[valframe[,"N_vary"]==256,]
N10 <<- valframe[valframe[,"N_vary"]==1024,]
N12 <<- valframe[valframe[,"N_vary"]==4096,]
N14 <<- valframe[valframe[,"N_vary"]==16384,]
N16 <<- valframe[valframe[,"N_vary"]==65536,]


}

    
