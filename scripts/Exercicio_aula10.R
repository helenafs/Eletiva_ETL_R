# Exercício da aula 10

# Valores Ausentes - Básico

library(data.table)
library(funModeling) 
library(tidyverse) 
library(poliscidata)


# Banco GSS do pacote poliscidata - Conjunto de dados GSS para R Companion do Essentials of Political Analysis, segunda edição
# A Pesquisa é sobre as atitudes e crenças dos indivíduos. 

?gss #informações do banco e das variáveis 

glimpse(gss) #olhada nos dados 
status (gss) # retorna a quantidade e percentual de zeros, NAs e valores infinitos

bancoGss <- gss

# Complete-case analysis – listwise deletion
dim(bancoGssCompleto <- na.omit(bancoGss)) # deixa apenas os casos completos, mas vale a pena? -- Não: [1]   0 221 


## estimando se o NA é MCAR, MAR ou MANR
## Shadow Matrix do livro R in Action

x <- as.data.frame(abs(is.na(bancoGss))) # cria a matrix sombra
head(x) # observa a matriz sombra 

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA
cor(y) # observa a correlação entre variáveis

# Busca padrões entre os valores específicos das variáveis e os NA

cor(bancoGss, y, use="pairwise.complete.obs") # Error in cor(bancoGss, y, use = "pairwise.complete.obs") : 'x' deve ser numérico

data(gss, package = "poliscidata") # importa a base gss - criei só pra conseguir aplicar o segundo exemplo de teste com a shadow matrix 

gss[1:221] <- lapply(gss[1:221], as.numeric) #precisei forçar que as variáveis para se comportarem como numéricas, pois estava dando o erro do comentário que coloquei acima   


# Outliers 

# library(data.table) 

install.packages("plotly")
library(plotly)
library(dplyr)

# Banco states do pacote poliscidata, com dados dos 50 estados dos EUA 

?states 

data("states", package = "poliscidata") # baixa o banco states 


# distância interquartil

plot_ly(y = states$abort_rate05, type = "box", text = states$state, boxpoints = "all", jitter = 0.3)
boxplot.stats(states$abort_rate05)$out

# filtro de Hamper
(lower_bound <- median(states$abort_rate05) - 3 * mad(states$abort_rate05, constant = 1))
(upper_bound <- median(states$abort_rate05) + 3 * mad(states$abort_rate05, constant = 1))
(outlier_ind <- which(states$abort_rate05 < lower_bound | states$abort_rate05 > upper_bound))


