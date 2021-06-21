### Exercício aula 11 

### Trabalhando com textos

library(poliscidata)
library(tidyverse)

?states # banco states {poliscidata}
?state # dados state {datasets}


data("states", package = "poliscidata") # baixa o banco states 

data("state", package = "datasets") # baixa os dados state (state.abb, state.area, state.center, state.division, state.name, state.region, state.x77) 


state.x77 <- as.data.frame(state.x77)  #tranforma o banco state.x77 em dataframe 


glimpse(state.x77) #olhada no bancos

state <- toupper(state.name) # vetor dos nomes dos estados em maíuscula 
state.x77 <- cbind(state.x77,state) # junta os vetores ao banco state.x77 

install.packages("fuzzyjoin")
library(fuzzyjoin)

# Advanced

states_novo <- fuzzyjoin::stringdist_join(state.x77, states, mode='left')

baseC <- fuzzyjoin::distance_join(state.x77, states, mode='left')

# Joining by: "state"
# Error in v1 - v2 : argumento não-numérico para operador binário


# Trabalhando com textos
# Compartilhe com a gente um código criado por você em que você carrega para o R um pdf que tenha alguma data; em seguida, troca as barras "/" das datas por hífens "-", e, por fim, faz a extração das datas usando esse novo padrão.

library(dplyr)
install.packages("pdftools")
library(pdftools)
install.packages("textreadr")
library(textreadr)

# ler pdf

documentoAula <- read_pdf('C:/Users/helen/Documents/Mestrado/eletiva_etl_r/documentos/TPC_Ementa.pdf', ocr = T)

# # agrupar páginas em 1 doc: 1) agrupa por id 2) cria nova coluna colando a coluna texto na mesma linha 3) seleciona apenas colunas de interesse 4) remove duplicata
documentoAula2 <- documentoAula %>% group_by(element_id) %>% mutate(all_text = paste(text, collapse = " | ")) %>% select(element_id, all_text) %>% unique()

# # automatização de conferência: 1) usa função grepl para buscar termos na coluna de texto 2) se os textos forem achados, classifica
documentoAula2$classe <-  ifelse(
  grepl("Disciplina", documentoAula2$all_text) &
    grepl("Leituras", documentoAula2$all_text) &
    grepl("Bibliografia", documentoAula2$all_text), "Ementa", NA)

# também podemos extrair informações de forma automática, como as datas das aulas

( datas <- str_extract_all(documentoAula2$all_text, "\\d{2}/\\d{2}/\\d{4}") )

# modificar a data "/" por "-"

(datas_modificadas <- str_replace_all(string = documentoAula2, "/", "-"))

( datas <- str_extract_all(datas_modificadas, "\\d{2}-\\d{2}-\\d{4}") )


