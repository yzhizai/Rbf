#This file is used to plot significant figure. 
data2plot <- data.frame(
  trt = factor(c('CC','CC', 'CL', 'CL','GE','GE','SW','SW')),
  resp = c(0.49, 0.45, 2.15,2.16, 0.5, 0.45, 1.68, 1.70),
  group = factor(c(1, 2, 1, 2, 1, 2, 1, 2)),
  se = c(0.04, 0.05, 0.09, 0.13, 0.03, 0.1, 0.16, 0.17)
)

data2plot$group <- factor(data2plot$group,labels = c('control','occult'),levels = c(1,2))

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 + geom_bar(position=dodge,stat='identity') + geom_errorbar(limits,position=dodge,width=0.2,size = 0.8) \
 + xlab(' ') + ylab('Mean value') + theme(axis.text=element_text(colour='#000000',size=16),legend. \
text = element_text(size=15),legend.title = element_text(size=15),axis.title = element_text(size=16))