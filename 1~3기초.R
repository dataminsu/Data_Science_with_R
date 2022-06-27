#R스크립트 파일은 *.R로 저장됨
#'.Rhistroy'파일은 지금까지 실행된 명령어 목록을 담고 있음. .RData 파일은 R스튜디오에서 생성된 데이터를 담고있음.
#새 스크립트 만드는 단축키는 Ctrl Shft N 임
#환경설정은 두 가지 옵션이 있음 Global Option/Project Option
#Soft-wrap 설정 Tools>Global Option > Code> Soft-wrap R source files/ (Project Option) Text encoding을 UTF-8로 설정하기
#변수명을 생성할 땐 항상 문자로 먼저 시작해야한다/ <-는 Assignment Operator라고 한다.

var1 <- c(1, 2, 5, 7, 9) #C는 Combine이라는 뜻임
var2 <- (4:30) #(:)콜론은 1씩 증가하는 연속된 숫자변수
var3 <- seq(5, 80, by=5) #seq는 똑같이 연속 정수변수, by는 일정 간격을 두고 연속된 숫자를 만드는 '파라미터'임 파라미터(또는 매개변수)는 (함수옵션설정)

str1 <- "a"
str2 <- c("hello", "world", "I'm", "Minsu")
str2

#number function
mean(var1)
max(var1)
min(var1)

#text function
paste(str2, collapse = " ") #단어마다 띄어쓰기로 합치기

#make new variable with functoin
x_mean <- mean(var1)
x_mean

#installing packages
install.packages("ggplot2")#패키지 이름엔 항상 따옴표하기

library(ggplot2)#라이브러리 불러오기

qplot(data=mpg, x=hwy)
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv,y=hwy, geom="line")#선그래프 형태
qplot(data=mpg, x=drv,y=hwy, geom="boxplot")#박스플롯 형태, 파라미터를 바꾸면 그래프 형태가 달라짐짐
qplot(data=mpg, x=drv,y=hwy, geom="boxplot", colour=drv)#drv에 색깔별로 분류류

#qplot 함수 메뉴얼 출력, help함수로 함수 기능출력 할 수 있음
?qplot
