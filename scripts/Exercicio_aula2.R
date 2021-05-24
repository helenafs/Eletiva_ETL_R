#Exercíos da aula 2 

#Criação do próprio Data frame 

install.packages("eeptools") #instalação do pacote eeptools
library(eeptools) #carregar o pacote 

#Vetor com nomes de presidentas da América
nomePresidenta <- c ("Isabelita Perón", "Cristina Kirchner", "Dilma Rousseff", "Michelle Bachelet", "Laura Chinchilla")

#Vetor com datas de início de mandato 

dataNascimento <- as.Date(c("1931-02-04", "1953-02-19", "1947-12-14", "1951-09-29","1959-03-28"))

#Vetor com duração do mandato, usando a função age_calc do pacote eeptools

idadePresidenta <- round (age_calc(dataNascimento, units = "years")) 

#Data frame com base nos vetores 

listaPresidentas <- data.frame (nome = nomePresidenta, #nome 
                                nascimento = dataNascimento, #nascimento
                                idade = idadePresidenta)


# Simulações e Sequências 

# Criação de variáveis 

#Simulação de uma distribuição Normal 

distNormal <- rnorm (120)
distNormal #Mostrar a distribuição 
hist(distNormal) #histograma

#Simulação de uma distribuição Binomial  

distBinomial <- rbinom(120,1, 0.7)
distBinomial #Mostrar a distribuição 
hist(distBinomial) #histograma

#Simulação de um índex 

index <- seq(1, length(distNormal)) # vetor com índex dos dados, usando a função length para pegar o total de casos


#Código criado com a utilização de técnica bootstrapping

bootsdistNormal10 <- replicate (10, sample(distNormal, 10, replace = TRUE))
bootsdistNormal10

bootsdistNormal100 <- replicate (100, sample(distNormal, 10, replace = TRUE))
bootsdistNormal100

#Calculando com o R

hist(distNormal)

distNormalCentral <- distNormal - mean(distNormal)
hist(distNormalCentral)

# Index e Operadores Lógicos

listaPresidentas [2,3]
a <- 6
b <- 8 
c <- 5 

a < b

#Estruturas de Controle

listaPresidentas$idadedummy <- ifelse(listaPresidentas$idade == '70', 1, 0)#Cria uma variável dummy com base na idade 


#Funções

f <- function(nro) 
{ if(nro < 100) { for(i in 1:nro) { cat("Olá, mundo!\n")} } } 

f(99)

#Repetição - Família Apply 

sapply(listaPresidentas[ ,3],mean)