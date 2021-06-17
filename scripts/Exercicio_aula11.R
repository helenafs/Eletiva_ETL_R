### Exercício aula 11 

### Trabalhando com textos

library(poliscidata)
library(tidyverse)

?states # banco states {poliscidata}
?state # dados state {datasets}


data("states", package = "poliscidata") # baixa o banco states 

data("state", package = "datasets") # baixa os dados state (state.abb, state.area, state.center, state.division, state.name, state.region, state.x77) 


state.x77 <- as.data.frame(state.x77)  #tranforma o banco state.x77 em dataframe 


glimpse(state.x77) #olhada nos bancos

state <- toupper(state.name) # vetor dos nomes dos estados em maíuscula 
state.x77 <- cbind(state.x77,state.abb,state.area,state) # junta os vetores ao banco state.x77 

install.packages("fuzzyjoin")
library(fuzzyjoin)

# Advanced
states_novo <- fuzzyjoin::stringdist_join(state.x77, states, mode='left')

# Joining by: "state"
# Erro: Names must be unique.
# x These names are duplicated:
#   * "state.abb" at locations 9 and 12.
# * "state.area" at locations 10 and 13.
# Run `rlang::last_error()` to see where the error occurred.


baseC <- fuzzyjoin::distance_join(state.x77, states, mode='left')

# Joining by: "state"
# Error in v1 - v2 : argumento não-numérico para operador binário

