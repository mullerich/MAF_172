######################################################################
###                                                               ####
###    MAF 172 - AULA 3 - INTRODUÇÃO AO PROGRAMA R                ####
###    PROF. GÉRSON SANTOS - gerson.santos@ufv.br                 ####
###                                                               ####
######################################################################

######################################################################
### Mudando o diretorio de trabalho
######################################################################

getwd() # este comando faz isso isso e aquilo
setwd() 
getwd()

######################################################################
### Operacoes Basicas
######################################################################

a = 1+2+3
a

(b=2-3*4)
(c=3/2+1)
(d=4*3^3)

(e=sqrt(16))  
(f=sqrt(25))
(g=sqrt(20))

(geo=8^(1/3))

(resp1=a+b+c)
(resp2=e*f*g)

ls()  # Este comando eh para listar todas as memorias
  
######################################################################
### Operacoes basicas
######################################################################

sin(0)
sin(pi/2)
cos(pi)
tan(pi/6)

######################################################################
### Analise Combinatoria
######################################################################

factorial(5)
choose(5,2)
factorial(2)*choose(5,2)

######################################################################
### Matrizes
######################################################################

(dados=c(2,3,1,0,-1,0.5)) # foi usado o comando "c" para guardar informacoes
mode(dados)
length(dados)

(M=matrix(dados,2,3))
(matriz=matrix(dados,ncol=3,byrow=T))
dim(M)
summary(M)      # Resumo por coluna
summary(dados)  # Resumo de toda a matriz
t(M)            # transposta da Matriz
t(M)%*%M        # Produto matricial M'M

(data = 1:6)
(matr = matrix(data,2,3,byrow=T))
(teste1 = as.vector(matr))
(teste2 = as.vector(t(matr)))

######################################################################
### Novos Dados
######################################################################

library(fBasics)

(dados=c(2,1,0,1,3,1,1,1,2))
(A=matrix(dados,3,3))
rk(A)
solve(A)
round(solve(A),2)     # Importante comando ROUND
round(solve(A),3)
round(solve(A),4)
signif(solve(A),3)    # Mostra 3 n?meros significativos

det(A)
rank(dados)           # Mostra a mediana da posicao dos valores
sort(A)               # Ordena os valores de A
sort(A, dec=T)

######################################################################
### Elementos Especiais
######################################################################

2/0
0/0
(pesos=c(62,NA,76,93,49))
is.na(pesos)

######################################################################
### Alimentando o R
######################################################################

# Digitando dados direto no R

(direto1=c(1,2,3,4,5))
(direto2=1:10)
(direto3=10:2)
(direto4=seq(1,10,1))
(direto5=seq(1,10,2))
(direto6=seq(10,2,3))      # Observe o erro
(direto7=seq(10,2,-3))
(direto8=rep(1,5))
(direto9=rep(c(2,3),5))
(direto10=c(rep(1,10), rep(3,2)))

######################################################################
# Importando dados digitados em outros programas
######################################################################

(dados1 = read.table("nota1.txt"))
(dados2 = read.table("nota2.txt", head=T))
(dados3 = read.table("nota3.txt", head=T, dec=","))

(dados = read.csv2("nota4.csv", head=T))
mode(dados)
names(dados)
dados$primeira

dados2$turma1
mean(dados2$turma1)

attach(dados2)
mean(turma1)
