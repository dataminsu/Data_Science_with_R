#2022-06-29

mean(var2)
max(var2)
min(var2)

paste(str4, collapse=" ")

x_mean <- mean(var4)
x_mean

str4_paste <- paste(str4, collapse=",")
str4_paste
install.packages("ggplot2")
library(ggplot2)
library(ggplot2)
x<- c("a", "a", "b", "c,")
x
qplot(x)
qplot(data=mpg, x=hwy)
qplot(data=mpg, x= cty)
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv,y=hwy, geom="line")
qplot(data=mpg, x=drv,y=hwy, geom="boxplot")
qplot(data=mpg, x=drv,y=hwy, geom="boxplot", colour=drv)

library(ggplot2)
#qplot 함수 메뉴얼 출력
?qplot

geom = smooth to geom = c("point", "smooth")