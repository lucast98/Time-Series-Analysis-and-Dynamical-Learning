library(XLConnect)
library(lubridate)
library(zoo)
library(ggplot2)
library(e1071)

#importar os dados
wb <- loadWorkbook("ipeadata[07-09-2020-02-32].xls")
Matriz <- readWorksheet(wb, sheet = "Séries", startRow = 0, startCol = 0)

#alterar vetor de datas para o formato certo
names(Matriz) <- c("Data", "IBOVESPA")
Matriz$Data <- parse_date_time(Matriz$Data, "%d/%m/%Y")

#calcula o log-retorno
prices = Matriz$IBOVESPA
data <- c(Matriz$Data)
log <- c(NA, diff(log(prices), 1, 1)) #calculo do log retorno
newdata <- data.frame(data, log)

#plota o histograma dos log-retornos
hist(newdata$log, main = "Histograma dos Log-retornos das ações da IBOVESPA", 
     xlab = "Log-retorno", xlim=c(-0.15, 0.15), col="darkmagenta")

#cálculo da assimetria
skewness(newdata$log, TRUE, 1)

#cálculo da curtose
kurtosis(newdata$log, TRUE, 1)
