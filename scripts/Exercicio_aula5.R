#Exercício aula 5 - 03/05/2021 

#Extrações básicas 

# extrair / carregar arquivos

# arquivos json
install.packages('rjson')
library(rjson)

RotasCiclaveisRecife <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/667cb4cf-fc93-4687-bb8f-431550eeb2db/resource/09bdeffd-61a5-4470-855c-046c9a97ab55/download/malhacicloviaria-conecta-mar2021.geojson" )

RotasCiclaveisRecife <- as.data.frame(RotasCiclaveisRecife)

# arquivos de texto com read.csv2
BikePe <- read.csv2('http://dados.recife.pe.gov.br/dataset/7fac73fa-c0bb-4bae-9c21-2a45b82016a2/resource/e6e4ac72-ff15-4c5a-b149-a1943386c031/download/estacoesbike.csv', sep = ';', encoding = 'UTF-8'
)


# arquivos xml
install.packages('XML')
library(XML)

Ebay <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/auctions/ebay.xml")

#Carga Incremental

library(dplyr)

# carrega base de dados original - dia 04/05 

chamadosTempoReal <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8')

# carrega base de dados para atualização - dia 05/05 

chamadosTempoRealNew <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8') 

# compara usando a chave primária
chamadosTempoRealIncremento <- (!chamadosTempoRealNew$processo_numero %in% chamadosTempoReal$processo_numero)

# compara usando a chave substituta
# criar a chave substituta
chamadosTempoReal$chaveSubstituta = apply(chamadosTempoReal[, c(1,2,4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

chamadosTempoRealNew$chaveSubstituta = apply(chamadosTempoRealNew[, c(1,2,4,5)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))


# comparação linha a linha
setdiff(chamadosTempoRealNew, chamadosTempoReal)

# retorna vetor com incremento
chamadosTempoReal[chamadosTempoRealIncremento,]

# junta base original e incremento
chamadosTempoReal <- rbind(chamadosTempoReal, chamadosTempoReal[chamadosTempoRealIncremento,])

# Scraping


# arquivos html
library(rvest)
library(dplyr)

# tabelas da wikipedia
url <- "https://pt.wikipedia.org/wiki/Lista_de_mulheres_eleitas_como_chefes_de_Estado"

urlTables <- url %>% read_html %>% html_nodes("table")

urlLinks <- url %>% read_html %>% html_nodes("link")

Presidentas <- as.data.frame(html_table(urlTables[2]))