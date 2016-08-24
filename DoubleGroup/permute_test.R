#this is a single parameters version
library(xlsx)
library(coin)
library(xlsx)

filename = choose.files(getwd())

wb <- loadWorkbook(file = filename)
sheets <- getSheets(wb)
pval <- numeric(0)

pb <- tkProgressBar('R progress bar', min = 0, max = 100)
for (aa in 1:length(sheets)) {
  mydata <- read.xlsx2(file = filename,sheetIndex = aa,
                       colClasses = c('character','numeric'))
  mydata_tmp <- mydata
  mydata_tmp$efficiency_bin <- as.numeric(mydata$efficiency_bin)
  mydata_tmp$group <- factor(c(rep('control',11),rep('occult',8)))
  results <- oneway_test(efficiency_bin~group,data = mydata_tmp,
                         distribution = 'exact')
  pval[aa] <- pvalue(results)
  setTkProgressBar(pb, round(aa/length(sheets)*100))
}
close(pb)
cost <- seq(from = 0.1,to = 0.3,by = 0.01)

final_re1 <- data.frame(cost = cost, pval = pval)
