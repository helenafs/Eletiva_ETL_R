# Exercício da aula 8 - 24/05/21
# Primeira aula sobre Tydiverse

#Descoberta
#Compartilhe com a gente um código em que você implementa EDA sobre uma base diferentes daquela do exercício.

install.packages("funModeling")
library(funModeling)
library(tidyverse)

#Dataset
library(help = "datasets")
library(help = "datasets") #Datasets

#swiss: Swiss Fertility and Socioeconomic Indicators (1888) Data - Standardized fertility measure and socio-economic indicators for each of 47 French-speaking provinces of Switzerland at about 1888. 

glimpse (swiss) # olhada nos dados
status(swiss) # estrutura dos dados (missing etc)
freq(swiss) # frequência das variáveis fator
plot_num(swiss) # exploração das variáveis numéricas
profiling_num(swiss) # estatísticas das variáveis numéricas



#Estruturação 
# Compartilhe com a gente um código em que você implementa um pivô long to wide ou wide to long.


library(data.table)
library(dplyr)
library(poliscidata)

glimpse(states)

poliscidata::states

base_states <- states %>% pivot_wider(names_from = stateid, values_from = abortion_rank12 )

#Limpeza

glimpse (base_states) # olhada nos dados
status (base_states) # estrutura dos dados (missing etc)
plot_num(base_states) # exploração das variáveis numéricas
profiling_num(base_states) # estatísticas das variáveis numéricas

base_states$demstate06

base_states_filtro <- drop_na(base_states, demstate06)

#Enriquecimento 

#Validação 

