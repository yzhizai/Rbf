#This file is used to plot significant figure. 
library(ggplot2)
data2plot <- data.frame(
  trt = factor(c('CC','CC', 'CC','CL', 'CL','CL','GE','GE','GE','SW','SW','SW')),
  resp = c(1.315,1.297,1.328, 1.05,1.05,1.06, 0.62,0.61,0.606, 1.25,1.23,1.25),
  group = factor(c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3)),
  se = c(0.18,0.11,0.13, 0.01,0.03,0.02, 0.03,0.03,0.028, 0.16,0.09,0.11)
)

data2plot$group <- factor(data2plot$group,labels = c('control','left','right'),levels = c(1,2,3))

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 <- plot1 + geom_bar(position=dodge,stat='identity') + geom_errorbar(limits,position=dodge,width=0.2,size = 0.8)+
xlab(' ') + ylab('Value') + theme(axis.text=element_text(colour='#000000',size=16),
legend.text = element_text(size=15),legend.title = element_text(size=15),axis.title = element_text(size=16))