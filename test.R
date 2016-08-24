library(xlsx)

filename = 'test.xlsx'
mydata <- read.xlsx2(file = filename,sheetIndex = 1,colClasses = rep('numeric',2));

mydata$c = mydata$a + mydata$b;

write.xlsx2(mydata,file = filename,sheetName = 'addsheet',append = T,row.names = F)