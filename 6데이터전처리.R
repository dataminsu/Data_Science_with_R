#데이터 전처리(Data Processing, Data Manipulation, Data Wrangling, Data Munging) dplyr가 많이 사용됨.
library(dplyr)
#Data Processing function

filter(class %in% c(1,3,5) )#variable extract
select(math,-english)#Observation extract
arrange(desc(one_variable))#arrange
mutate(total=ifelse(mpg$drv=='4', "4", ifelse(mpg$drv=='r', "R", "F"))) %>% head#add variable
summarise(mean_math=mean(math), n=n())#전체를 요약하기보단 group_by와 함께 집단별 통계량 산출
group_by(species)#집단별로 나누기

filter()#observations extract
select()#Variables(columns) extract
arrange()#arrange
mutate()#add variable
summarise()#통계치 산출
group_by()#집단별로 나누기

left_join()#merge column
bind_rows()#merge observation


# %>% 파이프 연산자(pipe Operator)는 Ctrl+Shift+M을 누르면 됨됨! 함수와 연결하는 역할을 함
exam <- read.csv("csv_exam.csv")
exam %>% filter(class ==1) 
exam %>% filter(class !=2) #!=는 ~가 아닌 경우

# &로 여러 조건 필터 걸기, or(Shift +\)(vertical bar)로 둘 중 하나 만족 필터 걸기
exam %>% filter(class ==1 & english >=80 & math !=50)
exam %>% filter(class ==1 | class==2 |class==5)

# %in% 매치 연산자(match operator)를 사용해서 간단히 할 수 있음, 지정값이 조건 목록에 해당하는 지 확인
exam %>% filter(class %in% c(1,2,5))
exam_class <- exam %>% filter(class %in% c(1,3,4))

#추출한 행으로 새로운 데이터 만들기
class1 <- exam %>% filter(class ==1)
class2 <- exam %>% filter(class ==2)
mean(class1$math)
#논리연산자(logical operator)
#<,>,<=,>=,!=,==,%in%,|,&
#산술연산자(Arithmetic operator) 
#+,-,*,/,^,**,%|%(나눗셈의 몫),%%(나눗셈의 나머지)

#필요한 변수만 추출하기, select 함수
exam %>% select(english, math)
exam %>% select(-english, -math)

#dplyr의 함수는 서로 조합이 가능하다
exam %>%
  filter(class ==1) %>%
  select(english)

#데이터의 일부만 출력하기
exam %>%
  select(id, math) %>% 
  head(10)

#순서대로 정렬하기
exam %>% arrange(desc(math)) #descending은 오직 1개의 variable만 가져올 수 있음
exam %>% arrange(class, math) #arrange의 기본은 오름차수임

#파생변수(derived) 추가하기
exam1 <- exam %>% 
  mutate(total = math + english + science, 
          mean = (math + english + science) /3,
          test = ifelse( science >= 60, "pass", "fail"))

#집단별로 요약하기
exam %>% summarise(mean_math=mean(math))
#tibble: 5 x 2는 2행 5열의 티블 형태라는 걸 뜻함
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math), median_math=median(math), sum_math = sum(math), n=n())

#n()은 행 개수, 그래서 따로 변수 입력 x, 학생수 셀 때 유용함
mpg %>% 
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg <- as.data.frame(ggplot2::mpg)
mpg %>%
  group_by(manufacturer) %>% 
  filter(class =="suv") %>%
  mutate(total = (cty+hwy)/2) %>% #통합 연비 변수 생성 ---이 과정을 빼먹어서 틀렸음..ㅠ
  summarise(cfe=mean(tot)) %>% #통합 연비 평균 산출
  arrange(desc(cfe)) %>% 
  head(5)

#혼자서 해보기
mpg %>% 
  group_by(class) %>%
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty))

mpg %>%
  group_by(manufacturer) %>% 
  summarise(mean_hwy =mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% 
  group_by(manufacturer) %>%
  filter(class=="compact") %>% 
  summarise(compact_n = n()) %>%
  arrange(desc(compact_n))

#데이터 합치기
test1 <- data.frame(id = c(1, 2, 3, 4, 5), midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5), midterm = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by="id")

name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jeong"))
View(name)

exam_new <- left_join(name, exam, by = "class")

group_a <- data.frame(id=c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_all <- bind_rows(group_a, group_b)
group_all

fuel <- data.frame(fl=c("c","d","e","p","r"),
                   price_fuel=c(2.35, 2.38, 2.11, 2.76, 2.22))
fuel
mpg <- left_join(mpg, fuel, by="fl")
mpg

mpg %>% select(model, fl, price_fuel) %>% 
    head(5)

#정리하기
#1.조건에 맞는 데이터만 추출하기
exam %>% filter(english >= 80)
#여러 조건 동시 충족
exam %>%  filter(class ==1 & math >- 80)
#여러 조건 중 하나 이상 충족
exam %>%  filter(class ==1 | math >=90)

#2. 필요한 변수만 추출하기
exam %>% select(math, class, english)

#3.함수 조합하기, 일부만 추출하기
exam %>% select(id, math) %>% head(10)

#4. 순서대로 정렬하기
exam %>% arrange(math, english)
exam %>% arrange(desc(math))

#5. 파생변수 추가하기
exam %>% 
    mutate(total = (math + science + english),
           mean = (math + science + english)/3)
#mutate()에 ifelse() 적용하기
exam %>% 
    mutate(test = ifelse(math >= 85, "A",
                         ifelse(math >= 55, "B", "C"))) %>% 
      arrange(test)
#6.집단별로 요약하기
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))
#각 집단별로 다시 집단 나누기
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty))

#7.데이터 합치기
# 가로
total <- left_join(test1, test2, by = "id")
#세로
group_all <- bind_rows(group_a, group_b)
