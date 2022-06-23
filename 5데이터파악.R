exam <- read.csv("csv_exam.csv")

head(exam)#head는 앞에서 6행까지 출력

head(exam, 10)

tail(exam)#tail은 뒤에서부터 6행까지 출력

tail(exam, 10)

View(exam)
dim(exam) #20행, 5열


str(exam) #데이터 속성 확인 (20 observations(관측치), 5variables, int는 integers)

summary(exam) #요약 통계량 출력(median은 중앙값, 1stQu는 1사분위수, 3rdQu는 3사 분위수)

istall.packages("ggplot2")
mpg <- as.data.frame(ggplot2::mpg) #ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기, ::은 특정 함수나 데이터 지정
head(mpg, 10)
tail(mpg, 10)
View(mpg)
dim(mpg)
str(mpg)#chr = character, num=number(실수)
?mpg
summary(mpg)

#변수명 바꾸기
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

install.packages("dplyr")
library(dplyr)

df_new <- df_raw
df_new
rename(df_new, v2= var2)
df_new
rename(df_new, v1= var1, v2=var2) #여기서 var1만 입력하면 v2는 var2로 다시 돌아감
df_new
df_raw

install.packages("ggplot2")
new <- as.data.frame("ggplot2"::mpg)
str(new)
head(new)
tail(new)
install.packages("dplyr")
library(dplyr)
rename(new, city = cty, highway=hwy)# cty=city X city=cty O >할당의 개념이 아님!

#Derived Variable 생성하기
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df
df$var_sum <- df$var1 + df$var2
df
df$mean <- (df$var1 +df$var2)/2
rename(df, var_mean= mean)

#2번째derived variable with 조건문(conditional Statement)
mpg$total <- (mpg$hwy + mpg$cty)/2
mpg
mean(mpg$total)
summary(mpg$total)
hist(mpg$total)
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg)
table(mpg$test)

library(ggplot2)
qplot(mpg$test)
mpg$grade <- ifelse(mpg$total >=30, "A",
                    ifelse(mpg$total >=20, "B", "C"))
table(mpg$grade)
qplot(mpg$grade)
mpg$grade<- ifelse(mpg$total >=30, "A",
                   ifelse(mpg$total >=25, "B",
                          ifelse(mpg$total >=20, "C", "D")))
qplot(mpg$grade)

#요약
#1. 데이터 준비, 데이터 패키지 준비
mpg <- as.data.frame(ggplot2::mpg)
library(dsplyr)
library(ggplot2)
#2. 데이터 파악
head(mpg) 
tail(mpg) 
View(mpg) 
dim(mpg) 
str(mpg) 
summary(mpg)
#3.변수명 수정
mpg <- reanme(mpg, company = manufacturer)
#4. 파생변수 생성
mpg$total <- (mpg$hwy + mpg$cty)
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
#5.빈도확인
qplot(mpg$total)
table(mpg$total)
#예제 파일
library(ggplot2)
library(dplyr)
pop<- as.data.frame(ggplot2::midwest)
pop
rename(pop, total=poptotal, asian=popasian)
head(pop)
asian_ratio <- (pop$popasian/pop$poptotal)
qplot(asian_ratio)
mean(asian_ratio)
pop_test <- ifelse(asian_ratio >= mean(asian_ratio), "large", "samll")
qplot(pop_test)
table(pop_test)

#rename을 해도 다시 돌아가는 걸 처음 알았다...