#DataFrame, column is variable, row is case(specific, each)
#many column, better computer, many rows, better analytics

#df 만들기
english <-c(90,80,60,70)

math <- c(50,60,100,20)

class <-c(1,1,2,2) #1반, 2반 구분

df_midterm <- data.frame(english, math, class)

mean(df_midterm$english)#전체 영어 평균, $는 df 안 column지정 할 때 쓰임
mean(df_midterm$math)#전체 수학 평균

df_midterm <- data.frame(english = c(90,80,60,70),
                        math = c(50,60,100,20),
                        c = c(1,1,2,2)) #이런 식으로 한 번에 입력 가능함.
df_midterm
df_fruit <- data.frame(fruit=c("apple","strawberry","watermelon"),
                       price=c(1800, 1500, 3000),
                       sell=c(24,38,13))


#외부 데이터 이용하기
install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx") #exam의 df를 read_excel("불러올 파일")로 생성
df_exam

mean(df_exam$english)
mean(df_exam$science)

#외부 데이터 컨트롤
df_exam_novar <- read_excel("excel_exam_novar.xlsx")
df_exam_novar #R이 첫번째 raw를 column으로 인식해버림
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names=F) #col_names를 F로, column이 없어서 임의의 숫자로 정의
#True or False called 'Logical Vector', 논리형 벡터라고 불린다

#만약 한 엑셀 안에 여러개의 시트가 있다면?
df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet=3)#sheet parameter를 이용해서 몇 번째 sheet인지 정해주기
df_exam_sheet

#csv파일 불러오기
df_csv_exam <- read.csv("csv_exam.csv") #csv에선 header = F 파라미터를 사용하면 col_names과 같은 기능을 함.
df_csv_exam
write.csv(df_midterm, file="df_midter.csv") #csv형식으로 파일 저장

#RDS파일 활용하기
saveRDS(df_midterm, file = "df_midterm.rds") #데이터프레임을 rds형식으로 파일 저장

rm(df_midterm) #df_midterm 지우기

df_midterm <- readRDS("df_midterm.rds")
df_midterm