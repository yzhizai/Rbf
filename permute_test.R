#this is a single parameters version
library(xlsx)
library(coin)

filename = 'globalVariables.xls'

wb <- loadWorkbook(file = filename)
sheets <- getSheets(wb)
pval <- numeric(0)
for (aa in 1:length(sheets)) {
  mydata <- read.xlsx2(file = filename,sheetIndex = aa,colClasses = c('character','numeric'))
  mydata_tmp <- mydata
  mydata_tmp$efficiency_bin <- as.numeric(mydata$efficiency_bin)
  mydata_tmp$group <- factor(c(rep('control',10),rep('occult',6)))
  results <- oneway_test(efficiency_bin~group,data = mydata_tmp,distribution = 'exact')
  pval[aa] <- pvalue(results)
  print(aa)
}

cost <- seq(from = 0.1,to = 0.3,by = 0.01)

final_re <- data.frame(cost = cost, pval = pval)
saveRDS(final_re,file = 'mypval.rds')