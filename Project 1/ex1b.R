library(XLConnect)
library(lubridate)
library(zoo)
library(ggplot2)

#importar os dados
wb <- loadWorkbook("ipeadata-pib.xls")
Matriz <- readWorksheet(wb, sheet = "Séries", startRow = 0, startCol = 0)

#alterar vetor de datas para o formato certo
names(Matriz) <- c("Data", "PIB")
Matriz$Data <- parse_date_time(Matriz$Data, "%Y.%m")

#transformando os dados em séries temporais
tsPIB <- zoo(Matriz$PIB,Matriz$Data)

#plotar grafico com ggplot2
ss <- subset(Matriz, Data > as.Date("2000-1-1"))
p <- ggplot(ss, aes(x=Data, y=PIB)) + geom_line(color="blue") + theme_bw() 
p + ggtitle("PIB brasileiro com periodicidade mensal") + xlab("Anos") + ylab("PIB")
