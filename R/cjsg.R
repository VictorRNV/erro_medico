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
install.packages("quanteda")
install.packages("usethis")
install.packages("DT")

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
library(quanteda)
library(usethis)
library(DT)

################ 0) Fazendo o controle versão ###########################
#

usethis::use_git() # Responder com 2 e 2
usethis::use_github() # Responder com 2

# Serve para criar projetos e pacotes e tem muitas funcionalidades relacionadas 
# a pacotes e projetos
# 
# Para atualizar o projeto no GitHub fora do terminal, é necessário fazer três passos
# 1) Clicar no Git, no lado superior direito. 
# 2) Selecionar os arquivos que quer que suba 
# 3) Fazer o Commit 
# 4) Fazer o push
# 5) Fazer o pull
# 
# Para usar no terminal:
#
# 1) Fazendo o staging: Selecionando os arquivos para atualizar
# git add . #o ponto quer dizer todos os arquivos
#
# 2) Fazendo o commit: atualizando de fato os arquivos
#
# git commit -m "atualização"
#
# 3) Fazendo o push: atualizando o projeto no GitHub
#
# git push -u origin master  
# 
# 4) Fazendo o pull: baixando as atualizações do GitHub
# 
# git pull
#
############## 1) Baixando as jurisprudências em html ##########################

# a) Baixando do ano de 2020 

tjsp_baixar_cjsg(
  livre = "",     
  aspas = FALSE,  
  classe = "",  
  assunto = "10434", 
  orgao_julgador = "",
  inicio = "01/01/2020",
  fim = "31/12/2020",
  inicio_pb = "",
  fim_pb = "",
  tipo = "A",
  n = NULL,
  diretorio = "data-raw/cjsg2020"
)

# a) Baixando do ano de 2021 

tjsp_baixar_cjsg(
  livre = "",     
  aspas = FALSE,  
  classe = "",  
  assunto = "10434", 
  orgao_julgador = "",
  inicio = "01/01/2021",
  fim = "31/12/2021",
  inicio_pb = "",
  fim_pb = "",
  tipo = "A",
  n = NULL,
  diretorio = "data-raw/cjsg2021"
)

# c) Baixando do ano de 2022 

tjsp_baixar_cjsg(
  livre = "",     
  aspas = FALSE,  
  classe = "",  
  assunto = "10434", 
  orgao_julgador = "",
  inicio = "01/01/2022",
  fim = "31/12/2022",
  inicio_pb = "",
  fim_pb = "",
  tipo = "A",
  n = NULL,
  diretorio = "data-raw/cjsg2022"
)

# É possível criar objetos com vários números de classes e assuntos, bem como
# com vários termos para serem colocados na barra de busca, conforme os exemplos
# abaixo
#
# assunto <- "10431,10433,10434"
# classe <- "8714"
# busca <- r'("dano moral" OU "danos morais)'

################# 2) Lendo as jurisprudências em html #########################

# a) Criando um objeto chamado "arquivo" com o nome arquivo e a função list.files

arquivos2020 <- list.files("data-raw/cjsg2020", full.names = TRUE)
arquivos2021 <- list.files("data-raw/cjsg2021", full.names = TRUE)
arquivos2022 <- list.files("data-raw/cjsg2022", full.names = TRUE)

# b) Criando um objeto chamado "cjsg" com a função tjsp_ler_cjsg

cjsg2020 <- tjsp_ler_cjsg(arquivos = arquivos2020, diretorio = ".")
cjsg2021 <- tjsp_ler_cjsg(arquivos = arquivos2021, diretorio = ".")
cjsg2022 <- tjsp_ler_cjsg(arquivos = arquivos2022, diretorio = ".")

############################ SALVAR OS DADOS ###################################

saveRDS(cjsg2020, "data/cjsg2020.rds")
saveRDS(cjsg2021, "data/cjsg2021.rds")
saveRDS(cjsg2022, "data/cjsg2022.rds")

############################# JUNTANDO OS DADOS ################################

# Para juntar os arquivos dos anos de 2020, 2021 e 2022, será necessário seguir
# as duas etapas abaixo
#
arquivos <- list.files("data", full.names = T)
#
# 2) Função map_dfr

cjsg <- map_dfr(arquivos, ~readRDS(.x))

