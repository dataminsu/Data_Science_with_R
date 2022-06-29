#데이터 전처리(Data Processing, Data Manipulation, Data Wrangling, Data Munging) dplyr가 많이 사용됨.
library(dplyr)
#Data Processing function
filter()#variable extract
select()#Observation extract
arrange()#arrange
mutate()#add variable
summarise()#통계치 산출
group_by()#집단별로 나누기
left_join()#merge column
bind_rows()#merge observation


# %>% 파이프 연산자(pipe Operator)는 Ctrl+Shift+M을 누르면 됨됨! 함수와 연결하는 역할을 함
exam %>% filter(class ==1) 
exam %>% filter(class !=2) #!=는 ~가 아닌 경우
exam %>% filter(english >=80)

# &로 여러 조건 필터 걸기, or(Ctrl +\)로 둘 중 하나 만족 필터 걸기
exam %>% filter(class ==1 & english >=80)
exam %>% filter(math>90 | english >90)
exam %>% filter(math<50 & science <=40)
exam %>% filter(class ==1 | class==2 | class==5)

# %in% 매치 연산자(match operator)를 사용해서 간단히 할 수 있음, 지정값이 조건 목록에 해당 가능한지 확인하는 기능
exam %>% filter(class %in% c(1,2,5))

#추출한 행으로 새로운 데이터 만들기기
class1 <- exam %>% filter(class ==1)
class2 <- exam %>% filter(class ==2)
mean(class1$math)
mean(class2$math)
#논리연산자-logical operator/ 산술연산자-Arithmetic operator 
#혼자서 해보기
#Q1
disel_1 <- mpg %>% filter(displ<=4)
disel_2 <-mpg %>% filter(displ>=5)
a<-mean(disel_1$hwy)
b<-mean(disel_2$hwy)
a>b
#Q2
toyota <- mpg %>% filter(manufacturer=='toyota')
audi <- mpg %>% filter(manufacturer=='audi')
mean(toyota$cty) >mean(audi$cty)
#Q3
m3<-mpg %>% filter(manufacturer %in% c("c %>% %>% hevrolet", "ford", "honda"))
mean(m3$hwy)

#필요한 변수만 추출하기
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

#혼자서 해보기
sample1<-mpg %>% 
  select(class, cty)
head(sample1)

suv_cty <- mpg %>% 
  filter(class=='suv') %>% 
  select(cty)

compact_cty <- mpg %>% 
  filter(class=='compact') %>% 
  select(cty)
mean(suv_cty$cty) > mean(compact_cty$cty)
#mean을 구할 때는 suv_cty만 입력해서는 안나온다. 어떤 vairable인지 확실하게 입력할 것! $를 이용해서~

#순서대로 정렬하기
exam %>% arrange(math)
exam %>% arrange(desc(math)) #descending은 오직 1개의 variable만 가져올 수 있음
exam %>% arrange(class, math)

audi <- mpg %>% 
  filter(manufacturer == 'audi')
audi %>% 
  arrange(desc(hwy)) %>%
  head(5)

#파생변수 추가하기
exam1 <- exam %>% 
  mutate (total = math + english + science, 
          mean = (math + english + science) /3,
          test = ifelse( science >= 60, "pass", "fail"))
exam %>% 
  mutate(total = english + science + math) %>%
  arrange(total) %>% 
  head

#혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)
mpg %>%
  mutate(cfv=cty+hwy, efv=cfv/2) %>% 
  head(10)

#집단별로 요약하기
exam %>% summarise(mean_math=mean(math))
#dbl은 double, 부동소수점 int는 integer 그리고 tibble: 5 x 2는 2행 5열의 티블 형태라는 걸 뜻함
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math), median_math=median(math), sum_math = sum(math), n=n())
#n()은 행 개수, 그래서 따로 변수 입력 x
mpg %>% 
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg <- as.data.frame(ggplot2::mpg)
mpg %>%
  group_by(manufacturer) %>% 
  filter(class =="suv") %>%
  mutate(tot = (cty+hwy)/2) %>% #통합 연비 변수 생성 ---이 과정을 빼먹어서 틀렸음..ㅠ
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
