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
  return(pval)
}

#read the data from .xlsx file.
filename_data = choose.files(getwd(), 'choose the hub related para file')

pvals = numeric(0)
mydata <- read.xlsx2(file = filename_data,sheetIndex = 1,
                     colClasses = c('character',rep('numeric',90)), stringsAsFactors = FALSE, startRow = 1, endRow = 26)

#read the nodes from the .xlsx file.
filename_node = choose.files(getwd(), 'the hub node file')
patt <- read.xlsx2(file = filename_node, sheetIndex = 5, colClasses = 'character', stringsAsFactors = FALSE)
patt <- unique(patt$node)


##select the aimed data.
mydata_abs <- select(mydata, one_of(patt))
mydata_abs$group <- factor(c(rep('control',11), rep('occult',8)))
myvars <- names(mydata_abs) %in% c('subj_ID','group')  #omit some non-numeric variables
newdata <- mydata_abs[!myvars]
results <- describeBy(newdata,group = mydata_abs$group)

#devide the data into three groups
con2occ <- mydata_abs


pval_con2occ <- lapply(con2occ[, -c(length(con2occ))], myfunc, group = con2occ$group)


pval_con2occ <- sapply(pval_con2occ, `[[`, 1)
# for(name in names(newdata)){
#   pval <- myfunc(mydata_abs,name)
#   pvals <- c(pvals,pval)
# }

list_control <- results[[1]]
list_occult  <- results[[2]]

newdataframe <- data.frame(node = rownames(list_control),
                           control = paste(round(list_control$mean,digits = 2),
                                           '%+-%',round(list_control$sd,digits = 2)),
                           occult = paste(round(list_occult$mean,digits = 2),
                                          '%+-%',round(list_occult$sd,digits = 2)),
                           pval_con2occ = as.vector(pval_con2occ))


write.xlsx2(newdataframe,file = filename_data,sheetName = 'stat',append = TRUE,row.names = F)