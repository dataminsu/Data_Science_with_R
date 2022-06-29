#데이터 파악하는 함수 head, tail, View, dim, str, summary -The head tail Views star dimensions' summary-
exam <- read.csv("csv_exam.csv")

head(exam)#head는 앞에서 6행까지 출력
head(exam, 10)

tail(exam)#tail은 뒤에서부터 6행까지 출력
tail(exam, 10)

View(exam)

dim(exam) #20raws(observations), 5column(variables)

str(exam) #데이터 속성 확인 (20 observations(관측치), 5variables, int는 integers)

summary(exam) #요약 통계량 출력(median은 중앙값, 1stQu는 1사분위수-하위 25%, 3rdQu는 3사 분위수-하위 75%)

istall.packages("ggplot2")
mpg <- as.data.frame(ggplot2::mpg) #ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기

head(mpg, 10)
tail(mpg, 10)
View(mpg)
dim(mpg)
str(mpg)#chr = character, num=number(실수), dbl(=float), factor(여러가지 섞인 것)
summary(mpg)
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

#Derived variable with 조건문(conditional Statement)
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