######################## SALVAR OS DADOS QUE JUNTEI ############################
#
saveRDS(cjsg, "data/cjsg.rds")
write_xlsx(cjsg, "data/cjsg.xlsx")
write.csv(cjsg, "data/cjsg.csv")
#
###################### TRANSFORMANDO EM CORPUS O DATAFRAME #####################
#
corpo <- corpus(cjsg, docid = "cdacordao", text_field = "ementa")
#
#
######################## 3) Fazendo contagens ##################################

# a) Quantidade de decisões por ministro

relatores <- count(cjsg, relator)
relatores

# b) Tipos e quantidades de classes

classes <- count(cjsg, classe)
classes

classes <- classes |> 
  mutate(total_classe = sum(n)) |> 
  mutate(porcentagem = n / total_classe * 100)


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

decisoes <- decisoes |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)

# b) Contando as decisoes

count(cjsg, decisao, sort = T)

########################### 5) Cruzando os dados ############################

# a) Cruzando os dados dos relatores com as decisoes (taxa de reforma por relator)

decisoes_por_relator <- cjsg |> 
  group_by(relator) |> 
  count(relator, decisao, sort = T) |>
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes *100)

# b) Cruzando os dados das classes com as decisões

decisoes_por_classe <- count(cjsg, classe, decisao, sort = T)

# b.1) Cruzando os dados das classes com as decisões e comarcas

decisoes_por_classe_comarca <- count(cjsg, classe, decisao,comarca, sort = T)

# c) Cruzando dados das comarcas com as decisões (Taxa de reforma por comarca)

decisoes_por_comarca <- count(cjsg, comarca, decisao, sort = T)

decisoes_por_comarca1 <- cjsg |> 
  group_by(comarca) |> 
  count(comarca, decisao, sort = T) |>
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes *100)

# d) Cruzando dados do orgao julgador com as decisões

decisoes_por_camara <- count(cjsg, orgao_julgador, decisao, sort = T)

decisoes_por_camara1 <- cjsg |> 
  group_by(orgao_julgador) |> 
  count(orgao_julgador, decisao, sort = T) |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)


################ FILTRANDO APENAS PELOS (IM)PROVIDOS E PARCIAIS ##############

cjsg_imp_parc <- cjsg |> 
  filter(str_detect(decisao, "(provido|improvido|parcial|não conhecido)"))

########### FILTRANDO APENAS PELAS APELAÇÕES IMPROVIDAS E PARCIAIS ##############

cjsg_imp_parc_apel <- cjsg_imp_parc |> 
  filter(str_detect(classe, "Apelação Cível"))


################## FILTRANDO APENAS PELOS PROVIDOS E PARCIAIS ##################

cjsg_prov_parc <- cjsg |> 
  filter(str_detect(decisao, "(provido|parcial)"))

cjsg_prov_parc_apel <- cjsg_prov_parc |> 
  filter(str_detect(classe, "Apelação Cível"))

###################### UTILIZANDO REGEX PARA DETECTAR PALAVRAS ################
#
# Exemplo: Procurando por julgados que tem a palavra "erro médico"
# 
cjsg <- cjsg |> 
  mutate(erro_medico = str_detect(ementa, "(?i)erro médico"))
