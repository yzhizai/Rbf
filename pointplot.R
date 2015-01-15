library(ggplot2)

load('point_data.RData')

cols <- c("0" = "#808080","1" = "#22DDDD","2" = "#0909F7","3" = "#FF0000")

fit_1 <- lm(occult~control,data=point_data)
fitdata_1 <- data.frame(control = point_data$control,occult= fitted(fit_1))

pointplot_1 <- ggplot(data=point_data,aes(x=control,y=occult))

pointplot_1 <- pointplot_1 + geom_point(size = 4,shape = 19,aes(colour=factor(color))) + 
geom_line(data=fitdata_1,linetype=2,size=2,colour = 'green')+scale_color_manual(values=cols,breaks=c("0","1","2","3"))+xlim(0,7) + ylim(0,7)

