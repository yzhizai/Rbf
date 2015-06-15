#this script is used to analyse the hub parameters
library(xlsx)
library(psych)
library(coin)

filename = 'betweenness_bin.xls'
mydata <- read.xlsx2(file = filename,sheetIndex = 1,
                     colClasses = c('character',rep('numeric',90)))

patt <- c('PCUN.L','PCUN.R','PUT.R','PUT.L','THA.R','THA.L','SMA.L','SOG.R','SOG.L',
          'CAU.L','CAU.R','HIP.R','ITG.R','IFGtri.L','SFGmed.L','INS.L','SFG.R',
          'SFGorb.L','SFGorb.R','PreCG.R','MOG.L','MTG.R','PoCG.R')

mydata_abs <- mydata[,patt]
mydata_abs$group <- factor(c(rep('control',10),rep('occult',6)))
myvars <- names(mydata_abs) %in% c('subj_ID','group')  #omit some non-numeric variables
results <- describeBy(mydata_abs[!myvars],group = mydata_abs$group)

list_control <- results[[1]]
list_occult <- results[[2]]

newdataframe <- data.frame(node = rownames(list_control),
                           control = paste(round(list_control$mean,digits = 2),
                                           '%+-%',round(list_control$sd,digits = 2)),
                           occult = paste(round(list_occult$mean,digits = 2),
                                          '%+-%',round(list_occult$sd,digits = 2)))