#
# No caso acima, estou pedindo pra detectar se na coluna "ementa" existe a palavra
# "erro médico" escrita ou em minúsculo ou em maiúsculo. E além disso, pediu-se
# para criar uma coluna chamada "erro médico"
#
################### PROCURANDO PELO CONTEXTO DA PALAVRA #######################
#
# Outra forma de procurar a palavra no seu contexto é utilizando a função kwic.
# Para isso, o corpus já tem que ter sido criado. Além disso, é indicada a criação
# de um novo objeto com outro nome para não confundir com os existentes.
#
# Procurando pela palavra "erro" 
#
erro <- kwic(corpo, "erro", window = 10)
#
# Procurando pela palavra médico
#
médico <- kwic(corpo, "médico", window = 10)
#
# Procurando pela palavras falha, óbito, morte, faleceu, causa da morte, 
# erro médico, prova da morte
#
falha <- kwic(corpo, "falha", window = 10)
#
óbito <- kwic(corpo, "óbito", window = 10)
#
morte <- kwic(corpo, "morte", window = 10)
#
faleceu <- kwic(corpo, "faleceu", window = 10)
#
causa_da_morte <- kwic(corpo, phrase("causa da morte"), window = 10)
#
erro_médico <- kwic(corpo, phrase("erro médico"), window = 10)
#
prova_da_morte <- kwic(corpo, phrase("prova da morte"), window = 10)
#
obstetricia <- kwic(corpo, "obstetr", valuetype = "regex", window = 10)
#
especialidade <- kwic(corpo, "especiali", valuetype = "regex", window = 10)
#
dentista <- kwic(corpo, "dentista", window = 10)
# 
estetica <- kwic(corpo, "est[ée]tic", valuetype = "regex", window = 10)
#
evento_adverso <- kwic(corpo, phrase("evento adverso"), window = 10)
#
off_label <- kwic(corpo, "off label", window = 10)
#
hospital <- kwic(corpo, "hospital", window = 10)
#
clinica <- kwic(corpo, "cl[íi]nica", valuetype = "regex", window = 10)
#
parte_clinica <- kwic(partes$parte, "cl[íi]nica", valuetype = "regex", window = 10)
#
parte_hospital <- kwic(partes$parte, "hospital", window = 10)
#
parte_santa_casa <- kwic(partes$parte, phrase("(?i)santa casa"), valuetype = "regex", window = 10)
#
veterinario <- kwic(corpo, "veterin", valuetype = "regex", window = 10)
#
preenchimento_labial <- kwic(corpo, phrase("preenchimento labial"), valuetype = "regex", window = 10)
#
harmonizacao <- kwic(corpo, "harmoniza", valuetype = "regex", window = 10)
#
############################ EXTRAINDO VALORES #################################
#
# CRIANDO A FUNÇÃO OBTER NÚMERO
#
tjsp_obter_valor_max_ementa <- function(ementa) {
    ementa |> 
    stringr::str_extract_all("R\\$[\\s.]?\\d\\S+") |>   
    purrr::map_dbl(~{                          
      .x |>           
        stringr::str_extract(".+?(?=\\D?$)") |>     
        stringr::str_remove_all("(\\.|\\p{L}|\\$|\\s)+") |>  
        stringr::str_replace(",", ".") |>
        as.numeric() |> 
        max(na.rm = TRUE) |>                          
        unique()
  })
}
#
# 3.1 - TESTANDO A FUNÇÃO CRIADA
#
# a) Criando uma coluna chamada valor máximo e atribundo a ela o valor do julgado
#
cjsg <- cjsg |> 
  mutate(valor_maximo = tjsp_obter_valor_max_ementa(ementa))
#
# Salvando o cjsg com a coluna de valores
#
saveRDS(cjsg, "data/cjsg.rds")
#
cjsg_prov_parc_apel <- cjsg_prov_parc_apel |> 
  mutate(valor_maximo = tjsp_obter_valor_max_ementa(ementa))
#
#
# b) Criando um datatable com o número do processo, a ementa, a decisao e o valor
#
datatable(select(cjsg, processo, decisao, ementa, valor_maximo))
#
#
#
###################### CONSULTAR UMA EMENTA ESPECÍFICA #########################

cjsg$ementa[8]
amostra$ementa[4]



################## BAIXANDO INFO DETALHADA DO PROCESSO #########################
#
# O próximo passo é realizar a busca e baixar os htmls dos processos individualmente
# considerados. Considerando que existe um captcha, antes de baixar, o advogado
# precisa se autenticar por meio da função "autenticar()". 
#
# O comando abaixo, baixa todos os processos no diretório atual, mas é possível 
# indicar um diretório de sua escolha.
tjsp_baixar_cposg(tabela$processo)
#
tjsp_baixar_cposg(cjsg$processo, diretorio = "data-raw/cposg")
#
################ LENDO INFORMAÇÕES DETALHADAS DOS PROC. 2º GRAU ################
#
# A leitura dos processos de 2ª instância se dá em 3 etapas, sendo a primeira 
# a leitura dos metadados, a segunda a leitura das informações das partes dos
# processos e a terceira sobre os andamentos dos processos.
#
# 0) Listando os dados num objeto chamado arquivo
#
arquivos_cposg <- list.files("data-raw/cposg", full.names = TRUE)
#
# 1) Lendo os metadados
#
metadados <-tjsp_ler_dados_cposg(diretorio = ".")
#
metadados <-tjsp_ler_dados_cposg(diretorio = "data-raw/cposg")
#
#
saveRDS(metadados, "data/metadados.rds")
write.csv(metadados, "data/metadados.csv")
#
# 2) Lendo as informações sobre as partes
#
partes <- tjsp_ler_partes(diretorio = ".")
#
partes <- tjsp_ler_partes(diretorio = "data-raw/cposg")
#
# Salvando os dados
#
saveRDS(partes, "data/partes.rds")
write.csv(partes, "data/partes.csv")
#
#
# É possível conferir o tipo de parte e contar a quantidade de cada uma
#
unique(partes$tipo_parte)
#
count(partes, tipo_parte, sort = TRUE) |> View()
#
# É possível, ainda, selecionar o tipo de parte que se quer trabalhar. No caso abaixo,
# vamos selecionar apenas as partes Apelantes/Apeladas
#
partes_recurso <- partes |> 
  filter(str_detect(tipo_parte, "(?i)(ap)"))
