#this script is used to analyse the hub parameters
#ATTENTION PLEASE!
# 1. add the column name for the first column
# 2. change the columns'name for their abbreviation.

library(xlsx)
library(psych)
library(coin)
library(dplyr)

myfunc <- function(x, group){
  temp <- data.frame(x = x, group = group)
  results <- oneway_test(x ~ group,data = temp,distribution = 'exact')
  pval <- pvalue(results)
  pval <- pval/2
  return(pval)
}

#read the data from .xlsx file.
filename_data = 'degrees_und.xlsx'

pvals = numeric(0)
mydata <- read.xlsx2(file = filename_data,sheetIndex = 2,
                     colClasses = c('character',rep('numeric',90)), stringsAsFactors = FALSE, startRow = 1, endRow = 26)

#read the nodes from the .xlsx file.
filename_node = 'hub_node.xlsx'
patt <- read.xlsx2(file = filename_node, sheetIndex = 1, colClasses = rep('character', 3), stringsAsFactors = FALSE)
patt <- unique(as.vector(sapply(patt, function(x) x)))


##select the aimed data.
mydata_abs <- select(mydata, one_of(patt))
mydata_abs$group <- factor(c(rep('control',11), rep('normal', 6), rep('occult',8)))
myvars <- names(mydata_abs) %in% c('subj_ID','group')  #omit some non-numeric variables
newdata <- mydata_abs[!myvars]
results <- describeBy(newdata,group = mydata_abs$group)

#devide the data into three groups
con2nor <- filter(mydata_abs, group == 'control' | group == 'normal')
con2occ <- filter(mydata_abs, group == 'control' | group == 'occult')
nor2occ <- filter(mydata_abs, group == 'normal'  | group == 'occult')


pval_con2nor <- lapply(con2nor[, -c(length(con2nor))], myfunc, group = con2nor$group)
pval_con2occ <- lapply(con2occ[, -c(length(con2occ))], myfunc, group = con2occ$group)
pval_nor2occ <- lapply(nor2occ[, -c(length(nor2occ))], myfunc, group = nor2occ$group)

pval_con2nor <- sapply(pval_con2nor, `[[`, 1)
pval_con2occ <- sapply(pval_con2occ, `[[`, 1)
pval_nor2occ <- sapply(pval_nor2occ, `[[`, 1)
# for(name in names(newdata)){
#   pval <- myfunc(mydata_abs,name)
#   pvals <- c(pvals,pval)
# }

list_control <- results[[1]]
list_normal  <- results[[2]]
list_occult  <- results[[3]]

newdataframe <- data.frame(node = rownames(list_control),
                           control = paste(round(list_control$mean,digits = 2),
                                           '%+-%',round(list_control$sd,digits = 2)),
                           normal = paste(round(list_normal$mean,digits = 2),
                                          '%+-%',round(list_normal$sd,digits = 2)),
                           occult = paste(round(list_occult$mean,digits = 2),
                                          '%+-%',round(list_occult$sd,digits = 2)),
                           pval_con2nor = as.vector(pval_con2nor), 
                           pval_con2occ = as.vector(pval_con2occ),
                           pval_nor2occ = as.vector(pval_nor2occ))


write.xlsx2(newdataframe,file = filename_data,sheetName = 'stat',append = TRUE,row.names = F)