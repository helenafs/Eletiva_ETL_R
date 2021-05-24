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
# Compartilhe com a gente um código em que você implementa um pivô long to wide ou wide to long.


library(data.table)
library(dplyr)
library(poliscidata)

poliscidata::states #vendo o banco states do pacote poliscidata

glimpse(states) #olhando o banco states

base_states <- states %>% pivot_wider(names_from = stateid, values_from = abortion_rank12 ) # mudando a estrutura do banco 

#Limpeza

glimpse (base_states) # olhada nos dados
status (base_states) # estrutura dos dados (missing etc)
plot_num(base_states) # exploração das variáveis numéricas
profiling_num(base_states) # estatísticas das variáveis numéricas

base_states$demstate06 # olhando a variável demstate06 

base_states_filtro <- drop_na(base_states, demstate06) #tirando os NA da variável demstate06

#Enriquecimento 

glimpse(state.x77) #base do R

estadosx77 <- state.x77 #criação do dataframe

base_enriquecida <- cbind.data.frame(base_states,estadosx77) #juntando as duas bases


#Validação

glimpse(base_enriquecida$`Life Exp`)

install.packages("validate")
library(validate)

regras_states <- validator (unemploy >= 0)

validaçao_states <- confront (base_enriquecida, regras_states)
summary(validaçao_states)
plot(validaçao_states)