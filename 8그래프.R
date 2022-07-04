install.packages("ggplot2")
library(ggplot2)

#산점도scatter plot - 나이와 소득처럼 연속된 값을 가진 두 변수의 관계를 표현할 때 쓰임
ggplot(data = mpg, aes(x = displ, y = hwy)) + # 데이터 축
    geom_point() + #그래프 종류
      xlim(3,6) + #세부설정 etc
        ylim(10,30)
#dplyr은 패키지함수를 pipe operator 로 연결, ggplot은 +로 연결


#혼자서 해보기
midwest <- as.data.frame("ggplot2":: midwest)
options(scipen =99) #x축 정수형 표현
ggplot(data = midwest, aes(x= poptotal, y=popasian))
ggplot(data = midwest, aes(x= poptotal, y=popasian)) +
  geom_point() +
    xlim(0, 500000) +
      ylim(0, 10000)

#막대그래프 - 집단간 차이 표현하기
df_mpg <- mpg %>% group_by(drv) %>% 
            summarise(hwy_mean = mean(hwy))
df_mpg
ggplot(data = df_mpg, aes(x= reorder(drv, -hwy_mean), y= hwy_mean)) + geom_col()

ggplot(data = mpg, aes(x=drv)) + geom_bar()
ggplot(data = mpg, aes(x=hwy)) + geom_bar() #빈도 막대 그래프 만들기

#혼자해보기
mpg<-as.data.frame(ggplot2::mpg)
cty5 <- mpg %>%  
    filter(class == "suv") %>% 
      group_by(manufacturer) %>%
          summarise(cty_mean = mean(cty)) %>%
            arrange(desc(cty_mean)) %>% 
        head(5)

View(cty5)
ggplot(data = cty5, aes(x= reorder(manufacturer, -cty_mean), y=cty_mean)) + 
    geom_col()
ggplot(data = mpg, aes(x= class)) + geom_bar()

#선그래프(line chart) - 시간에 따라 달라지는 데이터 표현하기
#일정 시간 간격을 두고 나열된 데이터를 시계열 데이터(Time Series Data)라고 함
economics <- as.data.frame(ggplot2::economics)
ggplot(data=economics, aes(x=date, y=unemploy)) +
      geom_line()

ggplot(data=economics, aes(x=date, y=psavert)) + geom_line()
#상자그림-집단 간의 분포차이, 평균보다 데이터 자체의 특징을 이해하기 쉽다.
ggplot(data = mpg, aes(x=reorder(drv,-hwy), y=hwy)) + 
         geom_boxplot()
      
#혼자서 해보기
cty3 <- mpg %>% group_by(class) %>%
       filter(class==c("compact", "suv", "subcompact"))

ggplot(data=cty3, aes(x=class, y=cty)) + geom_boxplot()