#결측치(Missing Value) 정제하기
df<- data.frame(sex = c("M", "F", NA, "M", "F"),
                score = c(5, 4, 3, 4, NA))
#결측치 찾기
table(is.na(df$sex))
table(is.na(df$score))
#결측치 제거하기
df %>% filter(is.na(score)) #score가 NA인 데이터만 출력
df %>% filter(!is.na(score))
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)
df_nomiss %>% filter(!is.na(score) & !is.na(sex)) %>%
  summarise(score, sex)
na.omit #결측치가 하나라도 있으면 행 제거, 다만 필요 행까지 손실되니까 filter를 쓰는 걸 추천함.
mean(df$score, na.rm=T) #결측치를 제외하고 평균 산출
sum(df$score, na.rm=T) #결측치 제외하고 합계 산출
#함수의 결측치 제외기능 사용하기
exam <- read.csv("csv_exam.csv")
exam[c(3,8,15), "math"] <-NA #3, 8, 15행의 math에 NA 할당
#[]대괄호는 데이터의 위치를 지칭하는 역할. 쉼표 왼쪽은 행, 오른쪽은 열 위치를 말한다.
exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   media_math = median(math, na.rm = T))
#결측치 대체법(Imputation)
mean(exam$math, na.rm=T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math) #math가 NA면 55로 대체
table(is.na(exam$math)) #결측치 빈도표 생성 (확인과정)
exam
mean(exam$math)

#혼자서 해보기
mpg <- as.data.frame("ggplot2"::mpg)
mpg [c(65, 124, 131, 153, 212), "hwy"] <- NA
table(is.na(mpg$drv))
table(is.na(mpg$hwy))
mpg %>%
    filter(!is.na(hwy)) %>%   
      group_by(drv) %>%
      summarise(mean_hwy = mean(hwy))

#이상치(outlier)정제하기
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
table(outlier$score)
#결측 처리하기
outlier$sex <- ifelse(outlier$sex ==3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score >=6, NA, outlier$score)
outlier %>%
    filter(!is.na(score) &!is.na(sex)) %>% 
      group_by(sex) %>% 
        summarise(mean_score = mean(score))
#이상치 제거하기 - 극단적인 값
boxplot(mpg$hwy)$stats
#순서대로 아래극단치 경계, 1사분위수, 중앙값, 3사분위수, 위쪽 극단치 경계
mpg$hwy <- ifelse(mpg$hwy <12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93), "drv"] <- "k"
mpg[c(29,43,129,203), "cty"] <- c(3, 4, 39, 42)

table(mpg$drv)

mpg$drv <- ifelse(mpg$drv %in% c("4", "r", "f"), mpg$drv, NA) 
table(mpg$drv)

boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty >26 | mpg$cty <9, NA, mpg$cty)
boxplot(mpg$cty)

mpg %>% filter(!is.na(drv)& !is.na(cty)) %>% #filter로 결측치 아닌 걸 뽑을 때, 변수를 2개 이상 뽑아야한다.
  group_by(drv) %>% 
  summarise(cty_mean =mean(cty))

#정리하기
#결측치 확인
table(is.na(df$score))
#결측치 제거
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
#함수의 결측치 제외 기능 사용하기
mean(df$score, na.rm = T)
exam %>% summarise(mean_math = mean(math, na.rm = T))
#이상치 확인
table(outlier$sex)
#결측처리
outlier$sex <- ifelse(outlier ==3, NA, outlier$sex)
#boxplot으로 극단치 기준찾기
boxplot(mpg$hwy)$stats
#극단치 결측처리
mpg$hwy <- ifelse(mpg$hwy <12 |mpg$hwy >37, NA, mpg$hwy)
