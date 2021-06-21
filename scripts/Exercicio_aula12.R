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


# Datas na Prática - Covid em Pernambuco 

url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' # passar a url para um objeto

covidBR = read.csv2(url, encoding='latin1', sep = ',') # baixar a base de covidBR

covidPE <- subset(covidBR, state == 'PE') # filtrar para Pernambuco

str(covidPE) # observar as classes dos dados

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d") # modificar a coluna data de string para date

str(covidPE) # observar a mudança na classe

covidPE$dia <- seq(1:length(covidPE$date)) # criar um sequencial de dias de acordo com o total de datas para a predição

predDia = data.frame(dia = covidPE$dia) # criar vetor auxiliar de predição

predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+180)) # criar segundo vetor auxiliar 

predDia <- rbind(predDia, predSeq) # juntar os dois 

install.packages("drc")
library(drc) # pacote para predição

fitLL <- drm(deaths ~ dia, fct = LL2.5(),
             data = covidPE, robust = 'mean') # fazendo a predição log-log com a função drm

plot(fitLL, log="", main = "Log logistic") # observando o ajuste

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 

library(plotly) # biblioteca para visualização interativa de dados

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Mortes - Predição") %>% add_trace(x = ~data, y = ~deaths, name = "Mortes - Observadas", mode = 'lines') %>% layout(
  title = 'Predição de Mortes de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Mortes Acumuladas por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

library(zoo) # biblioteca para manipulação de datas e séries temporais

covidPE <- covidPE %>% mutate(newdeathsMM7 = round(rollmean(x = deaths, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPE <- covidPE %>% mutate(deathsL7 = dplyr::lag(deaths, 7)) # valor defasado em 7 dias

plot_ly(covidPE) %>% add_trace(x = ~date, y = ~deaths, type = 'scatter', mode = 'lines', name = "Novas Mortes") %>% add_trace(x = ~date, y = ~newdeathsMM7, name = "Novas Mortes MM7", mode = 'lines') %>% layout(
  title = 'Novas Mortes de COVID19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novas Mortes por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

install.packages("xts")
library(xts)

(covidPETS <- xts(covidPE$deaths, covidPE$date)) # transformar em Série Temporal

str(covidPETS) 

autoplot(covidPETS) # fazer um plot apropriado para o tipo de dado

acf(covidPETS) # a função acf calcula (e por padrão plota) estimativas da autocovariância ou função de autocorrelação




