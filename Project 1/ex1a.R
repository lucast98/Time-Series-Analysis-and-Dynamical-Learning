library(lubridate)
library(zoo)
library(ggplot2)

#importar os dados
mydata <- read.csv("co2_mm_mlo.csv", header = TRUE)
mydata$Data <- paste(mydata$month, mydata$year)
mydata$Data <- parse_date_time(mydata$Data, "%m %Y")
data <- mydata[["Data"]]
trend <- mydata[["trend"]]

#transformando os dados em séries temporais
tsTendencia <- zoo(mydata$trend, mydata$data)

#plotar grafico com ggplot
ss <- subset(mydata)
p <- ggplot(ss, aes(x=data, y=trend)) + geom_line(color="blue") + theme_bw() 
p + ggtitle("Concentrações atmosféricas mensais de CO2\nMauna Loa Observatory, Hawaii") + xlab("Data") + ylab("Concentração")