# 
# Depois, é possível uniformizar a classificação das partes. No código abaixo, 
# estamos comandando o seguinte: Se encontrar uma parte do tipo apelante ou apelada 
#
partes_recurso_uniforme <- partes |> 
  mutate(tipo_parte = case_when{
    str_detect(tipo_parte, "(?i)apelad[oa]") ~ "Apelado"
  })
#
# 3) Lendo os andamentos dos processos
#
andamentos <- tjsp_ler_movimentacao(diretorio = ".")
#
andamentos <- tjsp_ler_movimentacao(diretorio = "data-raw/cposg")
#
#
# Salvando os dados
#
saveRDS(andamentos, "data/andamentos.rds")
write.csv(andamentos, "data/andamentos.csv")
#
#
# 4) Além disso, é possível ler somente a data de entrada do processo no 2º grau
# Isso pode ser útil para calcular o tempo entre a entrada e a decisão. A função
# utilizada para isso é a seguinte:
#
entrada <- ler_entrada(diretorio = "data-raw/cposg")
#
# Por fim, é possível ler o dispositivo da decisão
#
decisao <- tjsp_ler_dispositivo(diretorio = ".")
#
#
######### BAIXANDO E LENDO NA PRÁTICA AS INFORMAÇOES DETALHADAS ###############
#
# Para descobrir as partes, é necessário baixar o PDF. É uma função que sobrecarrega
# o computador e demora.
#
# 1) O primeiro passo é pegar o arquivo cjsg e salvar só o número do processo.
#
processos <- unique(cjsg_tcc$processo)
# 
# A quantidade de julgados provavelmente vai diminuir. Isso porque, existem processos
# que têm mais de um julgado. Exemplo é haver um agravo de instrumento, um embargos de
# declaração e uma apelação. 
#
# 2) o segundo passo é salvar no formato RDS, os números dos processos
#
saveRDS(processos, "data/processos.rds")
#
# 3) O terceiro passo é mandar ler os dados dentro da pasta onde eles se encontram:
#
processos <- readRDS(here::here("data/processos.rds"))


################### CLASSIFICANDO AS PARTES ####################################

partes_tipo <- partes |>
  dplyr::mutate(parte_tipo = dplyr::case_when(
    stringr::str_detect(parte, "(?i)(hospit)") ~ "Hospital",
    stringr::str_detect(parte, "(?i)maternidade") ~ "Maternidade",
    stringr::str_detect(parte, "(?i)santa\\s(?i)casa") ~ "Santa Casa",
    stringr::str_detect(parte, "(?i)cl[íi]nica") ~ "Clínica",
    stringr::str_detect(parte, "(?i)fisiotera") ~ "Fisioterapia",
    stringr::str_detect(parte, "(?i)segur") ~ "Seguradora",
    stringr::str_detect(parte, "(?i)odonto") ~ "Odontologia",
    stringr::str_detect(parte, "(?i)ótica") ~ "Ótica",
    stringr::str_detect(parte, "(?i)laboratório") ~ "Laboratório",
    stringr::str_detect(parte, "(?i)imagem") ~ "Diagnóstico de Imagem",
    stringr::str_detect(parte, "(?i)veterin[áa]ri[oa]") ~ "Hospital Veterinário",
    stringr::str_detect(parte, "(?i)universi[dt]") ~ "Universidade",
    stringr::str_detect(parte, "(?i)associação") ~ "Associação",
    stringr::str_detect(parte, "(?i)fundação") ~ "Fundação",
    stringr::str_detect(parte, "(?i)minist[ée]rio Público") ~ "Ministério Público",
    stringr::str_detect(parte, "(?i)sa[úu]de\\centro") ~ "Centro Médico",
    stringr::str_detect(parte,"(?i)(\\bs[./]?a\\.?$|\\bs\\.\\a\\.|\\bs/a.?\\b|s\\sa$|ltda\\.?|\\bME\\.?\\b|\\bMEI\\.?\\b|\\bEPP\\.?\\b|eirel[ei]|\\bs/?c\\b|companhia|\\bcia\\b)") ~ "PJ",
    TRUE ~  "PF"
  ))
