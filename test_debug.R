library(ggplot2)
library(gridExtra)

dataGenerate <- function(x, y) {
  AA <- datta.frame(x = x, y = y)
}

x <- c(1:10)

y <- sin(x)

AA <- dataGenerate(x, y)

myPlot <- ggplot(AA, aes(x = x, y = y))
myPlot <- myPlot + geom_line(colour = "green")

grid.arrange(myPlot, nrow = 1)