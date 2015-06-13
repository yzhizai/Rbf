library(coin)  #used to excute the permuted test
library(psych) #used to discribe the data

mydata <- read.table(file = 'global_variables_2.csv',sep = ',',header = T)
describe(mydata)

mydata_ge <- data.frame(Eglob=mydata$Eglob,Group=mydata$Group)
test_ge <- oneway_test(Eglob~Group,data=mydata_ge,distribution='exact')

mydata_gamma <- data.frame(Gamma=mydata$Gamma,Group=mydata$Group)
test_gamma <- oneway_test(Gamma~Group,data=mydata_gamma,distribution='exact')

mydata_lambda <- data.frame(Lambda=mydata$Lambda,Group=mydata$Group)
test_lambda <- oneway_test(Lambda~Group,data=mydata_lambda,distribution='exact')

mydata_sigma <- data.frame(Sigma=mydata$Sigma,Group=mydata$Group)
test_sigma <- oneway_test(Sigma~Group,data=mydata_sigma,distribution='exact')