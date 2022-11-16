---
title: "Prova P2 - MAF 172 - 2022-2"
author: "Erich Müller Dutra - Matrícula 4908"
date: "2022-11-07"
fig_caption: yes
output:
  html_document:
    highlight: pygments
    keep_md: yes
    lib_dir: libs
    mathjax: local
    number_sections: yes
    self_contained: no
    theme: cerulean
    toc: yes
    toc_float:
      collapsed: no
      smooth_scroll: yes
  word_document:
    toc: yes
  pdf_document:
    toc: yes
fig_width: 7
fig_height: 7
editor_options:
  chunk_output_type: console
---

# - Introdução

Nesta seção, estudamos a relação entre diferentes variáveis aplicadas à ciência de dados no R. Neste trabalho, investiguei a relação entre notas de corte para acesso ao curso de administração através do SiSU, investimentos educacionais e população da cidade em questão. Foram coletadas 8 amostras através de dados públicos disponíveis na plataforma do SiSU, portal da transparência e IBGE.

# - Objetivo

A principal motivação é estudar se há relação direta entre dados das localidades e a concorrência para o curso de administração através do SiSU.

# - Descrição das Variáveis

## - Fonte
Os dados coletados foram obtidos através das seguintes fontes:
https://sisu.mec.gov.br/#/relatorio#onepage
https://cidades.ibge.gov.br
https://www.portaltransparencia.gov.br/funcoes/12-educacao?ano=2020

## - Preparação do ambiente
A partir daqui, iremos analisar a relação entre as variáveis. Inicialmente, vamos preparar o ambiente.


```r
# Define o diretório de trabalho
# setwd("~Documents/Erich/GitHub/MAF_172") 

# Instalando dependências
#library(pacman)
#p_load(char=c("DescTools","readxl","janitor", "psych", "corrr", "ggplot2", "dplyr", "caret", "corrplot","spatstat", "maptools", "gstat", "foreign", "geoR","moments","scatterplot3d","tcltk2", "sp", "rgdal", "raster", "doParallel", "GGally"))
```

## - Leitura dos dados
Faremos então a leitura dos dados que estão armazenados em um arquivo de texto (.txt).


```r
# Importando os dados
dados = read.table("../dados_prova.txt", head=T)
str(dados)
```

```
## 'data.frame':	8 obs. of  5 variables:
##  $ NOTACORTE    : num  754 706 733 727 688 ...
##  $ INVESTIMENTO : int  1360782 65865 90000 293600 459714 337270 248592 835479
##  $ NUMHABITANTES: int  6775561 12330000 2722000 1492530 278264 261501 343132 402912
##  $ IDH          : num  0.799 0.805 0.81 0.805 0.694 0.764 0.739 0.72
##  $ CIDADE       : chr  "Rio de Janeiro" "São Paulo" "Belo Horizonte" "Porto Alegre" ...
```

```r
# Leitura dos dados importados
dados.rls = dados[1:4]
names(dados.rls)
```

```
## [1] "NOTACORTE"     "INVESTIMENTO"  "NUMHABITANTES" "IDH"
```


## - Processamento dos dados

