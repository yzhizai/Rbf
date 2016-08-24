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