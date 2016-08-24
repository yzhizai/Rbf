library(xlsx)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(coin)

filename = 'globalVariables_SW.xlsx'

#according to the preknowledge to set the sheetName.
sheetName <- as.character(seq(0.1, 0.3, by = 0.01))
sheetName <- as.list(sheetName)

sheetIndex <- c(1:length(sheetName)) + 1

#read data from the xlsx file.
dataSet <- lapply(sheetIndex, read.xlsx2, file = filename, colClasses = rep('numeric',3))

#########################################################################
#function to reform the data, and calculate the pval for each sheet
#########################################################################
pValCalc <- function(sheetData) {
  
  group <- c(rep('control',11), rep('normal', 6), rep('occult',8)) #group
  sheetData$group <- factor(group) #convert to the factor type, otherwise, it cannot be dealed by oneway_test.
  con2nor <- filter(sheetData, group == 'control' | group == 'normal')
  con2occ <- filter(sheetData, group == 'control' | group == 'occult')
  nor2occ <- filter(sheetData, group == 'normal'  | group == 'occult')
  
  
  func2variable <- function(tempData) {
    pTestVal <- list()
    for (aa in c(1:3)) {
      ptest <- pvalue(oneway_test(as.formula(paste(names(tempData)[aa],'~group')), data = tempData, 
                                          distribution = 'exact'))/2
      pTestVal[[aa]] <- ptest
    }
    
    pTestVal
  }
  #return a list of 3 variables' ttest, list[[1]] is the CC ,list[[2]] is the CL, list[[3]] is the SW
  ptest_con2nor <- func2variable(con2nor)
  ptest_con2occ <- func2variable(con2occ)
  ptest_nor2occ <- func2variable(nor2occ)
  
  #to store the pval, when to use, just extract the first 6 value.
  sheetData$pval <- c(ptest_con2nor[[1]], ptest_con2nor[[2]], ptest_con2nor[[3]], 
                      ptest_con2occ[[1]], ptest_con2occ[[2]], ptest_con2occ[[3]],
                      ptest_nor2occ[[1]], ptest_nor2occ[[2]], ptest_nor2occ[[3]],
                      rep(1, nrow(sheetData) - 9))
  sheetData
}

#reform the data.
newDataSet <- lapply(dataSet, pValCalc)

#generate a 2-D array including the pval of the 3 ttest.
pVal <- sapply(newDataSet, function(x) {temp <-x$pval[1:6]; temp})

#to obtain the mean data to plot the curve.
meanVal <- lapply(newDataSet, function(x) {temp <- x %>% group_by(group) %>% 
  summarise(mean_CC = mean(clusterMean_bu),
            mean_CL = mean(charpath_B),
            mean_SW = mean(smallworldness_bu));
            list(mean_CC = temp$mean_CC, 
                 mean_CL = temp$mean_CL,
                 mean_SW = temp$mean_SW)})
meanval_CC <- sapply(meanVal, function(x) x$mean_CC)
meanval_CL <- sapply(meanVal, function(x) x$mean_CL)
meanval_SW <- sapply(meanVal, function(x) x$mean_SW)

###################################################################
#function renderFig is used to draw the fig.
###################################################################
renderFig <- function(tempData) {
  MeanDraw <- data.frame(network_cost = seq(0.1, 0.3, by = 0.01), value = as.vector(t(tempData)), 
                            Group = c(rep('control', 21), rep('normal', 21), rep('occult', 21)))
  
  #plot about all threshold's mean curve figure.
  curveplot <- ggplot(MeanDraw,aes(x = network_cost,y = value,color = Group,shape = Group))
  curveplot <- curveplot + geom_point(size = 3) + geom_line()
  curveplot <- curveplot + ylab('')
  
  invisible(curveplot)
}

curveplot_2 <- renderFig(meanval_CC)
curveplot_3 <- renderFig(meanval_CL)
curveplot_4 <- renderFig(meanval_SW)

grid.arrange(curveplot_2, curveplot_3, curveplot_4)
