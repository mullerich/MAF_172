
######################################################################
###                                                               ####
###    MAF 172 - AULA 6 - INTRODUÇÃO AO PROGRAMA R                ####
###    PROF. GÉRSON SANTOS - gerson.santos@ufv.br                 ####
###                                                               ####
######################################################################

######################################################################
### Mudando o diretorio de trabalho
######################################################################

getwd() # este comando faz isso isso e aquilo
setwd("~/Documents/_______UFV - FLORESTAL/___MAF 172/MAF 172 - AULA 6") 
getwd()

######################################################################
### Uma nova forma de trabalhar com Pacotes
######################################################################

library(pacman)
p_load(char=c("DescTools","readxl","janitor", "psych", "corrr", 
              "ggplot2", "dplyr", "caret", "corrplot","spatstat",
              "maptools", "gstat", "foreign",
              "geoR","moments","scatterplot3d","tcltk2",
              "sp", "rgdal", "raster", "doParallel", "GGally"))

######################################################################
### Importando os dados
######################################################################

dados = read.table("dados_limpos.txt", head=T)
str(dados)

######################################################################
### Rodando a Regressao em Parte dos Dados
######################################################################

dados.rls = dados[3:22]
names(dados.rls)

######################################################################
### Processamento Paralelo e Matriz de Correlacao
######################################################################

# Processamento em paralelo
cl <- makePSOCKcluster(4)
registerDoParallel(cl)
# Aqui começa o procedimento
df2 <- cor(dados.rls, use = "na.or.complete")
corrplot(df2, order="alphabet", method="circle", tl.pos="td", type="upper", 
         tl.col="black", tl.cex=0.9, tl.srt=45, 
         addCoef.col="orange", addCoefasPercent = TRUE, diag = TRUE,
         sig.level=0.50, p.mat = 1-abs(df2),insig = "blank")
# Aqui termina o procedimento
stopCluster(cl)

######################################################################
### Outra Matriz de Correlacao
######################################################################

cl <- makePSOCKcluster(4); registerDoParallel(cl)
# Aqui começa o procedimento
ggpairs(dados.rls)
# Aqui termina o procedimento
stopCluster(cl)

######################################################################
### Subprocessamento dos Dados
######################################################################

temp.1 = dados.rls[1:10]
temp.2 = dados.rls[11:20]
# Processamento em paralelo
cl <- makePSOCKcluster(4); registerDoParallel(cl)
# Aqui começa o procedimento
ggpairs(temp.1)
ggpairs(temp.2)
# Aqui termina o procedimento
stopCluster(cl)

######################################################################
### Matriz de Correlacao Nao-Linear
######################################################################

par(mfrow=c(1,1))
par(mar=c(8,4,6,4))
# Processamento em paralelo
cl <- makePSOCKcluster(4)
registerDoParallel(cl)
# Aqui começa o procedimento
# Função de Lopez-Paz (2013)
rdc <- function(x,y,k=20,s=1/6,f=sin) {
  set.seed(313)
  x <- cbind(apply(as.matrix(x),2,function(u)rank(u)/length(u)),1)
  y <- cbind(apply(as.matrix(y),2,function(u)rank(u)/length(u)),1)
  x <- s/ncol(x)*x%*%matrix(rnorm(ncol(x)*k),ncol(x))
  y <- s/ncol(y)*y%*%matrix(rnorm(ncol(y)*k),ncol(y))
  cancor(cbind(f(x),1),cbind(f(y),1))$cor[1]
}
# Tabela é o data.frame
tabela = dados.rls
correl_nao_linear <- function (tabela) {
  c = c("peraser")
  mcnl = matrix(nrow = ncol(tabela), ncol = ncol(tabela))  
  for (i in 1:ncol(tabela)) {
    for (j in 1:ncol(tabela)) {
      mcnl[i,j] = rdc(tabela[,i],tabela[,j])
    }
  }
  mcnl =as.data.frame(mcnl)
  colnames(mcnl) = colnames(tabela)
  rownames(mcnl) = colnames(tabela)
  return(mcnl)
}
par(mfrow=c(1,1))
cornl = correl_nao_linear(tabela)
corrplot(as.matrix(cornl),is.corr = F, method="circle", tl.srt=45,
         tl.pos="lt", type="upper",tl.col="black", addCoefasPercent = TRUE,
         sig.level=0.50, addCoef.col="orange")
# Aqui termina o procedimento
stopCluster(cl)

######################################################################
### Analisando 2 Variaveis
######################################################################

resp = dados.rls$v8
explic = dados.rls$v4

######################################################################
### Representacao Grafica
######################################################################

par(mfrow=c(1,1))
plot(explic, resp, main="Diagrama de Dispersão", 
     xlab = "Variável v4", ylab = "Variável v8") 
cov(explic, resp)
cor(explic, resp)

######################################################################
### Estimando
######################################################################

(rls = lm(resp~explic))

######################################################################
### Fazendo predicoes
######################################################################

(pred=predict(rls))
(obs=dados.rls$v8)
compara = cbind(obs, pred, obs-pred)
head(compara)
tail(compara)

######################################################################
### Representação Grafica da Performance
######################################################################

par(mar=c(6,4,4,4))
plot(explic, resp)
abline(rls)
text(10,18,expression("Y = 1,056 + 1,118 X"))

######################################################################
### Analise de Variancia da Regressao
######################################################################

anova(rls)
summary(rls)
names(summary(rls))

######################################################################
### Exportando uma Analise Grafica
######################################################################

jpeg(filename = "exemplo.jpg", width = 480, height = 480, 
     units = "px", pointsize = 12, quality = 100,
     bg = "white")
plot(explic, resp, main="Exemplo de RLS",
     xlab="Variável v4", ylab="Variável v8")
abline(rls)
text(13,18,expression("Y = 1,056 + 1,118 X"))
dev.off()
