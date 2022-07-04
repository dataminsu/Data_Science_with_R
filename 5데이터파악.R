#데이터 파악하는 함수 head, tail, View, dim, str, summary -The head tail Views star dimensions' summary-
exam <- read.csv("csv_exam.csv")

head(exam)#head는 앞에서 6행까지 출력
head(exam, 10)
tail(exam)#tail은 뒤에서부터 6행까지 출력
tail(exam, 10)
View(exam)
dim(exam) #20raws(observations), 5column(variables)
str(exam) #데이터 속성 확인 (20 observations(관측치), 5variables, int는 integers)
#chr = character, num=number(실수), dbl(=float), factor(여러가지 섞인 것)
summary(exam) #요약 통계량 출력(median은 중앙값, 1stQu는 1사분위수-하위 25%, 3rdQu는 3사 분위수-하위 75%)

istall.packages("ggplot2")
mpg <- as.data.frame(ggplot2::mpg) #ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기
?mpg


#변수명 바꾸기
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
install.packages("dplyr")
library(dplyr)
rename(mpg, city=cty, highway=hwy)#하지만 mpg(원래 데이터)는 바뀌지 않았음

#Derived Variable 생성하기
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df$var_sum <- df$var1 + df$var2
df

#Derived variable with 조건문(conditional Statement) >나중에 mutate로 하면 됌
mpg <- as.data.frame(ggplot2::mpg)
mpg$total <- (mpg$hwy +mpg$cty)/2
mpg$test <- ifelse(mpg$total>=20,"pass","fail")
hist(mpg$total)
qplot(data=mpg, x=mpg$total, bins=10, color=drv)

table(mpg$test) #table함수를 이용해서 보기

mpg$grade<- ifelse(mpg$total >=30, "A",
                   ifelse(mpg$total >=25, "B",
                   ifelse(mpg$total >=20, "C", "D")))
qplot(mpg$grade)
View()
library(dplyr)
library(ggplot2)
library(plotly)
mpg<-mpg
View(mpg)
hwy_mean <- mpg %>% group_by(manufacturer) %>%
  summarize(hwy_mean=mean(hwy)) %>%
  arrange(desc(hwy_mean)) %>% 
  head(3)

means <- mpg %>% group_by(manufacturer) %>% 
  summarize(hwy_mean=mean(hwy), cty_mean=mean(cty))

ggplot(data=means, aes(x=hwy_mean, y=cty_mean, color=manufacturer)) + geom_point(shape=19, size=3) +
   ggtitle("Means by manufacturers, using by different colors")

View(mpg)
ggplot(data=mpg,aes(x=hwy, y=cty, color=manufacturer, shape=class)) + geom_point(size=4) + ggtitle("Manufacturer and models")

# + geom_text(aes(label=model, size=0.6, vjust=20, hjust=5)) # vjust=-1 위로, hjust=1 오른쪽

View(means)
qplot(data=means, x=hwy_mean, y=cty_mean, color=manufacturer)