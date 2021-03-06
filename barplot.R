library(ggplot2)
library(reshape2)
library(gridExtra)

mydata_origin <- read.table(file = 'hub_control.csv',sep = ',',header = T, 
                            colClasses = c('character', rep('numeric', 3)))
mydata <- mydata_origin[,1:4]
mydata$r_order <- factor(x = c(90:1),labels = rev(mydata$node))

md <- melt(mydata,id = c('node','r_order'))

barplot_1 <-  ggplot(data=md,aes(x = r_order,y = value,fill = variable))
# cols <- c("cc" = "#808080","deg" = "#22DDDD","bc" = "#0909F7")

barplot_1 <- barplot_1 + geom_bar(stat = 'identity',width = 0.8)+ 
  coord_flip()+ xlab(' ') + ylab(' ')  + theme(axis.text.y = element_text(size=7)) + 
  theme(axis.text = element_text(colour = '#000000'))

mydata_origin <- read.table(file = 'hub_normal.csv',sep = ',',header = T,
                            colClasses = c('character', rep('numeric', 3)))
mydata <- mydata_origin[,1:4]
mydata$r_order <- factor(x = c(90:1),labels = rev(mydata$node))

md <- melt(mydata,id = c('node','r_order'))

barplot_2 <-  ggplot(data=md,aes(x = r_order,y = value,fill = variable))
# cols <- c("cc" = "#808080","deg" = "#22DDDD","bc" = "#0909F7")

barplot_2 <- barplot_2 + geom_bar(stat = 'identity',width = 0.8)+ 
  coord_flip()+ xlab(' ') + ylab(' ')  + theme(axis.text.y = element_text(size=7)) + 
  theme(axis.text = element_text(colour = '#000000'))

mydata_origin <- read.table(file = 'hub_occult.csv',sep = ',',header = T,
                            colClasses = c('character', rep('numeric', 3)))
mydata <- mydata_origin[,1:4]
mydata$r_order <- factor(x = c(90:1),labels = rev(mydata$node))

md <- melt(mydata,id = c('node','r_order'))

barplot_3 <-  ggplot(data=md,aes(x = r_order,y = value,fill = variable))
# cols <- c("cc" = "#808080","deg" = "#22DDDD","bc" = "#0909F7")

barplot_3 <- barplot_3 + geom_bar(stat = 'identity',width = 0.8)+ 
  coord_flip()+ xlab(' ') + ylab(' ')  + theme(axis.text.y = element_text(size=7)) + 
  theme(axis.text = element_text(colour = '#000000'))

grid.arrange(barplot_1, barplot_2, barplot_3, nrow = 1)

# barplot_1 <- barplot_1 + geom_bar(stat='identity',aes(fill = factor(color)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,
# breaks = c("0","1","2")) + xlab(' ') + ylab(' ') + ylim(0,6) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))
# 
# 
# 
# barplot_2 <-  ggplot(data=data_occult,aes(x = order,y = value))
# 
# barplot_2 <- barplot_2 + geom_bar(stat='identity',aes(fill = factor(color)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,
# breaks = c("0","1","3")) + xlab(' ') + ylab(' ') + ylim(0,6) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))
