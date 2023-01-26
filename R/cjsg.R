######################## 0) Instalar e baixar pacotes ##########################

# a) Instalando os pacotes necessários

install.packages("remotes")
install.packages("abjutils")
install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("tibble")
# install.packages("tidyr")
# install.packages("readr")
# install.packages("purrr")
# install.packages("dplyr")
# install.packages("stringr")
# install.packages("forcats")
remotes::install_github("jjesusfilho/tjsp")
install_github("jjesusfilho/tjsp")
install.packages("dados")
install.packages("writexl")
install.packages("readxl")

# b) Carregando os pacotes necessários e úteis

library(tjsp)
library(remotes)
library(abjutils)
library(tidyverse)
# library(ggplot2)
# library(tibble)
# library(tidyr)
# library(readr)
# library(purrr)
# library(dplyr)
# library(stringr)
# library(forcats)
library(dados)
library(writexl)
library(readxl)

################ 0) Fazendo o controle versão ###########################
#

usethis::use_git() # Responder com 2 e 2
usethis::use_github() # Responder com 2

# Serve para criar projetos e pacotes e tem muitas funcionalidades relacionadas 
# a pacotes e projetos
# 
# Para atualizar o projeto no GitHub, é necessário fazer três passos
# 1 ) clicar no Git, no lado superior
# direito. Depois seleciona os arquivos que quer que suba faz o Commit e 
# 
# 
# 
# 
# 
############## 1) Baixando as jurisprudências em html ##########################

assunto <- "10431,10433,10434"
classe <- 

tjsp_baixar_cjsg(
  livre = "",     # Verificar se é o caso de colocar o termo "erro médico"
  aspas = FALSE,  # Verificar se é o caso de colocar TRUE, para ter aspas
  classe = "",  # Verificar se vai ser o caso excluir os cumprimentos de sentença
  assunto = "10434", 
  orgao_julgador = "",
  inicio = "01/01/2022",
  fim = "31/12/2022",
  inicio_pb = "",
  fim_pb = "",
  tipo = "A",
  n = NULL,
  diretorio = "data-raw/cjsg"
)

################# 2) Lendo as jurisprudências em html #########################

# a) Criando um objeto chamado "arquivo" com o nome arquivo e a função list.files

arquivos <- list.files("data-raw/cjsg", full.names = TRUE)

# b) Criando um objeto chamado "cjsg" com a função tjsp_ler_cjsg

cjsg <- tjsp_ler_cjsg(arquivos = arquivos, diretorio = ".")

######################## 3) Fazendo contagens ##################################

# a) Quantidade de decisões por ministro

relatores <- count(cjsg, relator)
relatores  

# b) Tipos e quantidades de classes

classes <- count(cjsg, classe)
classes

# c) Tipos e quantidades de assuntos

assuntos_cjsg <- count(cjsg, assunto)
assuntos_cjsg

# d) Quantidade de decisões por comarcas de origem

comarcas_origem <- count(cjsg, comarca)
comarcas_origem

# e) Quantidade de decisões por órgão julgador

orgaos_julgadores <- count(cjsg, orgao_julgador)
orgaos_julgadores

# f) Quantidade de decisões por data de julgamento

data_julgamento <- count(cjsg, data_julgamento)
data_julgamento

################### 4) Classificando e contando as decisões ####################

# a) Classificando as decisoes

cjsg$decisao <- tjsp_classificar_recurso(cjsg$ementa)

decisoes <- count(cjsg, decisao)
decisoes

# b) Contando as decisoes

count(cjsg, decisao, sort = T)

########################### 5) Cruzando os dados ############################

# a) Cruzando os dados dos relatores com as decisoes

decisoes_por_relator <- count(cjsg, relator, decisao, sort = T)
decisoes_por_relator

############################ SALVAR OS DADOS ###################################

saveRDS(cjsg, "data/cjsg.rds")

library(dados)

#
