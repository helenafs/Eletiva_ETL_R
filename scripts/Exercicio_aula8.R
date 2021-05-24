# Exercício da aula 8 - 24/05/21
# Primeira aula sobre Tydiverse

#Descoberta
#Compartilhe com a gente um código em que você implementa EDA sobre uma base diferentes daquela do exercício.

install.packages("funModeling")
library(funModeling)
library(tidyverse)

#Dataset
library(help = "datasets")

#swiss: Swiss Fertility and Socioeconomic Indicators (1888) Data - Standardized fertility measure and socio-economic indicators for each of 47 French-speaking provinces of Switzerland at about 1888. 

glimpse (swiss) # olhada nos dados
status(swiss) # estrutura dos dados (missing etc)
freq(swiss) # frequência das variáveis fator
plot_num(swiss) # exploração das variáveis numéricas
profiling_num(swiss) # estatísticas das variáveis numéricas

#Estruturação 

#Limpeza

#Enriquecimento 

#Validação 

