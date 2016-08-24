#This file is used to plot significant figure. 
library(ggplot2)
library(psych)
library(dplyr)

mydata <- read.table(file = 'global_variable_2.csv',sep = ',',header = T)
mydata$Group <- factor(mydata$Group)
mydata_subset <- select(mydata, - one_of('subj_ID', 'Group'))

general_stat <- describeBy(mydata_subset,group = mydata$Group)
control_stat <- general_stat[[1]]
normal_stat <- general_stat[[2]]
occult_stat <- general_stat[[3]]


data2plot <- data.frame(
  trt = factor(rep(c('GE','CC', 'CL','SW'), 3)),
  resp = c(control_stat$mean, normal_stat$mean, occult_stat$mean),
  group = factor(c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3)),
  se = c(control_stat$sd, normal_stat$sd, occult_stat$sd)
)

data2plot$group <- factor(data2plot$group,labels = c('control','normal','occult'),levels = c(1,2,3))

limits <- aes(ymax = resp + se, ymin=resp - se)
dodge <- position_dodge(width=0.9)
plot1 <- ggplot(data=data2plot,aes(x=trt,y=resp,fill=group))

plot1 <- plot1 + geom_bar(position=dodge,stat='identity') + geom_errorbar(limits,position=dodge,width=0.2,size = 0.8)+
xlab(' ') + ylab('Value') + theme(axis.text=element_text(colour='#000000',size=16),
legend.text = element_text(size=15),legend.title = element_text(size=15),axis.title = element_text(size=16))