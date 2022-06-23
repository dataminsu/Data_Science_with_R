score <- c(80, 60, 70, 50, 90)
mean(score)
score_mean <- mean(score)
score_mean
#column-row / variable-case

english <-c(90,80,60,70)
english

math <- c(50,60,100,20)
math

df_midterm <- data.frame(english, math)
df_midterm

class <-c(1,1,2,2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$science)

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")

saveRDS(df_midterm, file = "df_midterm.rds")

rm(df_midterm)

df_midterm

df_midterm <- readRDS("df_midterm.rds")

df_midterm

library(readxl)
midterm <- read_excel("excel_exam.xlsx")

df_csv_exam <- read.csv("csv_exam.csv")
write.csv(df_csv_exam, file = "df_csv_exam.csv")

load("df_midterm.rda")
save(df_midterm, file = "df_midterm.rda")
