#Exercício da primeira aula de Eletiva de dados com R - 05 de abril de 2021


#sumário da base de dados iris 
summary(iris)

#plots da base de dados iris 

plot(iris)

#estrutura da base de dados iris 

str(iris)

# criação de um vetor 
vetor <- c(1, 2, 5) 

#criação de objeto complexo. Criação de um modelo de regressão
regiris <- lm(Sepal.Width  ~ Sepal.Length, iris)
summary (regiris)