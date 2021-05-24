# Exercício da aula 4, dia 26/04/21 

# ETL Real
# carrega a base de sinistros de transito do site da PCR, anos 2019, 2020 e 2021

sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

#Sumário das bases
summary(sinistrosRecife2019Raw) 
summary(sinistrosRecife2020Raw)

# adequa a base de 2019 de acordo com a estrutura dos anos de 2020 e 2021 e muda o nome da coluna 1 para data ao invés de DATA

sinistrosRecife2019Raw_1 <- sinistrosRecife2019Raw [, -c(10,11,12)]

names(sinistrosRecife2019Raw_1)[1] <- "data"

# junta as bases de dados com comando rbind (juntas por linhas)

sinistrosRecifeRaw <- rbind(sinistrosRecife2020Raw, sinistrosRecife2021Raw, sinistrosRecife2019Raw_1)


# observa a estrutura dos dados
str(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

str(sinistrosRecifeRaw)

# modifica tipo do acidente de texto para fator

sinistrosRecifeRaw$tipo <- as.factor (sinistrosRecifeRaw$tipo)

# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

#Staging area

ls() # lista todos os objetos no R

# vamos ver quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

ls() # lista todos os objetos no R

# agora, vamos remover

# uso explícito do garbage collector: 
gc()

# rm(list = c('sinistrosRecife2020Raw', 'sinistrosRecife2021Raw'))

# deletando todos os elementos: rm(list = ls())

# deletando todos os elementos, menos os listados: 

rm(list=(ls()[ls()!="sinistrosRecifeRaw"]))

ls ()

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

#Leitura 

#Quando se salva a base em formato nativo do R (.rds) ela ocupa menos espaço é mais eficaz, porém o formato .csv pode ser lido em outros programas. 

install.packages("microbenchmark")

library(microbenchmark)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

# exporta em txt

write.table(sinistrosRecifeRaw,"bases_tratadas/sinistrosRecife.txt")

# carrega base de dados em formato nativo R
sinistrosRecife <- readRDS('bases_tratadas/sinistrosRecife.rds')

# carrega base de dados em formato tabular (.csv) - padrão para interoperabilidade
sinistrosRecife <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';')

# compara os dois processos de exportação, usando a função microbenchmark

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv"), times = 30L)

microbenchmark(a <- readRDS('bases_tratadas/sinistrosRecife.rds'), b <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';'), times = 10L)