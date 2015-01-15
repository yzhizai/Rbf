library(ggplot2)

load('barplot.RData')

barplot_1 <-  ggplot(data=control_data,aes(x = order,y = control))
cols <- c("0" = "#808080","1" = "#22DDDD","2" = "#0909F7","3" = "#FF0000")
barplot_1 + geom_bar(stat='identity',aes(fill = group)) + 
coord_flip()+scale_fill_manual(values = cols,breaks = c("0","1","2"))

barplot_1 <- barplot_1 + geom_bar(stat='identity',aes(fill = factor(con_col)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,
breaks = c("0","1","2")) + xlab(' ') + ylab(' ') + ylim(0,7) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))



barplot_2 <-  ggplot(data=occult_data,aes(x = order,y = occult))
barplot_2 + geom_bar(stat='identity',aes(fill = group)) + 
coord_flip()+scale_fill_manual(values = cols,breaks = c("0","1","2"))

barplot_2 <- barplot_2 + geom_bar(stat='identity',aes(fill = factor(occ_col)),width = 0.8) + coord_flip()+scale_fill_manual(values = cols,breaks = c("0","1","3")) + xlab(' ') + ylab(' ') + ylim(0,7) + theme(axis.text.y = element_text(size=12))+theme(axis.text = element_text(colour = '#000000'))
