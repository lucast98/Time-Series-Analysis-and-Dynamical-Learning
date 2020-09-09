library(XLConnect)
library(lubridate)
library(zoo)
library(ggplot2)

#importar os dados
#setwd("/home/lucas/")
wb <- loadWorkbook("ipeadata[07-09-2020-02-32].xls")
Matriz <- readWorksheet(wb, sheet = "Séries", startRow = 0, startCol = 0)

#alterar vetor de datas para o formato certo
names(Matriz) <- c("Data", "IBOVESPA")
Matriz$Data <- parse_date_time(Matriz$Data, "%d/%m/%Y")

#transformando os dados em séries temporais
tsIBOVESPA <- zoo(Matriz$IBOVESPA,Matriz$Data)

#plotar grafico com ggplot2
ss <- subset(Matriz, Data > as.Date("2005-1-1"))
p <- ggplot(ss, aes(x=Data, y=IBOVESPA)) + geom_line(color="blue") + theme_bw() 
p + ggtitle("Índice diário de ações da IBOVESPA de 2005 até 2020") + xlab("Data") + ylab("Índice de ações - Ibovespa")
