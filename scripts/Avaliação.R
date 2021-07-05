# # Avaliação 
# # 1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html.
# # 2. Calcule, para cada município do Estado, o total de casos confirmados e o total de óbitos por semana epidemiológica [atenção, você terá de criar uma variável de semana epidemiológica com base na data].
# # 3. Enriqueça a base criada no passo 2 com a população de cada município, usando a tabela6579 do sidra ibge.
# # 4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos por 100.000 habitantes) por município a cada semana epidemiológica.
# 
# library(dplyr)
# 
# 
# # Extração da base Covid PE geral  
# baseCovidPe <- read.csv2("C:/Users/helen/Documents/Mestrado/eletiva_etl_r/bases_originais/baseCovidPE.csv", sep = ';', encoding = 'UTF-8', na.strings=c(""," ","NA"))
# 
# baseCovidPe$dt_notificacao <- as.Date(baseCovidPe$dt_notificacao)# data de notificação no formato data 
# 
# str(baseCovidPe) #formato dos dados 
# 
# library(lubridate)
# 
# baseCovidPe <- baseCovidPe %>% mutate(epiweek(baseCovidPe$dt_notificacao)) %>% mutate(semanaepi = epiweek(baseCovidPe$dt_notificacao)) # criação da variável semana epidemiológica 
# 
# confirmados <- ifelse(grepl("CONFIRMADO",baseCovidPe$classe),"SIM","NÃO") # criação da variável que indica casos confirmados 
# 
# baseCovidPe <- cbind(baseCovidPe,confirmados) #incorporar a variável confirmados à base 
# 
# baseCovidPe$confirmados <- as.factor(baseCovidPe$confirmados)
# 
# obito <- ifelse (grepl("OBITO",baseCovidPe$evolucao),"SIM","NÃO") #criação da variável que indica óbitos
# 
# obito <- as.factor(obito)
# str(obito)
# 
# baseCovidPe <- cbind(baseCovidPe,obito) #incorporar a variável obito à base
# 
# baseCovidPeConfirmados <- baseCovidPe %>% select(dt_notificacao, municipio, cd_municipio,semanaepi,confirmados,obito) %>% group_by(municipio) %>% group_by(semanaepi) %>% count (confirmados) # para cada município do Estado, o total de casos confirmados por semana epidemiológica
# 
# baseCovidPeObitos <- baseCovidPe %>% select(dt_notificacao, municipio, cd_municipio,semanaepi,confirmados,obito) %>% group_by(municipio) %>% group_by(semanaepi) %>% count (obito) # para cada município do Estado, o total de óbitos por semana epidemiológica
# 
# # Extração da base população dos municípios brasileiros 
# library(readxl)
# basePopulacao <- read_excel("C:/Users/helen/Documents/Mestrado/eletiva_etl_r/bases_originais/tabela6579.xlsx")
# 
# populacaoPE <- basePopulacao %>% filter(Estado == "PE") 
#   
# populacaoPE$municipio <- toupper(populacaoPE$municipio)
# 
# baseCovidConfirmados2 <- baseCovidPe %>% filter(confirmados == "SIM") %>%  group_by(semanaepi) %>% group_by(municipio) %>% count(municipio) #casos confirmados "sim" por semana epidemiologica depois por município, na qual n é a quantidade de casos confirmados 
# 
# confirmadosmerged <- left_join(populacaoPE, baseCovidConfirmados2,
#                                by = c("municipio" = "municipio")) %>% mutate(incidencia = n/população/100000)# juntar a base de dados da população com a base de casos confirmados, depois adicionar uma variável chamada incidencia com a taxa de incidência de casos por 100.000 habitantes
# 
# baseCovidObitos2 <- baseCovidPe %>% filter (obito == "SIM") %>%  group_by(semanaepi) %>% group_by(municipio) %>% count(municipio) # óbitos "sim" por semana epidemiologica depois por município, na qual n é a quantidade de óbitos
# 
# obitosmerged <- left_join(populacaoPE, baseCovidObitos2, by = c("municipio" = "municipio")) %>% mutate(letalidade = n/população/100000) # juntar a base de dados da população com a base de óbitos, depois adicionar uma variável chamada letalidade com a taxa de letalidade por 100.000 habitantes


