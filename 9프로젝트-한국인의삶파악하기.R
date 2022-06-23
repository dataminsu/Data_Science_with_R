install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
raw_welfare <- read.spss(file ="Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)#SPSS 파일을 데이터프레임으로 변환, 이 파라미터가 없으면 리스트형태로 불러옴
welfare <- raw_welfare
View(welfare)
dim(welfare)
summary(welfare)
str(welfare)

welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9, #직업코드
                  code_region = h10_reg7) #지역코드

##성별에 따른 월급차이
#성별 전처리
class(welfare$sex)#변수 타입 파악 - numeric
table(welfare$sex)#각 범주에 몇 명이 있는 지 파악, 1이남자, 2가 여자, 모르거나 무응답 9

#이상치 결측처리
welfare$sex <- ifelse(welfare$sex %in% c("1","2"), welfare$sex, NA) #방법1
welfare$sex <- ifelse(welfare$sex == "9", NA, welfare$sex)#방법2
table(is.na(welfare$sex))#결측치 확인
welfare$sex <- ifelse(welfare$sex == 1, "male", "female") #값의 의미를 이해하기 쉽도록 male과 female로 바꾸기

table(welfare$sex)
qplot(welfare$sex)      

#월급 전처리
class(welfare$income)
summary(welfare$income) #최솟값이 0, 최댓값이 2400, NA's가 12030개가 있음
qplot(welfare$income) + xlim(0,1000) #분포 파악, xlim으로 최댓값 지워주기
welfare$income <- ifelse(welfare$income %in% c("0", "9999"), NA, welfare$income) #c()로 데이터 확인할 땐 %in% 써야함
table(is.na(welfare$income))#결측치 확인

#표를 만들어 비교
sex_income <- welfare %>% 
    filter(!is.na(income)) %>% 
    group_by(sex) %>% 
    summarise(mean_income = mean(income))
sex_income

#막대그래프 만들기
ggplot(data = sex_income, aes(x= sex, y= mean_income)) + geom_col()


##직업별 월급차이
#w전처리과정
class(welfare$code_job)
table(welfare$code_job)
list_job <- read_excel("Koweps_Codebook.xlsx", col_name=T, sheet=2)

