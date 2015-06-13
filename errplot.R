 #This file is used to plot significant figure. 
library(ggplot2)
data2plot <- data.frame(
  trt = factor(c('Gamma','Gamma', 'Lambda', 'Lambda','Eglob','Eglob','Sigma','Sigma')),
  resp = c(2.33, 2.51, 1.1,1.12, 0.5, 0.47, 2.1, 2.24),
  group = factor(c(1, 2, 1, 2, 1, 2, 1, 2)),
  se = c(0.51, 0.3, 0.03, 0.02, 0.05, 0.02, 0.42, 0.25)
)

data2plot$group <- factor(data2plot$group,labels = c('control','occultCP'),levels = c(1,2))

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 <- plot1 + geom_bar(position=dodge,stat='identity') + geom_errorbar(limits,position=dodge,width=0.2,size = 0.8)+
xlab(' ') + ylab('Mean value') + theme(axis.text=element_text(colour='#000000',size=16),
legend.text = element_text(size=15),legend.title = element_text(size=15),axis.title = element_text(size=16)) + labs(fill = 'Group')