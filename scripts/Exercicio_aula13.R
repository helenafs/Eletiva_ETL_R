# # Exercício aula 13 - dia 28/06
# 
# # Transformações, textos e datas
# 
# # 1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html
# 
# 
# # Carregar a base dos casos de Covid em Pernambuco e especificar que os espaços em branco são NA com na.strings  
# 
# 
# baseCovidPe <- read.csv2("C:/Users/helen/Documents/Mestrado/eletiva_etl_r/bases_originais/baseCovidPE.csv", sep = ';', encoding = 'UTF-8', na.strings=c(""," ","NA"))
# 
# 
# library(funModeling)
# 
# status(baseCovidPe) # verificar NAs e zeros
# str(baseCovidPe) # estrutura da base 
# 
# # 2. Corrija os NAs da coluna sintomas através de imputação randômica 
# # imputação aleatória na coluna sintomas 
# 
# (baseCovidPe$sintomas<- impute(baseCovidPe$sintomas, "random"))
# 
# status(baseCovidPe) # verificar novamente a quantidade de NA na coluna sintomas
# 
# # 3. Calcule, para cada município do Estado, o total de casos confirmados e negativos
# # casos confirmados e negativos por município em Pernambuco
# 
# library(tidyverse)
# 
# (baseCovidPe$dt_notificacaos<- impute(baseCovidPe$dt_notificacao, "random"))
# 
# basecasosCovidmun <- baseCovidPe %>% group_by(municipio) %>% count(classe) %>% mutate (total_casosMun = n)
# 
# # 4. Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma
# 
# 
# tosse <- ifelse(grepl("TOSSE",baseCovidPe$sintomas),"SIM","NÃO")
#                                          
# str(tosse)
# 
# baseCovidPe <- cbind(baseCovidPe,tosse)
# 
# baseCovidtosse <- baseCovidPe %>% group_by(classe) %>% count(tosse) %>% mutate (total_tosse = n)
# 
# 
# # 5. Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos
# 
# library(zoo)
# 
# baseCovidPe$dt_notificacao <- as.Date(baseCovidPe$dt_notificacao) # modificar a coluna data de string para date
# 
# str(baseCovidPe) # observar a mudança na classe
# 
# # Criar a variável Estado 
# 
# baseCovidPe <- baseCovidPe %>% mutate (estado = "PE")
# 
# baseCovidEstado <- baseCovidPe %>% group_by(estado )%>% group_by(dt_notificacao) %>% count(classe) %>% rename (total_casos = n)
# 
# baseCovidEstado   <- baseCovidEstado  %>% mutate(casosMM7 = round(rollmean(x = total_casos, 7, align = "right", fill = NA))) # média móvel de 7 dias
# 
# 
