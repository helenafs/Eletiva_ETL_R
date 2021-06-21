### Exercício aula 12 - dia 21/06

# Introdução a Datas e Tempos
# Crie um objeto próprio de data e tempo, converta pros três formatos de data e tempo, e faça pelo menos 3 extrações de componentes e/ou operações.

library(lubridate)

Sys.timezone () # timezone do computador
Sys.Date() # data do computador
Sys.time() # hora do computador 

# Conversão para data
(data1 <- as.Date(c("2021-06-21 16:52:09", "2021-08-31 00:43:10")))

# Conversão para POSIXct

(data2 <- as.POSIXct(c("2021-06-21 16:52:09", "2021-08-31 00:43:10")))   

# Conversão para POSIXlt

(data3 <- as.POSIXlt(c("2021-06-21 16:52:09", "2021-08-31 00:43:10")))  

unclass(data3)


# Extrações de Componentes

year(data3) # ano

month(data3) # mês

month(data3, label = T) # mês pelo nome usando label = T

wday(data3, label = T, abbr = T) # dia da semana abreviado

isoweek(data3) # semana ISO 8601

epiweek(data3) # semana epidemiológica


### Operações

minhaSequencia <- seq(as.POSIXct("2021-06-21 16:52:09"), as.POSIXct("2021-08-31 00:43:10"), by = "day")  # sequência usando a ideia de intervalo e de período

data3 + minutes(90) # período

data3 + dminutes(90) # duração

meuIntervalo <- as.interval(data3[1], data3[2]) # transforma em intervalo

now() %within% meuIntervalo  # investiga se está dentro do intervalo

table( (minhaSequencia + years(1) ) %within% meuIntervalo ) # observa se a frequência de casos da sequência 1 ano na frente que estão dentro do intervalo


