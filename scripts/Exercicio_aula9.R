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


?nes #remete a explicação do banco nes (help) 

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
