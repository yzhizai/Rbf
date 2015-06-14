#this is a multiple parameters version
library(xlsx)
library(coin)

filename = 'globalVariables_sm.xls'

wb <- loadWorkbook(file = filename)
sheets <- getSheets(wb)
pval_1 <- numeric(0)
pval_2 <- numeric(0)
pval_3 <- numeric(0)
for (aa in 1:length(sheets)) {
  mydata <- read.xlsx2(file = filename,sheetIndex = aa,colClasses = c('character',rep('numeric',3)))
  mydata$group <- factor(c(rep('control',10),rep('occult',6)))
  results_1 <- oneway_test(clusterMean_bu~group,data = mydata,distribution = 'exact')
  results_2 <- oneway_test(charpath_B~group,data = mydata,distribution = 'exact')
  results_3 <- oneway_test(smallworldness_bu~group,data = mydata,distribution = 'exact')
  pval_1[aa] <- pvalue(results_1)
  pval_2[aa] <- pvalue(results_2)
  pval_3[aa] <- pvalue(results_3)
  print(aa)
}

cost <- seq(from = 0.1,to = 0.3,by = 0.01)

final_re <- data.frame(cost = cost, pval_1 = pval_1, pval_2 = pval_2, pval_3 = pval_3)
saveRDS(final_re,file = 'mypvals.rds')