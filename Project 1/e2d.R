library(XLConnect)
library(lubridate)
library(zoo)
library(ggplot2)
library(ggcorrplot)

#importar os dados
wb <- loadWorkbook("ipeadata[07-09-2020-02-32].xls")
Matriz <- readWorksheet(wb, sheet = "Séries", startRow = 0, startCol = 0)

#alterar vetor de datas para o formato certo
names(Matriz) <- c("Data", "IBOVESPA")
Matriz$Data <- parse_date_time(Matriz$Data, "%d/%m/%Y")

#calcula o log-retorno
prices = Matriz$IBOVESPA
data <- c(Matriz$Data)
log <- c(NA, diff(log(prices), 1, 1)^2) #calculo do log retorno
newdata <- data.frame(data, log)

#transformando os dados em séries temporais
tsIBOVESPA <- zoo(newdata$log,newdata$data)

#plotar grafico com ggplot2
ss <- subset(newdata, data > as.Date("2005-1-1"))
p <- ggplot(ss, aes(x=data, y=log)) + geom_line(color="blue") + theme_bw() 
p + ggtitle("Log-retornos das ações da IBOVESPA") + xlab("Data") + ylab("IBOVESPA")

newdata$data <- year(newdata$data)
#Matriz$Data <- year(Matriz$Data)

#plotar uma matriz de correlação
corr <- cor(newdata, use="complete.obs")
head(corr[,1:2])
ggcorrplot(corr, method = "circle")
