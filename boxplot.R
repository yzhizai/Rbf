library(ggplot2)

mydata <- read.table(file = 'globalVariables.csv',sep = ',',header = T)

mydata$group <- factor(mydata$group,labels = c('occult','control'))
boxplot1 <- ggplot(mydata,aes(x=group,y=SW))
boxplot1 <- boxplot1 + geom_boxplot() + 
  theme(axis.text.x = element_text(size = 20))