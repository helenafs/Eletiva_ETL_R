# Exercício da aula 9 

#Tipos e Fatores

reciclagem <- c(1,2,3,4,4,3,3,2,1)
recode <- c(papel = 1, plastico = 2, vidro = 3, metal = 4)

(reciclagem <- factor(reciclagem, levels = recode, labels = names(recode)))

#Mais fatores 

install.packages("ade4")
install.packages("arules")

library(ade4)
library(arules)
library(poliscidata)
library(tidyverse)


?nes #remete à explicação do banco nes (help) 

str(nes) #estrutura do banco nes 

banco <- nes
str(banco)


# filtro por tipo de dado

factorsBanco <- unlist(lapply(banco, is.factor)) 

factorsBanco <- banco[ , factorsBanco]
str(factorsBanco)

# One Hot Encoding 

bancoDummy <- acm.disjonctif (factorsBanco)     

# forcats - usando tidyverse para fatores
# variável econ_ecnow indica a economia atualmente - com 5 níveis: muito bom, bom, nem bom nem ruim, ruim e muito ruim 

fct_count(factorsBanco$econ_ecnow) # conta os fatores

fct_anon(factorsBanco$econ_ecnow) # anonimiza os fatores

fct_lump(factorsBanco$econ_ecnow, n = 1) # reclassifica os fatores em mais comum e outros


# Data Table

library(dplyr)
library(data.table)

?airquality #remete à explicação do banco airquality

QualidadearDT <- airquality %>% setDT()
class(QualidadearDT)

QualidadearDT[Month == '6', ] #i, j, by

QualidadearDT[Month != '6', ]

QualidadearDT[Day > 10 & Month == '5', ]
#ou
QualidadearDT[Month == '5', ][Day > 10, ]

QualidadearDT[.N]

QualidadearDT[(.N-3)]

QualidadearDT[ , Month]

cols <- c("Month", "Wind")
QualidadearDT[ , ..cols]

QualidadearDT[ , .(Temp = mean(Temp, na.rm = T))]

QualidadearDT[ , .(Temp = mean(Temp, na.rm = T)), by = Month]

# Regressão
QualidadearDT[ , lm(formula = Temp ~ Wind + Solar.R)]


# Dplyr

# sumário
count(QualidadearDT, Month) 

# sumário com agrupamento

QualidadearDT %>% group_by(Month) %>% summarise(avg = mean(Temp)) 

# seleção de casos

QualidadearDT %>%  filter(Month != "5") %>% summarise(avg = mean(Temp))

# ordenar casos

arrange(QualidadearDT, Month) # ascendente
arrange(QualidadearDT, desc(Month)) # descendente

### Transformação de Variáveis

# seleção de colunas

QualidadearDT %>% select(Month, Solar.R, Temp) %>% arrange(Month)

# nova colunas

QualidadearDT %>% mutate(Mes = Month)

# renomear
QualidadearDT  %>% rename(TemperaturaF = Temp)