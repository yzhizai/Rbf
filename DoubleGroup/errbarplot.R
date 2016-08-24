library(psych)
library(ggplot2)
library(xlsx)

filename <- choose.files(getwd(), 'choose the cost 0.2 file')
mydata <- read.xlsx2(filename, sheetIndex = 1,
                     colClasses = c('character',rep('numeric',4), 
                                    'character'))
mydata$efficiency_bin <- as.numeric(mydata$efficiency_bin)
mydata$clusterMean_bu <- as.numeric(mydata$clusterMean_bu)
mydata$charpath_B <- as.numeric(mydata$charpath_B)
mydata$smallworldness_bu <- as.numeric(mydata$smallworldness_bu)
mydata$Group <- factor(mydata$Group)
mydata_subset <- mydata[, c(-1 ,-6)]

general_stat <- describeBy(mydata_subset,group = mydata$Group)
control_stat <- general_stat[[1]]
occult_stat <- general_stat[[2]]

data2plot <- data.frame(
  trt = factor(rep(c('Eglob','Gamma', 'Lambda','Sigma'),2)),
  resp = c(control_stat$mean,occult_stat$mean),
  group = factor(c(rep('control',4),rep('occultCP',4))),
  se = c(control_stat$sd,occult_stat$sd)
)

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 <- plot1 + geom_bar(position=dodge,stat='identity') + 
  geom_errorbar(limits,position=dodge,width=0.2,size = 0.8) + ylim(0, 6) +
  xlab(' ') + ylab('Value') + 
  theme(axis.text=element_text(colour='#000000',size=16),
                                         legend.text = element_text(size=15),
                                    legend.title = element_text(size=15),
                                    axis.title = element_text(size=16)) + labs(fill = 'Group')