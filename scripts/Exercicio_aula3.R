# Exercíos da aula 3

# usar em simulações 
# seta a semente aleatória de geração de dados
# usando a função addTaskCallback deixamos a set.seed fixa, rodando no back

tarefaSemente <- addTaskCallback(function(...) {set.seed(123);TRUE}) # atribui a tarefa à variável tarefaSemente
tarefaSemente # chama a tarefaSemente


# Duas variáveis normais de desvio padrão diferente

vnormal1 <- rnorm(500, mean = 250, sd = 120)
vnormal2 <- rnorm(500, mean = 200, sd = 130) 

# Uma variável de contagem (poisson)

vcontagem <- rpois(500,100)

# Uma variável de contagem com dispersão (binomial negativa)

vbinoneg <- rnbinom(500, 4, prob = 0.8)

# Uma variável binomial (0,1)

vbinon <- rnbinom(500, 5, prob = 0.7)

# uma variável qualitativa que apresenta um valor quando a variável binomial é 0 e outro quando é 1

vquali <- ifelse(vbinon, "TRUE", "FALSE")

# uma variável de index

index <- seq(1, length(vnormal1))

# Criação do próprio Data frame com pelo menos 500 casos

df <- data.frame(vnormal1,vnormal2,vcontagem,vbinoneg,vbinon,vquali,index)
head(df)
summary(df)

# Centralize as variáveis normais. 

centralv1 <- vnormal1 - mean(vnormal1)

centralv2 <- vnormal2 - mean(vnormal2)

# Troque os zeros (0) por um (1) nas variáveis de contagem. 


df$vcontagem <- replace(vcontagem,vcontagem == 1, 0)

df$vcontagem

df$vbinoneg <- replace(vbinoneg, vbinoneg == 1,0)

df$vbinoneg


# Crie um novo data.frame com amostra (100 casos) da base de dados original. 

sample(df,100, replace = TRUE)

# por fim, podemos usar a função removeTaskCallback para remover a tarefa que criamos lá em cima
removeTaskCallback(tarefaSemente)