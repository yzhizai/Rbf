#this is a multiple parameters version
library(xlsx)
library(coin)
library(tcltk)

filename = choose.files(getwd(), 'choose the small world files')

wb <- loadWorkbook(file = filename)
sheets <- getSheets(wb)
pval_1 <- numeric(0)
pval_2 <- numeric(0)
pval_3 <- numeric(0)

pb <- tkProgressBar(min = 0, max = 100, initial = 0)
for (aa in 1:length(sheets)) {
  mydata <- read.xlsx2(file = filename,sheetIndex = aa,
                       colClasses = c('character',rep('numeric',3)))
  mydata$group <- factor(c(rep('control',11),rep('occult',8)))
  mydata$clusterMean_bu <- as.numeric(mydata$clusterMean_bu)
  mydata$charpath_B <- as.numeric(mydata$charpath_B)
  mydata$smallworldness_bu <- as.numeric(mydata$smallworldness_bu)
  results_1 <- oneway_test(clusterMean_bu~group,data = mydata,
                           distribution = 'exact')
  results_2 <- oneway_test(charpath_B~group,data = mydata,
                           distribution = 'exact')
  results_3 <- oneway_test(smallworldness_bu~group,data = mydata,
                           distribution = 'exact')
  pval_1[aa] <- pvalue(results_1)
  pval_2[aa] <- pvalue(results_2)
  pval_3[aa] <- pvalue(results_3)
  setTkProgressBar(pb, round(aa/length(sheets)*100))
}

close(pb)
cost <- seq(from = 0.1,to = 0.3,by = 0.01)

final_re2 <- data.frame(cost = cost, pval_1 = pval_1, pval_2 = pval_2, 
                       pval_3 = pval_3)