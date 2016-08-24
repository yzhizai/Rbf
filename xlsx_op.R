library(xlsx)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(coin)

filename = 'globalVariables_GE.xlsx'

#according to the preknowledge to set the sheetName.
sheetName <- as.character(seq(0.1, 0.3, by = 0.01))
sheetName <- as.list(sheetName)

sheetIndex <- c(1:length(sheetName)) + 1

#read data from the xlsx file.
dataSet <- lapply(sheetIndex, read.xlsx2, file = filename, colClasses = 'numeric')

#########################################################################
#function to reform the data, and calculate the pval for each sheet
#########################################################################
pValCalc <- function(sheetData) {
  
  group <- c(rep('control',11), rep('normal', 6), rep('occult',8)) #group
  sheetData$group <- factor(group) #convert to the factor type, otherwise, it cannot be dealed by oneway_test.
  con2nor <- filter(sheetData, group == 'control' | group == 'normal')
  con2occ <- filter(sheetData, group == 'control' | group == 'occult')
  nor2occ <- filter(sheetData, group == 'normal'  | group == 'occult')
  
  ptest_con2nor <- pvalue(oneway_test(efficiency_bin ~ group, data = con2nor, distribution = 'exact'))/2
  ptest_con2occ <- pvalue(oneway_test(efficiency_bin ~ group, data = con2occ, distribution = 'exact'))/2
  ptest_nor2occ <- pvalue(oneway_test(efficiency_bin ~ group, data = nor2occ, distribution = 'exact'))/2
  
  #to store the pval, when to use, just extract the first 3 value.
  sheetData$pval <- c(ptest_con2nor, ptest_con2occ, ptest_nor2occ, rep(1, nrow(sheetData) - 3))
  sheetData
}

#reform the data.
newDataSet <- lapply(dataSet, pValCalc)

#generate a 2-D array including the pval of the 3 ttest.
pVal <- sapply(newDataSet, function(x) {temp <-x$pval[1:3]; temp})

#to obtain the mean data to plot the curve.
meanVal <- sapply(newDataSet, function(x) {temp <- x %>% group_by(group) %>% summarise(mean = mean(efficiency_bin)); temp$mean})
MeanDraw <- data.frame(network_cost = seq(0.1, 0.3, by = 0.01), value = as.vector(t(meanVal)), 
                     Group = c(rep('control', 21), rep('normal', 21), rep('occult', 21)))

#plot about all threshold's mean curve figure.
curveplot_1 <- ggplot(MeanDraw,aes(x = network_cost,y = value,color = Group,shape = Group))
curveplot_1 <- curveplot_1 + geom_point(size = 3) + geom_line()
curveplot_1 <- curveplot_1 + ylab('')

grid.arrange(curveplot_1, nrow = 1)