saveRDS(partes_tipo, "data/partes_tipo.rds")

table(partes_tipo$parte_tipo)
unique(partes_tipo$parte_tipo)

############# Tempo das movimentações com o JurisMiner ########################
#
# No código abaixo, vamos pegar o tempo acumulado das movimentações e o tempo
# entre cada movimentação
#
andamentos_tempo <- andamentos |>
  JurisMiner::tempo_movimentacao()
#
# No código abaixo, estamos calculando a duração total do processo
#
duracao_total <- andamentos_tempo |> 
  group_by(processo) |> 
  summarise(duracao = max(decorrencia_acumulada))
#
# É possível encontrar movimentações específicas. Um exemplo seria procurar nas 
# movimentações principais, o "Não-provimento"
#
nao_provimento <- andamentos |> 
  filter(str_detect(principal, "Não-Provimento"))
#
#
############################ VALOR DA AÇÃO 

valor_acao <- count(metadados, valor_da_acao, sort = TRUE) |> View()

##################### ANO DA DECISÃO

cjsg <- cjsg |> 
  mutate(ano_decisao = lubridate::year(data_julgamento))

#
# Transformando os dados da coluna ano_decisao para números ordinais
#
cjsg <- cjsg |> 
  mutate(ano_decisao = factor(ano_decisao, ordered = TRUE))

saveRDS(cjsg, "data/cjsg.rds")

ano_decisao <- table(cjsg$ano_decisao)

######################### ANÁLISE EXPLORATÓRIA DOS DADOS #######################
#
# Por meio da análise exploratória dos dados, nós tiramos insights deles.
#
# Uma das funções mais utilizadas para essa finalidade é o ggplot.
#
ggplot(partes) + 
  geom_bar(aes(x = tipo_parte, fill = tipo_parte))+
  labs(x = "Tipo da Parte", 
       y = "Quantidade",
       title = "Tipos de parte")


######## SELECIONANDO APENAS AS DECISÕES ORIUNDAS DE APELAÇÕES CÍVEIS #########

cjsg_apelacao <- filter(cjsg, classe == "Apelação Cível")

################ CRIANDO GRÁFICOS COM AS PARTES
#
# É possível criar um gráfico com os dados acima com a função ggplot
#
# 1) Tipo de gráfico 1
#
ggplot(partes_tipo) +
  geom_bar(aes (x = parte_tipo, fill = parte_tipo),
           show.legend = FALSE) +
  labs(x = "Tipo de parte",
       y = "Quantidade",
       title = "Quantidade de julgados por tipo de parte",
       caption = "Fonte: TJSP") +
  theme_minimal()
# Tipo de gráfico 2
#
partes_tipo |> 
  count(parte_tipo, sort = TRUE) |> 
  ggplot() +
  geom_bar(aes (x = reorder(parte_tipo, -n), 
                y = n, 
                fill = parte_tipo),
           stat = "identity",
           show.legend = FALSE) +
  scale_fill_viridis_d() +
  labs(x = "Tipo de parte",
       y = "Quantidade",
       title = "Quantidade de julgados por tipo de parte",
       caption = "Fonte: TJSP") +
  theme_minimal()
############# FAZENDO GRÁFICOS INTERATIVOS #####################
#
# Para isso, é necessário instalar o pacote echarts4r
#
install.packages("echarts4r")
library(echarts4r)
#
#
h <- count(partes_tipo, parte_tipo, sort = TRUE)

h |> 
  e_chart(parte_tipo) |> 
  e_bar(n) |> 
  e_tooltip()
#
saveRDS(h, "docs/grafico_partes.RDS")
