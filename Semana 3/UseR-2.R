######################################################################
###                                                               ####
###    MAF 172 - AULA 4 - INTRODUÇÃO AO PROGRAMA R                ####
###    PROF. GÉRSON SANTOS - gerson.santos@ufv.br                 ####
###                                                               ####
######################################################################

######################################################################
### Mudando o diretorio de trabalho
######################################################################

getwd() # este comando faz isso isso e aquilo
setwd("~/Documents/_______UFV - FLORESTAL/___MAF 172/MAF 172 - AULA 4") 
getwd()

######################################################################
### Carregando os dados
######################################################################

(quali = read.table("quali.txt"))

######################################################################
### Distribuicao de Frequencias e Medidas
######################################################################

attach(quali)
table(quali)
mode(quali)
length(quali[,1])
length(quali)
is.list(quali)

######################################################################
# Criar um vetor das frequencias observadas
######################################################################

(fa=c(8,1,5,4,1,1))
(fr=fa/length(quali[,1]))
(fp=fr*100)
(juntos=c(fa,fr,fp))
(tabela=matrix(juntos,dim(table(quali)),3))
(final=cbind(names(table(quali)),tabela))

par(bg="grey")
barplot(table(quali), col="white", main="Grafico de colunas")

######################################################################
### Explorando a variavel discreta
######################################################################

(x = scan("discreto.txt"))  # Atencao para essa nova forma de carregar dados

is.numeric(x)
range(x)
min(x)
max(x)

table(x)

######################################################################
# Criar um vetor das frequencias observadas
######################################################################

(fa=c(3,4,3,3,4,3))
(fr=fa/20)
(fp=fr*100)
(tabela=c(names(table(x)),fa,fr,fp))
(dft=matrix(tabela,6,4))

par(bg="grey")
barplot(fp, col="white", names.arg=dft[,1], main="Grafico de colunas")
pie(table(x), clockwise=TRUE, labels=fa, main="Grafico de setores - pizza")
pie(table(x), clockwise=TRUE, labels=fr, main="Grafico de setores - pizza")
pie(table(x), clockwise=TRUE, labels=fp, main="Grafico de setores - pizza")

######################################################################
# Medidas de Posicao
######################################################################

mean(x)
median(x)
subset(table(x),table(x)==max(table(x)))

######################################################################
# Medidas de Dispersao
######################################################################

var(x)
sd(x)
(sd(x)/mean(x))*100

######################################################################
# Explorando a variavel continua
######################################################################

(y = scan("continuo.txt"))

is.numeric(y)
range(y)
min(y)
max(y)

(classes=table(cut(y,breaks=seq(min(y)-1.9,max(y)+1.7,by=3.8))))

######################################################################
# Criar um vetor das frequencias observadas
######################################################################

(fa=c(2,3,3,7,9,11,13))
(fr=round(fa/48,4))
(fp=fr*100)
(tabela=c(names(classes),fa,fr,fp))
(dft=matrix(tabela,7,4))

par(bg="grey")
hist(y, breaks=seq(min(y)-1.9,max(y)+1.7,by=3.8), col="white", main="Histograma",
     xlab="Dilatação", ylab="Percentual")

######################################################################
# Medidas de Posicao
######################################################################

mean(y)
median(y)
subset(table(y),table(y)==max(table(y)))

######################################################################
# Medidas de Dispersao
######################################################################

var(y)
sd(y)
(sd(y)/mean(y))*100

######################################################################
### Teste de Normalidade
######################################################################

shapiro.test(y)

######################################################################
### Outras medidas importantes e ignoradas
######################################################################

require(timeDate) # essa função tbm carrega pacotes na memória
kurtosis(y)
skewness(y)
