library(ggplot2)
library(reshape2)

mydata <- read.table(file = 'global_variables_cost.csv',sep = ',',header = T)
mydata_tmp <- melt(mydata,id = c("network_cost","Group"))

curveplot_1 <- ggplot(mydata_tmp,aes(x = network_cost,y = value,color = Group,shape = Group))
curveplot_1 <- curveplot_1 + geom_point(size = 3) + geom_line() + facet_grid(variable~.,scales = 'free_y')
curveplot_1 <- curveplot_1 + ylab('')