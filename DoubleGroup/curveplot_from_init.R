#this is code  to plot curve from initial file.
library(xlsx)
library(coin)
library(tcltk)
library(psych)
library(tidyr)
library(ggplot2)

#choose the file to process
filename <- choose.files(getwd(), 'choose the small world files, 1 for ge, 2 for sw')
filename1 <- filename[1]
filename2 <- filename[2]

wb1 <- loadWorkbook(file = filename1)
sheets1 <- getSheets(wb1)

wb2 <- loadWorkbook(file = filename2)
sheets2 <- getSheets(wb2)

valToPlot <- data.frame(Eglob = numeric(0), Gamma = numeric(0), Lambda = numeric(0), 
                        Sigma = numeric(0))
pb <- tkProgressBar(min = 0, max = 100, initial = 0)
for (aa in 1:length(sheets1)) {
  mydata1 <- read.xlsx2(file = filename1,sheetIndex = aa,
                       colClasses = c('numeric'))
  mydata2 <- read.xlsx2(file = filename2,sheetIndex = aa,
                        colClasses = rep('numeric',3))
  mydata <- cbind(mydata1, mydata2)
  mydata$group <- factor(c(rep('control',11),rep('occult',8)))
  mydata$efficiency_bin <- as.numeric(mydata$efficiency_bin)
  mydata$clusterMean_bu <- as.numeric(mydata$clusterMean_bu)
  mydata$charpath_B <- as.numeric(mydata$charpath_B)
  mydata$smallworldness_bu <- as.numeric(mydata$smallworldness_bu)
  
  mydata_subset <- mydata[, -5]

  general_stat <- describeBy(mydata_subset,group = mydata$group)
  control_stat <- general_stat[[1]]
  occult_stat <- general_stat[[2]]
  df_tmp1 <- as.data.frame(t(control_stat$mean))
  df_tmp2 <- as.data.frame(t(occult_stat$mean))
  valToPlot <- rbind(valToPlot, df_tmp1, df_tmp2)
  setTkProgressBar(pb, round(aa/length(sheets1)*100))
}
close(pb)

names(valToPlot) <- c('Eglob', 'Gamma', 'Lambda', 'Sigma')
valToPlot$Group <- factor(rep(c('control', 'occult'), 21))

valToPlot$cost <- rep(seq(from = 0.1,to = 0.3,by = 0.01), rep(2, 21))

valToPlot_tidy <- gather(valToPlot, 'variable', 'value', 1:4)

curveplot_1 <- ggplot(valToPlot_tidy,aes(x = cost,y = value,color = Group,shape = Group))
curveplot_1 <- curveplot_1 + geom_point(size = 3) + geom_line() + facet_grid(variable~.,scales = 'free_y')
curveplot_1 <- curveplot_1 + ylab('')