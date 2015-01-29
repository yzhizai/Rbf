library(ggplot2)

load('barplot.RData')

barplot_1 <-  ggplot(data=data_control,aes(x = order,y = value))
cols <- c("0" = "#808080","1" = "#22DDDD","2" = "#0909F7","3" = "#FF0000")


barplot_1 <- barplot_1 + geom_bar(stat='identity',aes(fill = factor(color)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,
breaks = c("0","1","2")) + xlab(' ') + ylab(' ') + ylim(0,6) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))



barplot_2 <-  ggplot(data=data_occult,aes(x = order,y = value))

barplot_2 <- barplot_2 + geom_bar(stat='identity',aes(fill = factor(color)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,
breaks = c("0","1","3")) + xlab(' ') + ylab(' ') + ylim(0,6) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))
