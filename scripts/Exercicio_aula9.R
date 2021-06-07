# Exercício da aula 9 

#Tipos e Fatores

reciclagem <- c(1,2,3,4,4,3,3,2,1)
recode <- c(papel = 1, plastico = 2, vidro = 3, metal = 4)

(reciclagem <- factor(reciclagem, levels = recode, labels = names(recode)))