######################################################################
###                                                               ####
###    MAF 172 - AULA 5 - INTRODUÇÃO AO PROGRAMA R                ####
###    PROF. GÉRSON SANTOS - gerson.santos@ufv.br                 ####
###                                                               ####
######################################################################

######################################################################
### Mudando o diretorio de trabalho
######################################################################

getwd() # este comando faz isso isso e aquilo
setwd("~/Documents/_______UFV - FLORESTAL/___MAF 172/MAF 172 - AULA 5") 
getwd()

######################################################################
### Uma nova forma de trabalhar com Pacotes
######################################################################

# install.packages("pacman")
library(pacman)
p_load(char=c("DescTools","readxl","janitor", "psych", "corrr", 
              "ggplot2", "dplyr", "caret", "corrplot","spatstat",
              "maptools", "gstat", "foreign",
              "geoR","moments","scatterplot3d","tcltk2",
              "sp", "rgdal", "raster", "doParallel", "GGally"))

######################################################################
### Carregando os dados
######################################################################

dados.1 = read.csv2("dados-curso.csv", head = T)
dados.2 = read.table("dados-curso.txt", head = T)
dados.3 = read_excel("dados-curso.xlsx", sheet = 1)

######################################################################
### Explorando os dados
######################################################################

mode(dados.1); mode(dados.2); mode(dados.3)
str(dados.1)
str(dados.2)
str(dados.3)
names(dados.3)

######################################################################
### Manipulando dados por coluna
######################################################################

v21 = c(rep(c("classe A","classe B","classe C","classe D"),12), "Classe E")
dados.3 = cbind(dados.3, v21)
dim(dados.3)
names(dados.3)
str(dados.3)
head(dados.3)
tail(dados.3)

######################################################################
### Manipulando dados por linha
######################################################################

dados.3 = rbind(dados.3,rep(NA,23))
tail(dados.3)
dados.3 = na.omit(dados.3)
tail(dados.3)

######################################################################
### Exportando dados
######################################################################

# library(xlsx)
write.csv(dados.3, "dados_limpos.csv")
write.table(dados.3, "dados_limpos.txt")
# write.xlsx(x = dados.3, file = "dados_limpos.xlsx",
#        sheetName = "Teste", row.names = FALSE)


