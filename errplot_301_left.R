#This file is used to plot significant figure. 
library(ggplot2)
data2plot <- data.frame(
  trt = factor(c('CC','CC', 'CC','CL', 'CL','CL','GE','GE','GE','SW','SW','SW')),
  resp = c(1.31,1.3,1.35, 1.04,1.04,1.05, 0.63,0.63,0.61, 1.26,1.24,1.28),
  group = factor(c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3)),
  se = c(0.1,0.12,0.11, 0.01,0.02,0.02, 0.02,0.028,0.026, 0.1,0.11,0.11)
)

data2plot$group <- factor(data2plot$group,labels = c('control','left','right'),levels = c(1,2,3))

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 <- plot1 + geom_bar(position=dodge,stat='identity') + geom_errorbar(limits,position=dodge,width=0.2,size = 0.8)+
xlab(' ') + ylab('Value') + theme(axis.text=element_text(colour='#000000',size=16),
legend.text = element_text(size=15),legend.title = element_text(size=15),axis.title = element_text(size=16))