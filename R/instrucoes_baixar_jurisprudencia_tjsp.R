############################ CONSIDERAÇÕES INICIAIS ############################
#
# 1) Criando um projeto
#
# Em primeiro lugar é preciso criar um projeto para o trabalho/estudo que será
# desenvolvido.
# 
# 2) Criando as pastas na aba "Files" do lado inferior direito
#
# É necessário criar as pastas onde serão salvos os arquivos baixados do tribunal
# As pastas a serem criadas serão as seguintes:
#
# a) data-raw: local onde serão colocados os dados brutos. A pasta será criada 
# dentro da pasta principal do projeto
#
# b) cjsg (ou cjpg): que será criada dentro da pasta data-raw para salvar os 
# julgados de primeiro ou segundo grau
#
# c) data: local onde serão colocados os dados limpos, depois de estruturados e 
# processados. 
# Esta pasta será criada dentro da pasta principal do projeto.
#
# d) docs: pasta onde serão colocados os documentos, como os relatórios. Ficará
# na pasta principal do projeto
#
# e) R: pasta onde serão colocados os scripts, ou seja, os códigos que criamos,
# baixamos e utilizamos para analisar os dados. Esta pasta ficará na pasta
# principal do projeto
#
# É possível criar seções no documento. Para isso, vá até "Code" e clique em
# "Insert section"

############################ COMO CITAR ########################################
#
# Para utilizar este código, é necessário citar os seus autores:
#
# Jesus Filho, José de, Trecenti, Júlio (2020) Coleta e organização do Tribunal 
# de Justiça de São Paulo URL https://jjesusfilho.github.io/tjsp

######################### MANTENDO O R SEMPRE ATUALIZADO #######################
# Baixe o arquivo executável do Windows no URL a seguir:
#
# https://github.com/r-lib/rig
# 
# Depois de instalado o programa acima, abra a pesquisa da barra de tarefas do 
# Windows e digite cmd.
#
# Com a caixa de comandos aberta, execute o seguinte código: rig add
# 
# Podemos também, atualizar só os pacotes com a função abaixo
#
update.packages()
#
######################### PACOTES NECESSÁRIOS/ÚTEIS ############################

# Instalando

install.packages("remotes") # O pacote remotes permite instalar pacotes não oficiais
install.packages("abjutils") # Ferramentas para análises jurimétricas usada pela ABJ
install.packages("tidyverse") # É um conjunto de pacotes para fazer o ETL dos dados
install_github("jjesusfilho/tjsp") # O pacote tjsp serve para baixar decisões do tjsp
install.packages("devtools") # É uma ferramenta para desenvolvimento de pacotes
install.packages("quanteda") # Serve para análise e mineração de textos
install.packages("abjData") #
install.packages("future.callr") # Serve para execução de tarefas em segundo plano
install.packages("DT") # Permite criar tabelas dinâmicas interativas 
install.packages("lubridate") # Pacote para manipular e comparar datas
install.packages("survminer") # Serve para fazer análise de sobrevivência
install.packages("r4ses")
install.packages("stringr") # Simplifica a manipulação de strings no R
install.packages("here") # Simplifica a gestão de caminhos de arquivos no R 
install.packages("themis")
devtools::install_github("courtsbr/JurisMiner")
remotes::install_github("jjesusfilho/stf") # Instala o pacote STF
remotes::install_github("jjesusfilho/stj") # Instala o pacote STJ
remotes::install_github("jjesusfilho/trf1") # Instala o pacote TRF-1
remotes::install_github("jjesusfilho/trf3") # Instala o pacote TRF-3
remotes::install_github("jjesusfilho/tjsp") # Junção de remotes com o pacote tjsp

# Carregando

library(tjsp)
library(remotes)
library(abjutils)
library(tidyverse)
library(stf)
library(stj)
library(trf1)
library(trf3)
library(quanteda)
library(usethis)
library(devtools)
library(JurisMiner)
library(abjData)
library(future.callr)
library(readr)
library(tibble)
library(writexl)
library(readxl)
library(here)
library(ggplot2)
library(abjData)
library(dplyr)
library(echarts4r)
library(tinytex)
library(flexdashboard)
library(tidymodels)
library(themis)
library(DT)
library(lubridate)
library(survminer)
library(survival)
library(r4ses)
library(stringr)


# Entendendo

?tjsp
?remotes
?r4ses

# Ao invés de executar os comandos acima para ter acesso à documentação, é possível
# selecionar a função e apertar F1 com ela selecionada.Caso você queira ver o código na 
# íntegra de uma função, é possível seleciona-la e clicar em F2.

###################### FUNÇÕES QUE PODEM SER ÚTEIS #############################


typeof()       # Serve para identificar o tipo de objeto
class()        # Serve para identificar a classe do objeto
is.integer()   # Pergunta se é inteiro
is.numeric()   # Pergunta se é numérico
is.character() # Pergunta se é caractere
as.factor()    # Serve para converter caractere para dado categórico
as.Date()      # Serve para converter caractere para data
as.integer()   # serve para converter para número inteiro
matrix()       # Serve para criar uma matriz
data.frame()   # Serve para criar um dataframe
list()         # Serve para criar uma lista
count()        # Serve para fazer contagens
saveRDS()      # Serve para salvar o ambiente de trabalho
mutate()       # Serve para manipular os dados  
double()       # É um número que tem uma parte inteira e uma parte decimal
autenticar()   # Serve para ser autenticado no TJSP
here()         # Serve para achar onde estão os arquivos do projeto
Sys.time()     # Serve para perguntar ao R que horas são
sqrt()         # Serve para calcular a raiz quadrada
sample()       # Serve para criar uma amostra
function(){}   # Serve para criar funções
kwic()         # Serve para verificar a palavra no seu contexto

# Exemplificando algumas funções.:

# a) Convertendo para inteiros

masculino <- c(T, T, T, T, F, T, T)
as.integer(masculino)

# b) Criando uma matriz

n1 <- 1:15
m <- matrix(n1, ncol = 3)
m

# c) Criando um dataframe

primeiro_nome <- c("Victor", "Lara", "Pedro", "Mariana", "Roberto")
df <- data.frame(nome = primeiro_nome,
                 idade = c(23, 24, 22, 25, 30))
df

# d) Criando uma lista

lista <- list(m, df)
lista

# e) Fazendo uma contagem

relatores <- count(cjsg, relator)
relatores  

classes <- count(cjsg, classe)
classes

assuntos_cjsg <- count(cjsg, assunto)
assuntos_cjsg

comarcas_origem <- count(cjsg, comarca)
comarcas_origem

orgaos_julgadores <- count(cjsg, orgao_julgador)
orgaos_julgadores

data_julgamento <- count(cjsg, data_julgamento)
data_julgamento

# f) Salvando o ambiente de trabalho

saveRDS(cjsg, "data/cjsg.rds")

# g) Criando uma nova coluna chamada decisao e classificando os julgados

cjsg$decisao <- tjsp_classificar_recurso(cjsg$ementa)

######################### FUNÇÕES INFIX #######################################

# são funções que o R cria para tornar as operações mais rápidas.
# Exemplo: a soma e a divisão

3+4
20/4

# Exemplo: o pipe
#
#################################### O PIPE #####################################
# 
# O pipe serve para criar uma cadeia de funções em que uma vai ser executada 
# depois da outra.
#
# Existem dois tipos de pipe. O pipe padrão é o |> e o outro é o %>%
#
# O pipe pode ser chamado com o Ctrl + Shift + m = |> ou %>%
#
# O pipe caminha da esquerda para a direita e de cima para baixo
#
a <- 1:10
a |>
  sum() |> 
  sqrt()

# Para desabilitar o pipe nativo, vá até o Menu Tools, depois clique em Global 
# Options e em Code e desabilite o pipe nativo.


#################################### PACOTES ###################################

# Pacotes são conjuntos de funções que operam organicamente visando um mesmo 
# objetivo ou objetivos similares
#
# O pacote tjsp, por exemplo, é um conjunto de funções
# library(tjsp)
#
# Existem três tipos de pacotes
# 
# 1) Os pacotes que são desenvolvidos e colocados à disposição do público no
# repositório do GitHub
#
# Os pacotes não oficiais podem ser instalados chamando antes a função remotes
# Exemplo:
remotes::install_github("jjesusfilho/tjsp")
#
# Acima temos a função remotes, seguida da função install_github. Nos argumentos,
# temos o nome do autor no GitHub e o nome do pacote a ser instalado
#
# 2) Os pacotes oficiais que ficam no próprio reppsitório do CRAN
# 
# 3) Os pacotes que já vem instalados no R-studio
# 
# O R tem como característica ter muitos pacotes e funções nativos(as) de 
# estatística.


################### OBSERVAÇÕES IMPORTANTES ###################################

# a) Quando se coloca um número entre aspas, o R não reconhece como numeric, ele
# interpreta como texto.

n <- "3"
is.numeric(n)

NULL # Significa objeto inexistente
NA # Significa que o dado existe, mas não sabemos. É um missing value
double() # É um número que tem uma parte inteira e uma parte decimal

# Objeto data: O objeto data é uma combinação de caractere e número. O objeto 
# data é um número por trás, mas aparece como se fosse texto. 
# 
# O formato padrão ISO 8681 adotado pra data é: "2022-12-03" ou seja, vai do maior
# (ano) para o menor (dia) e é separado por hifens.

hoje <- "2022-12-03"   # ANO - MÊS - DIA
ontem <- "2022-12-02"
as.Date(hoje)  
typeof(hoje)   
as.numeric(hoje)
hoje - ontem

################# ENTENDENDO E INSTALANDO O PACOTE TJSP ########################

# Instalando o pacote tjsp:
#
# O pacote TJSP foi desenvolvido pelo professor José de Jesus Filho e está dispo-
# nível no seguinte URL: https://tjsp.consudata.com.br/
# O objetivo do pacote tjsp é baixar e ler as decisões de primeiro e segundo grau
# do Tribunal de Justiça do Estado de São Paulo (TJSP).

install.packages("remotes")
remotes::install_github("jjesusfilho/tjsp")

############################# GRUPOS DE FUNÇÕES ################################ 

# O tjsp tem três grupos de funções

# 1 - O primeiro inicia com o verbo baixar e serve para baixar as decisões num
# diretório indicado pelo usuário, por exemplo.

# 2 - O segundo grupo inicia com o verbo ler e serve para ler as decisões baixa-
# das em HTML e as dispor em tabelas, por exemplo.

# 3 - O terceiro grupo é formado por funções auxiliares de trabalho de transfor
# mação dos dados lidos anteriormente.

################################## SIGLAS ######################################

# cjpg = consulta de julgados de primeiro grau - baixa do banco de sentenças - 
# disponível no seguinte URL: http://esaj.tjsp.jus.br/cjpg/
#
# cjsg = consulta de julgados do segundo grau - baixa jurisprudências do segundo
# grau - disponível no seguinte URL: https://esaj.tjsp.jus.br/cjsg/consultaCompleta.do
#
# cpopg = consulta processual de primeiro grau - baixa a consulta processual de 
# primeiro grau - disponível no seguinte url: https://esaj.tjsp.jus.br/cpopg/open.do
#
# cposg - consulta processual de segundo grau - baixa a consulta processual de
# segundo grau - disponível em: https://esaj.tjsp.jus.br/cposg/open.do

###################### BAIXANDO JURISPRUDÊNCIA #################################

# As decisões de segunda instância podem ser consultadas livremente por meio do 
# seguinte URL: https://esaj.tjsp.jus.br/cjsg/consultaCompleta.do?f=1

# Por exemplo, para realizar uma busca sobre o tema feminicídio, faça o seguinte:

library(tjsp)
baixar_cjsg(livre="feminicídio",diretorio=".")

# Serão baixados metadados das decisões no formato html no diretório indicado
# ou no diretório atual do projeto do R.
#
# Depois de baixados os html's com os metadados, é possível ler essas decisões

tabela <- ler_cjsg(diretorio=".")

############### BAIXANDO DADOS INDIVIDUALIZADOS DOS PROCESSOS ##################

# Depois de baixar e ler os metadados, é possível buscar, e baixar os html's dos 
# processos individualmente considerados. Para isso, será necessário identificar
# -se como advogado, por meio  da função autenticar

autenticar()

# Ao utilizar a função autenticar, você precisará informar as suas credenciais de
# acesso ao TJSP, para que não seja necessário resolver o CAPTCHA.
#
# Feita a autenticação, você pode usar o comando abaixo para baixar os processos
# da tabela no diretório atual ou em algum escolhido por você.

baixar_cposg(tabela$processo)

################# LENDO OS PROCESSOS DE SEGUNDA INSTÂNCIA ######################

# A leitura dos processos de segunda instância ocorre em três etapas. 

# ETAPA 1 - Primeiramente nós lemos os dados:

dados <-ler_dados_cposg(diretorio = ".")

# ETAPA 2 - Depois, lemos as informações sobre as partes

partes <- ler_partes_cposg(diretorio = ".")

# ETAPA 3 - Ao final, lemos os andamentos dos processos

andamento <- ler_movimentacao_cposg(diretorio = ".")

# Se você não quiser ler todo o andamento da decisão, você pode ler somente a data
# de entrada do processo na segunda instância para depois calcular o tempo entre
# esta entrada e a decisão, com a função abaixo

entrada <- ler_entrada_cposg(diretorio = ".")

# Você pode também ler o dispositivo da decisão:

decisao <- ler_decisoes_cposg(diretorio = ".")

################# ENTENDENDO OS PACOTES E FUNÇÕES ##############################

?tjsp_baixar_cjsg

# O pacote acima serve para baixar os metadados da consulta jurisprudencial do 
# TJSP.Ou seja, ele baixa os htmls das decisões de segunda instância

tjsp_baixar_cjsg(
  livre = "",        # Palavra ou texto a ser buscado nas ementas e nos acordaos
  aspas = FALSE,     # lógico. Colocar a expressão entre aspas
  classe = "",       # Código da classe processual
  assunto = "",      # Código do assunto
  orgao_julgador = "",   # Código do órgão julgador
  inicio = "",           # Data inicial do julgamento
  fim = "",              # Data final do julgamento
  inicio_pb = "",        # Data inicial do registro/publicação
  fim_pb = "",           # Data final do registro/publicação
  tipo = "A",            # "A" para acórdãos, "D" para decisões monocráticas 
  n = NULL,              # Número de páginas
  diretorio = "."        # Diretório onde serão armazenadas as páginas html
)

baixar_cjsg(
  livre = "",
  aspas = FALSE,
  classe = "",
  assunto = "",
  orgao_julgador = "",
  inicio = "",
  fim = "",
  inicio_pb = "",
  fim_pb = "",
  tipo = "A",
  n = NULL,
  diretorio = "."
)

# É recomendável, ainda, criar objetos com os códigos correspondentes às classes
# e aos assuntos.Além disso, para maior segurança, você pode fixar o diretório
# que receberá os html's com a função here

# a) Códigos correspondentes às classes: XXXXXXXXXX
# classe <- "XXXX,XXXXX,XXXXXX"
#  
# b) Códigos correspondentes aos assuntos: XXXXXXXXXXX
# assunto <- "YYYYYYY, YYYYY, YYYYYYY"
#
# Assim, você poderia substituir no código abaixo, os números pelo objeto e o
# "." pela função here

tjsp_baixar_cjsg(
  livre = "",       
  aspas = FALSE,    
  classe = classe,       # Código da classe processual preenchido com o objeto
  assunto = assunto,    # Código do assunto processual preenchido com o objeto
  orgao_julgador = "",   
  inicio = "",           
  fim = "",              
  inicio_pb = "",        
  fim_pb = "",           
  tipo = "A",            
  n = NULL,              
  diretorio = here::here("data-raw/cjsg")                 # Fixando o diretório       
)


#################### PRÁTICA - BAIXANDO JURISPRUDÊNCIA #########################

# Os parâmetros de pesquisa utilizados para levantar as informações objeto de 
# pesquisa serão os seguintes: 
#
# i) no campo “Assunto”, foram selecionados os termos # “erro médico” (código 10434), 
# “indenização por dano moral” (código 10433), “responsabilidade civil” (código 
# 10431) e “Direito Civil” (código 899); 
#
# ii) no campo “Data de julgamento”, será selecionado como termo inicial o dia 
# 01 jan. 2021 (01/01/2021) e como termo final o dia 31 dez. 2021 (31/12/2021); 
#
# iii) no campo origem serão selecionadas as caixas “2º grau”; 
#
# iv) no campo Tipo de Publicação será selecionada a Caixa “Acórdãos”.

tjsp_baixar_cjsg(
  livre = "",        
  aspas = TRUE,     
  classe = "",       
  assunto = "10434",     
  orgao_julgador = "",   
  inicio = "",           
  fim = "",             
  inicio_pb = "",       
  fim_pb = "",           
  tipo = "A",            
  n = NULL,              
  diretorio = "."       
)

############### PRÁTICA - PEGANDO O CÓDIGO DO E-SAJ COM INSPECT ################

# 1) Depois de pesquisar a jurisprudência com os parâmetros desejados, é preciso
# clicar com o botão direito na página de resultados e selecionar "Inspect ou 
# Inspecionar"
#
# 2) Depois que for aberta a ferramenta de programação, é necessário clicar na
# aba "NetworK".
#
# 3) Com a aba Network aberta, é necessário clicar novamente na consulta de
# julgados.
#
# 4) Depois que você clicar em consultar novamente, clique em "All" e procure na 
# coluna "name", a linha que está com o nome "resultadoCompleta.do" (será a primeira)
#
# 5) Depois que clicar em "resultadoCompleta.do", clique em Payload, selecione 
# os registros das classes e dos assuntos e cole no código. Esse procedimento 
# pode ser repetido para os outros campos do código.


#################### PRÁTICA - LENDO A JURISPRUDÊNCIA ##########################

# Para ler os arquivos salvos na pasta cjsg no formato html, você vai precisar
# executar duas funções e criar dois objetos. 
#
# a) Criando um objeto chamado "arquivo" com o nome arquivo e a função list.files

arquivos <- list.files("data-raw/cjsg", full.names = TRUE)

# b) Criando um objeto chamado "cjsg" com a função tjsp_ler_cjsg

cjsg <- tjsp_ler_cjsg(arquivos = arquivos, diretorio = ".")

######################## PRÁTICA - CONTANDO ####################################

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

####################### CRIANDO GRÁFICOS PARA OS DADOS ACIMA ###################

# 0) Ordenando as barras do gráfico em ordem decrescente

orgaos_julgadores <- orgaos_julgadores[order(-orgaos_julgadores$n), ]

# 1) Gráfico utilizando a função barplot

barplot(orgaos_julgadores$n, 
        names.arg = orgaos_julgadores$orgao_julgador,
        col = "blue",
        main = "Quantidade de Decisões por Órgão Julgador",
        xlab = "Órgão Julgador",
        ylab = "Quantidade de Decisões")

# 2) Gráfico utilizando a função ggplot

ggplot(orgaos_julgadores, aes(x = orgao_julgador, y = n)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Quantidade de Decisões por Órgão Julgador",
       x = "Órgão Julgador",
       y = "Quantidade de Decisões")

# É possível fazer um corte apresentando somente as 10 primeiras colunas

orgaos_julgadores_10 <- head(orgaos_julgadores, 10)

# Existem duas formas de ordenar as barras do gráfico em ordem decrescente

orgaos_julgadores_10 <- orgaos_julgadores_10 %>% arrange(desc(n))
orgaos_julgadores_10 <- orgaos_julgadores_10[order(-orgaos_julgadores_10$n), ]

# Abreviando a nomemclatura "Câmara de Direito Privado"

orgaos_julgadores_10$orgao_julgador <- gsub("Câmara de Direito", "Câmara", orgaos_julgadores_10$orgao_julgador)
orgaos_julgadores_10$orgao_julgador <- gsub("Privado", "Privada", orgaos_julgadores_10$orgao_julgador)

ggplot(orgaos_julgadores_10, aes(x = reorder(orgao_julgador, -n), y = n)) +
  geom_bar(stat = "identity", fill = "blue") +
  geom_text(aes(label = n), vjust = -0.5, color = "black", size = 4) +
  labs(title = "Quantidade de Decisões por Órgão Julgador",
       x = "Órgão Julgador",
       y = "Quantidade de Decisões")


############## PRÁTICA - CLASSIFICANDO E CONTANDO AS DECISÕES ##################

# a) Classificando as decisoes

cjsg$decisao <- tjsp_classificar_recurso(cjsg$ementa)



# No código acima, na primeira parte, estamos criando uma coluna chamada decisão
# com o código cjsg$decisao
# 
# Na segunda parte, estamos usando uma função do TJSP que classifica as nossas
# decisões e estamos aplicando ela na coluna ementa do dataset cjsg.

# O sinal $ serve para fazer referência a uma coluna do dataset cjsg. No caso
# acima, ele está se referindo à coluna ementa e está criando a coluna decisao
# 
# Assim, quando eu quero criar uma nova coluna, eu coloco primeiro o nome do 
# dataframe (cjsg) e depois o nome da nova coluna (decisao)
#
# Se for colocada uma coluna já existente, ele vai substituit a coluna existente

decisoes <- count(cjsg, decisao)   # Conta as decisões, conforme o seu tipo
decisoes

# b) Contando as decisoes

count(cjsg, decisao, sort = T)

######################## PRÁTICA - CRUZANDO OS DADOS ###########################

# a) Cruzando os dados dos relatores com as decisoes

decisoes_por_relator <- count(cjsg, relator, decisao, sort = T)
decisoes_por_relator


################################# TIDYVERSE ####################################

# Existe um livro disponível online para entender e aprender a usar a função
# tidyverse
# O URL do livro é o seguinte: https://livro.curso-r.com/4-2-tidyverse.html
# 
# O tidyverse é um pacote guarda-chuva que consolida uma série de ferramentas que
# fazem parte do ciclo da ciência de dados. Ele é um pacote que instala outros
# pacotes.
#
# Ele faz todo o ciclo da ciência de dados. Ele permite que os dados sejam 
# importados para o R, que eles sejam arrumados, transformados, visualizados, 
# modelados, comunicados e automatizados.
#
# INSTALANDO E CARREGANDO OS PACOTES DO TIDYVERSE
#
# a) Tidyverse
#
install.packages("tidyverse")
library(tidyverse) # para carregar o tidyverse
#
# b) readr: serve para importar e exportar arquivos do R
# 
install.packages("readr")
library(readr)
#
# c) tibble: serve para fazer algumas operações básicas
#
install.packages("tibble")
library(tibble)
#
# TUTORIAL DE SHINY/STRINGR
#
# https://direito.consudata.com.br/shiny/stringr/
#
# TUTORIAL DE REGEX COM SAMUEL MACEDO
#
# https://www.youtube.com/watch?v=5Tvrq9G2t68



########################### CONTROLE DE FLUXO ##################################
#
# Controle de fluxo no R ocorre quando alguns operadores podem ser utilizados para
# criar operações alternativas
# 
# ITERADORES IF E ELSE
# 
# Exemplificando:
# 
# Vamos criar um vetor de 1 a 10

a <- 5

# E vamos criar a seguinte regra: se um número for maior do que 5, eu vou 
# multiplica-lo por 2. Se um número for menor do que 5, eu vou mutiplica-lo
# por 3.

if (a < 6) {
  
  a*2
  
} else {
  
  a/2
  
}

# Traduzindo a função acima: o objeto a é igual a 2.
# A função diz que se o objeto a for menor do que 6, é para multiplica-lo por 2.
# Caso contrário (se a for maior que 6), é para dividir o a por 2.

b <- 4

if (b==4) {
  sqrt(b)
}
  

# Traduzindo a função acima: o objeto b é igual a 4.
# A função diz que se o objeto b for igual a 4, é para calcular a sua raiz 
# quadrada.


############### FUNÇÕES VETORIZADAS VS FUNÇÕES AGREGADORAS #####################
#
# 1) Funções vetorizadas: Funções vetorizadas são funções que são aplicadas sobre
# cada elemento separada e individualmente.
# Exemplo:sqrt(raiz quadrada)

c <- 1:10
sqrt(c)

# 2) Funções agregadoras: Funções agregadoras, por sua vez, não são aplicadas sobre
# cada elemento. Ela é aplicada sobre o conjunto dos elementos como um todo.
# É um combo.
# Exemplos: sum(soma), mean(média), 

sum(c)
mean(c)

#################################### LOOP ######################################
#
# Loop ou laço de repetição (repetição de uma função). São os iteradores for e 
# while. Eles funcionam na mesma lógica da função vetorizada. Ele aplica uma
# operação sobre cada elemento.
# Exemplo: for

d <- 1:10

for (i in d) {
  
  if (i>5) {
    
    j <- i/2
    
  } else {
    
    j <- i*2
    
  }
  print(j)
}

# Traduzindo a função acima:
#
# for(variable in vector) {
# }
#
# "i" (variable) é o índice que corresponde a cada elemento do objeto 
# d (1,2,3,... 10), ou seja, é a variável sobre a qual a função vetorizada atuará
# individualmente
#
#  "d" (vector) é o objeto que contém as varíaveis, ou seja, é o vetor.
# 
# A função em si quer dizer o seguinte: Se (if) o i for maior do que 5, divida o i 
# por 2 e coloque em j a divisão realizada. 
# Do contrário (else), ou seja, se i for menor do que 5, multiplique o i por 2 e 
# coloque em j a multiplicação realizada.
# E, ao final, imprima as operações em j
# 
# Ela faz um loop ou um laço de repetição com # as variáveis do objeto. 
# Aplica-se, portanto, uma operação sobre cada elemento.
# 
#
#################################### WHILE #####################################
# 
# No while, não se sabe os valores sobre os quais a função vai iterar, porque
# os valores vão sendo criados ao longo da execução da função.
# Por outro lado, no for loop, nós já temos todos os valores que queremos realizar
# a iteração.

i <- 0

while(i < 6){
  print(i*3)
  i <- i+1
}

# Traduzindo a função acima: 
# o valor inicial de i vai ser igual a 0(zero)
# Enquanto i for menor do que 6, imprima i (vezes) 3
# É necessário colocar uma condição clara para que a função não fique rodando 
# infinitamente.
#
#
############################## PACOTE DADOS ###################################
# 
# O pacote dados serve para traduzir outros conjuntos de dados listados no pacote
# 
# Os conjuntos de dados traduzidos servem para treinar a manipulação de dados.
#
######################## MANIPULANDO OS DADOS ##################################
#
# Para aprender a manipular os dados, podem ser utilizados os bancos de dados tra-
# duzidos pelo pacote dados. Além disso, o pacote tidyverse e os seus derivados
# são os ideais para a manipulação.
# 
# Exemplo de banco de dados traduzido pelo pacote dados:
#
voos <- voos
#
# 1) FUNÇÕES IMPORTANTES
#
# a) Função View: serve para abrir os datasets no painel de visualização

View(voos)

# b) Função glimpse: serve para mostrar um resumo do dataset com as informações
# relativas à quantidade de linhas e colunas, os nomes das variáveis e os seus 
# tipos

glimpse(voos)


####################### EXPORTANDO(SALVANDO) OS DADOS ###########################
#
# A exportação de dados serve para exportar os dados do R-Studio para o disco
# do computador.
#
# Para fazer a exportação de maneira correta, é importante verificar se o projeto
# aberto é o correto e se o diretório/pasta de trabalho e pasta de destino também
# são os corretos.
#
# Se você quiser salvar os arquivos em uma pasta diferente da pasta do projeto, 
# é necessário indicar o caminho.
#
# 1) SALVANDO NO FORMATO RDS (FORMATO SERIALIZADO) - FUNÇÃO saveRDS(): 
#
# Este formato é simples e rápido, mas só abre no R

saveRDS(voos, "data/voos.rds")

# Como visto acima, é preciso completar a função com o nome do objeto que você 
# está utilizando (voos). Depois, você abre aspas e completa com caminho (data), 
# seguido do nome que o arquivo terá (voos) e do formato (.rds)
#
# Para ler o arquivo que foi salvo, a função a ser utilizado é a readRDS()

readRDS("data/voos.rds")

# 2) SALVANDO NO FORMATO CSV - FUNÇÕES write.csv() E write_csv()  
#
# Neste tipo de arquivo, o texto é separado por vírgulas.
#
# Para salvar em CSV existem duas maneiras. A primeira delas é pela função do 
# Rbase e a outra é a do pacote readR do Tidyverse
#
# a) função write.csv() do Rbase

write.csv(voos, "data/voos.csv")

# Como visto acima, é preciso completar a função com o nome do objeto que você 
# está utilizando (voos). Depois, você abre aspas e completa com caminho (data), 
# seguido do nome que o arquivo terá (voos) e do formato (.csv)
#
# b) função write_csv() do readr() do pacote Tidyverse
#

write_csv(voos, "data/voos.csv")

# Existe também a função write_delim(), que salva em csv separado por ponto e 
# vírgula, desde que indicado o delimitador no argumento.

write_delim(voos, "data/voos.csv", delim = ";")

#
# Como visto acima, é preciso completar a função com o nome do objeto que você 
# está utilizando (voos). Depois, você abre aspas e completa com caminho (data), 
# seguido do nome que o arquivo terá (voos) e do formato (.csv) e do delimitador
# que deseja. No caso, foi utilizado o delimitador ponto e vírgula.
# 
# Uma outra função que existe para salvar dados no formato CSV é a função
# write_csv2()
#
# 3) SALVANDO NO FORMATO TXT - função write_delim() e 

# O write_delim() pode ser um formato universal quando utilizado pelo separador
# \t e no formato TXT, como no exemplo abaixo:
#

write_delim(voos, "data/voos.txt", delim = "\t")

# Para ler, pode ser utilizada a função readxl



# 4) SALVANDO NO FORMATO XLSX - função writexl()
#
# Para utilizar a função writexl é preciso instalar o seu pacote correspondente
# como também carrega-lo.

library(writexl)
library(readxl)

# Para salvar os arquivos, a função adequada é a write_xlsx

write_xlsx(voos, "data/voos.xlsx")

# Como visto acima, é preciso completar a função com o nome do objeto que você 
# está utilizando (voos). Depois, você abre aspas e completa com caminho (data), 
# seguido do nome que o arquivo terá (voos) e do formato (xlsx).
#
# Para ler os arquivos no formato xlsx (do Excel), a função adequada é a 
# read_excel("data/voos.xlsx)
#
# 5) SALVANDO TODOS OS OBJETOS DE UMA VEZ
#
# Para salvar todos os objetos de uma vez, é necessário clicar no ícone de disquete
# que fica no Enviroment (lado superior direito). Um nome interessante para dar
# ao conjunto de todos estes objetos é "base.RData"
#
# Outra forma é utilizando a função save.image()
#
save.image("data/base.RData")

#
# Os argumentos passados na função save.image() ficam entre aspas e são os seguintes:
# i) o diretório (no exmeplo acima é o data)
# ii) o nome do conjunto de objetos com o seu formato (no exemplo acima é base.RData)
# 
# Para carregar este conjunto de objetos, a função é a load()
# 
load("data/base.RData")

#
################################## PACOTE TIBBLE ###############################
#
# A principal função do tiblle é permitir que um dataframe tenha as características
# de um tibble e não somente de um dataframe. Ser caracterizado como um tibble
# permite que sejam feitas várias operações com o dataframe.
# 
# 
# 1) TER ACESSO A UM RESUMO DO DATAFRAME - função glimpse()
#
# Uma das funções do tibble é a glimpse, que permite ter acesso a um resumo do
# dataframe
#
# 2) DAR UM ID PARA CADA COLUNA - função rownames_to_column()
#
# Com o tibble é possível dar um ID para cada coluna.Para isso, é preciso usar 
# a função rownames_to_column
#

voos <- rownames_to_column(voos, "id")

# o primeiro argumento passado é o objeto a partir do qual vão ser utilizados os
# dados. O segundo argumento é o nome da variável 
#
# 3) CRIAR UMA COLUNA - função add_column()
#

voos <- add_column(voos, uf = "SC")

# O primeiro argumento passado na função é o dataframe em cima do qual vamos
# criar a coluna. O segundo argumento é o nome da coluna que será criada.
# dentro das aspas do segundo argumento, é possível dar o nome de cada linha da 
# coluna. Se for preenchido com apenas um nome, todas as linhas terão esse nome.
# 
# Além disso, como demonstrado abaixo, é possível delimitar antes ou depois de 
# de qual coluna você quer preencher os nomes.
#
voos <- add_column(voos, uf = "SC", .before = 2)

# Ou seja, o terceiro argumento, delimita o local onde será inserida a coluna UF
# 

################### FUNÇÃO DPLYR - TRANSFORMAÇÃO E MANIPULAÇÃO ##################
# 
# Serve para fazer transformações nas tabelas. 
#
# FUNÇÕES BÁSICAS:
#
# As funções mais relevantes e básicas do dplyr são as seguintes:
# 
# select() para selecionar colunas
# 
# rename() serve para renomear colunas
#
# relocate() serve para trocar a ordem de colunas
# 
# filter() para filtrar linhas
#
# count() para gerar frequências
#
# mutate() para transformar colunas ou gerar novas colunas a partir da trans-
# formação de outras
#
# summarize() para gerar sumários/resumos
#
# arrange() para ordenar o dataframe com base em uma ou mais colunas
#
# group_by() serve para usarmos juntamente com outras. Ele agrupa variáveis iguais
#
# 1) A FUNÇÃO SELECT (Para as colunas)
# 
# Para selecionar as colunas ano, mês e dia do dataset voos, é possível selecionar
# citando expressamente o nome da coluna desejada ou o intervalo ou índice que 
# a coluna se encontra
# 
# a) selecionando pelos nomes:
#
s1 <- voos |> 
  select(ano, mes, dia)
#
# b) selecionando pelo índice:
#
s2 <- voos |> 
  select(1,5,6)
#
# c) selecionando pelo intervalo
#
s3 <- voos |> 
  select(1:3)
#
# d) selecionando tudo, menos uma determinada coluna (utiliza o menos)
# 
s4 <- voos |> 
  select(-horario_saida)
#
# e) selecionando as colunas que começam com um determinado radical 
# (argumento = contains)
#  
s5 <- voos |> 
  select(contains("horario"))
#
# f) selecionando as colunas que terminam com determinadas palavras 
# (argumento = ends_with)
#
s6 <- voos |> 
  select(ends_with("hora"))
# 
# g) selecionando e renomeando ao mesmo tempo (utilizar o =)
#
s7 <- voos |> 
  select(year = ano, month = mes, day = dia)
#
#
# 2) A FUNÇÃO RENAME
#
# Serve para renomear no próprio dataset, uma coluna específica, sem selecionar
voos <- voos |> 
  rename(year = ano, month = mes, day = dia)
#
# 3) A FUNÇÃO RELOCATE
#
# A função relocate serve para trocar uma coluna de lugar
#
voos <- voos |> 
  relocate(horario_saida, .before = 1)
#
voos <- voos |> 
  relocate(year, .after = month)
#
#
# 4) A FUNÇÃO FILTER (Para as linhas)
#
# A função filter serve para manipular as linhas. 
#
jfk <- voos |>
  filter(origem == "JFK")
#
# Quando utiliza dois sinais de igual (==) está se fazendo uma comparação e não
# uma atribuição. Exemplo: 3 == 2 (três é igual a 2?)
#
# Na função chamada acima, foram selecionados os dados de todos os voos com origem
# em JFK
#
# Como ver as origens dos voos?
#
unique(voos$origem)
# 
# Para selecionar mais de uma linha, você pode utilizar o ou (|)
#
# Exemplo:
#
jl <- voos |> 
  filter(origem == "JFK" | origem == "LGA")
#
# No exemplo acima foram filtradas as linhas que tem como origem os voos de JFK 
# ou LGA
#
# Existe outra forma de filtar mais de uma linha, com o operador %in%. Existem 
# dois meios de se fazer isso. Um é criando um objeto e o outro é criando um vetor
#
# a) Criando um objeto separado da função
#
aero <- c("JFK", "LGA")
#
jl <- voos |> 
  filter(origem %in% aero)
#
# b) criando uma vetor
#
jl <- voos |> 
  filter(origem %in% c("JFK", "LGA"))
#
# Para filtrar por horário de chegada (horario_chegada) menor do que 9 horas 
#
horario <- voos |>
  filter(horario_chegada < 980)
#
# Filtrando os horários de chegada menores ou iguais a 8 horas
#
horario_8 <- voos |> 
  filter(horario_chegada <= 800)
#
# É possível filtrar utilizando mais de um parâmetro com o operador "&".
#
# Um exemplo seria filtrar por horário e origem
#
h <- voos |> 
  filter(horario_chegada <= 800 & origem == "JFK")
#
# 5) A FUNÇÃO COUNT
# 
# A função count serve para contar e seu uso faz mais sentido com as variáveis
# categóricas.
# 
# Exemplo: contanto as origens dos voos
#
voos |> 
  count(origem)
#
# Exemplo: Contando mais de uma coluna
#
voos |> 
  count(origem, destino)
#
# Exemplo: fazendo ordenações do maior pro menor
#
voos |> 
  count(origem, sort = TRUE)
# 
# É possível nomear a coluna que traz os números utilizando o argumento "name"
#
od <- voos |>
  count(origem, destino, sort = TRUE, name = "frequencia")
#
# 6) A FUNÇÃO MUTATE
#
# Serve para transformar colunas ou criar novas colunas a partir das que já existem 
# ou a partir de outras coisas.
#
# a) Transformando o tipo de dado de coluna para caractere
#
voos <- voos |>
  mutate(year = as.character(year))
#
# b) Multiplicando os dados de uma coluna
#
voos <- voos |> 
  mutate(month = month*2)
#
# c) Criando uma coluna que é a junçao dos dados de duas colunas, de modo que os
# dados fiquem separados por hífen. Além disso, no código, vamos selecionar o 
# local em que a nova coluna ficará.
#
voos <- voos |> 
  mutate(od = paste(origem, destino, sep = "-"), .after = destino)
#
# d) Combinando o mutate com o group_by
#
# No exemplo abaixo, vamos calcular o tempo médio de voo com base na origem. 
# Para isso, vamos seguir os seguintes passos:
#
#                        i) agrupar por origem - group_by(origem)
#                        ii) calcular a média - mean(tempo_voo)
#                        iii) excluir os NA - na.rm = TRUE
#                        iii) colocar a nova coluna depois da coluna tempo_voo
#                        .after = tempo_voo
#
voos <- voos |> 
  group_by(origem) |> 
  mutate(tempo_medio = mean(tempo_voo, na.rm = TRUE),
         .after = tempo_voo)
#
# * A média geral seria calculada pela seguinte função:
#
mean(voos$tempo_voo, na.rm = TRUE)
#
#
# 7) A FUNÇÃO SUMMARIZE
#
# Serve para apresentar pequenos resumos / sumários
#
# a) Combinando o group_by com o summarize
#
sumario <- voos |> 
  drop_na() |>                   #Esta função (drop_na) joga todos os NA fora
  group_by(origem) |> 
  summarize(minimo = min(tempo_voo),
            max = max(tempo_voo),
            media = mean(tempo_voo),
            desvio_padrao = sd(tempo_voo),
            mediana = median(tempo_voo))
#
# 8 - FUNÇÃO ARRANGE
#
# Permite fazer arranjos, isto é, ordenar as linhas. A saída padrão é da menor
# para a maior
#
sumario <- sumario |> 
  arrange(media)
#
# Também é possível ordenar na ordem decrescente
# 
sumario <- sumario |> 
  arrange(desc(media))
#
# É possível, ainda, arranjar por mais de uma coluna.
#
################################ REGEX ########################################
#
# O Regex serve para fazer a identificação de padrões textuais. Ele busca, dentro
# de uma lista de caracteres (uma string), padrões que se repetem
#
# O tutorial completo em texto está aqui: https://direito.consudata.com.br/shiny/stringr/
#
# O tutorial de Regex em vídeo está aqui: https://www.youtube.com/watch?v=5Tvrq9G2t68
#
# O Regex serve, por exemplo, pra procurar por números de CPF, CNPJ, telefone, URL's
# termos ou expressões em acórdãos ou sentenças, endereços, CEP.
#
# A principal função para extração de padrões é o str_extract e sua versão para 
# mais de uma linha, qual seja: str_extract_all
#
#
########################### EXTRAÇÃO - Função str_extract #######################
#
# A função str_extract serve para extrair informações do texto. Para isso, ela 
# pode ser combinada com o Regex
#
# Exemplo: endereço
#
endereco <- c("Avenida Paulista, 458, apto 1070, cep 01500-000, município de 
              São Paulo, estado de são Paulo","rua Padrão, 658, cep 01200-017, 
              Sao Paulo, estado de Sao paulo")
#
# Exemplo: Extraindo o CEP de um endereço
#
str_extract(endereco, "\\d{5}-\\d{3}")
#
# Exemplo: Extraindo a UF de um endereço
#
# a) criando um dataframe no formato tibble com o nome endereço a partir do 
# objeto endereço
#
df <- tibble(endereco = endereco)
#
# 2) criando uma coluna de CEP's com a função mutate
#
df <- df |> 
  mutate(cep = str_extract(endereco, "\\d{5}-\\d{3}"))
#
# 3) Extraindo a UF com o look around. Isto é, procurando um padrão ao redor
#
#
df <- df |> 
  mutate(uf = str_extract(endereco, "(?<=estado de ).+"))
#
# Traduzindo o Regex acima, estamos buscando por tudo que vem depois da expressão
# "estado de ", sem incluir nos resultados a própria expressão "estado de"
#
# Exemplo: Se se quiser extrair da coluna tipo_parte as partes de um processo
#
str_extract(tipo_parte, "(apdo|apda|apelad[oa]|apelante")
#
##################### TROCAR - Função str_replace ##############################
#
# Trocando uma vírgula por um ponto
#
df <- df |> 
  mutate(endereco = str_replace_all(endereco, ",", ";"))
#
###################### REMOVER - Função str_remove #############################
#
# Remova as vírgulas
#
df <- df |> 
  mutate(endereco2 = str_remove_all(endereco, ","))
#
#
#################### DETECTAR/ENCONTRAR Função str_detect ######################
#
# 
str_detect(endereco, "paulo")
#
# Pode ser utilizado o Regex com a finalidade de ignorar as diferenças entre 
# maiúsculo e minúsculo.
#
str_detect(endereco, "(?i)paulo")
#
#
###################### MANIPULANDO A BASE DE DADOS #############################
#
# 1) Como apagar palavras ou expressões das variáveis de uma coluna
#
# Exemplo do 1º grau: Como apagar a palavra "foro" (Foro da Comarca de ...)
#
cjpg <- cjpg |> 
  mutate(foro = str_remove(foro, "Foro (de )?"))
#
# No caso acima, o Regex poderia ser traduzido da seguinte forma:
# Apague a palavra Foro (tanto maiúscula quanto minúscula) e, caso apareça a 
# palavra "de" apague ela também. O caractere ? significa uma coisa opcional.
#
# É possível contar em quantas ementas há a palavra "erro médico"
#
count(cjsg$ementa, "erro médico")
#
# 2) Procurando por palavras dentro do dataset
#
# Exemplo do 2º grau: Procurando por julgados que tem a palavra "erro médico"
# 
cjsg <- cjsg |> 
  mutate(erro_medico = str_detect(ementa, "(?i)erro médico"))
#
# No caso acima, estou pedindo pra detectar se na coluna "ementa" existe a palavra
# "erro médico" escrita ou em minúsculo ou em maiúsculo. E além disso, pediu-se
# para criar uma coluna chamada "erro médico"
#
###################### TRANSFORMANDO EM CORPUS O DATAFRAME #####################
#
# Para transformar o texto em corpus é necessário carregar o pacote quanteda. As
# funções que podem ser utilizadas são duas. A docid e a docid_field
#
corpo <- corpus(cjsg, docid = "cdacordao", text_field = "ementa")
#
corpo <- corpus(cjsg, docid_field = "cdacordao", text_field - "ementa")
#
############################### PACOTE QUANTEDA ############################### 
#
# o pacote quanteda tem a função corpus e a função kwic.
# 
# A função kwic serve para procurar a palavra no seu contexto. Para utiliza-la
# é preciso ter transformado o que se pretende utilizar para pesquisar em corpus
#
erro_medico_teste <- kwic(corpo, phrase("erro médico"), window = 10, valuetype = "regex")
#
cjsg <- cjsg |> 
  mutate(erro_medico = str_detect(ementa, "(?i)(erro médico|erro m[ée]dico)"))
#
# No Regex, o (?i) significa ignorar a diferença entre maiúsculo e minúsculo
# No Regez, o [ée] significa procurar pelo e com ou sem acento
#
#Depois, é possível contar
#
count(cjsg, erro_medico)
#
# Outra forma de procurar a palavra no seu contexto
#
erro_medico2 <- kwic(corpo, "erro", window = 10)
#
laudo <- kwic(corpo, "laudo", window = 10)


################################# PACOTE PURRR #################################
#
# Ele serve para retornar o que queremos. Um exemplo é a função map, que faz algo
# análogo ao loop.E, em conjunto com o map, pode ler e juntar vários datasets.
#
lista_teste <- map(1:10, ~.x*3)
#
floats <-map_dbl(1:10, ~.x*3)
#
inteiros <-map_dbl(1:10, ~{
  (.x*3) |> 
    as.integer()
  }
)

# O til é uma função anônima
#
# É possível utilizar a função map para ler vários datasets em sequência
#
# Para isso, o primeiro passo é listar os nomes de todos esses arquivos
#
a <- list.files("data", full.names = T)
#
# Depois, será utilizada a função map_dfr() para que sejam lidos todos os arquivos
# por meio da função readRDS(), que pode ser feita de 3 formas:
#
df <- map_dfr(a, ~readRDS(.x))
#
df <- map_dfr(a, readRDS)
#
df <- map_dfr(a, ~{
  readRDS(.x)
})
#
############################ EXTRAINDO VALORES #################################
#
valores_arbitrados <- str_extract(cjsg$ementa, "R\\$\\s?\\d\\S+")
#
todos_valores <- str_extract_all(cjsg$ementa, "R\\$\\s?\\d\\S+")
#
# Pegando uma amostra de julgados para serem testados os valores
#
amostra <- cjsg |> 
  sample_n(1000)
#
valor_amostra <- str_extract_all(amostra$ementa, "R\\$\\s?\\d\\S+")
#
# Pegando os valores, transformando em números e pegando o valor máximo:
#
# 1) SEM O DBL, ISTO É, CRIANDO LISTAS
#
valor1 <-amostra$ementa |> 
  str_extract_all("R\\$\\s?\\d\\S+") |>   # utilizando regex para extrair valores
  map(~{                          # falando para o map passar por toda a lista
    .x |>           # falando pro map passar por todos os valores dos itens da lista
      str_extract(".+?(?=\\D?$)") |>  # tirando a vírgula do final
      tjsp::numero() |>              # transformando em número
      max(na.rm = TRUE)   |>           # pegando o valor máximo
      unique()                     # serve para excluir os repetidos
  })
#
# 2) COM O DBL, ISTO É, CRIANDO VETORES
#
valor2 <- amostra$ementa |> 
  str_extract_all("R\\$[\\s.]?\\d\\S+") |>   
  map_dbl(~{                         
    .x |>           
      str_extract(".+?(?=\\D?$)") |>  
      tjsp::numero() |>              
      max(na.rm = TRUE)   |>                          
      unique()
  })
#
#
View(valor)
# 
# 3) OUTRA FORMA - CRIANDO A FUNÇÃO OBTER NÚMERO
#
valor3 <- amostra$ementa |> 
  str_extract_all("R\\$[\\s.]?\\d\\S+") |>   
  map_dbl(~{                          
    .x |>           
      str_extract(".+?(?=\\D?$)") |>     
      stringr::str_remove_all("(\\.|\\p{L}|\\$|\\s)+")  |>  
      stringr::str_replace(",", ".") |>
      as.numeric() |> 
      max(na.rm = TRUE)   |>                          
      unique()
  })
#
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
#
cjsg_prov_parc_apel <- cjsg_prov_parc_apel |> 
  mutate(valor_maximo = tjsp_obter_valor_max_ementa(ementa))
#
#
# b) Criando um datatable com o número do processo, a ementa e o valor
#
datatable(select(amostra, processo, ementa, valor_maximo))
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
# 1) Lendo os metadados
#
dados <-tjsp_ler_dados_cposg(diretorio = ".")
#
# 2) Lendo as informações sobre as partes
#
partes <- tjsp_ler_partes(diretorio = ".")
#
# 3) Lendo os andamentos dos processos
#
andamento <- tjsp_ler_movimentacao_cposg()
#
# 4) Além disso, é possível ler somente a data de entrada do processo no 2º grau
# Isso pode ser útil para calcular o tempo entre a entrada e a decisão. A função
# utilizada para isso é a seguinte:
#
entrada <- ler_entrada(diretorio = "data-raw/cposg")
?ler_entrada
saveRDS(entrada, "data/entrada.rds")
#
######### BAIXANDO INFORMAÇÕES ADICIONAIS DOS PROCESSOS EM SEGUNDO PLANO #######
#
# Para isso, é necessário utilizar o pacote e a função here
#
install.packages("here")
#
library(here)
#
# A função here mostra todo o caminho até a raiz do projeto.
#
# Isso serve para trabalhar de um ponto de partida determinado
#
#!/usr/bin/env Rscript #Esta primeira linha só se aplica a quem tem Mac e Linux
#
# Para os usuários do Windows, é possível começar a partir da linha abaixo:
#
processos <- readRDS("data/processos")
#
# Como o arquivo a ser lido encontra-se na pasta "data" e não na pasta "R", é
# preciso indicar o caminho da pasta que o arquivo "processos" se encontra. Para
# isso, é utilizada a função here
#
processos <- readRDS(here::here("data/processos.rds"))
#
#
# Para facilitar a leitura, é possível dividir a leitura dos dados com o pacote
# JurisMiner e a função dividir_sequencia
#
processos <- JurisMiner::dividir_sequencia(processos, 7)
#
# No caso acima, está se dividindo em 7 partes. Essa divisão na busca é feita com
# o intuito de evitar que dê problema na busca no E-Saj. 
#
# A função walk será utilizada para fazer iterações na busca. Isto é, quando acabar
# a primeira sequência, será inicializada a segunda.
#
purrr::walk(processos, ~{
  
  tjsp::autenticar()
  
  tjsp::tjsp_baixar_cposg(.x, diretorio = here::here("data-raw/cposg"))
  
})
#
# Para não sobrecarregar a máquina, é indicado que o código seja executado no 
# terminal do computador e não no próprio R.
#
# Com o terminal aberto, digite R maiúsculo. Depois, utilize o chmod e digite "+x", 
# que significa o seguinte comando: torne esse arquivo executável.
# Após o "+x" coloque o nome do script que deverá ser executado
#
# R
# chmod +x baixando_segundo_plano_info_detalhada.R
# 
# Depois, dê o comando de baixar, utilizando a função nohup, que significa
# "não pare". E, em seguida, coloque o nome do script.
#
# nohup ./baixando_segundo_plano_info_detalhada.R & 
#
# Existem várias formas de autenticar. Uma é preenchendo o login e a senha no 
# próprio script. A outra é deixar em branco o campo de login e senha para que
# a caixa de diálogo do tribunal seja aberta. E a terceira é por meio da utilização
# do R_environ.
# 
# Para utilizar o R_environ, será utilizado o pacote "usethis()". A função é
# a edit_r_environ("project")
#
# Quando a aba do R_environ for aberta, você deve criar os textos LOGINADV e 
# PASSWORDADV e preencher cada campo, respectivamente com o CPF e senha.
#
# A função é a seguinte:
#
usethis::edit_r_environ("project")
#
# Depois de criado o R_environ, é preciso reiniciar o R para que ele seja reconhecido
#
# O arquivo R-Environ não sobe para o GItHub, caso ele seja adicionado ao .gitignore
# 
#
######################## VISUALIZAÇÃO DE DADOS ##################################
#
# O pacote mais utilizada para visualização de dados é o ggplot2
#
# 1) Carregando os pacotes necessários. Sendo um deles o próprio ggplot2 e o outro
# o pacote da ABJ que tem os dados que serão manipulados e o dplyr:
#
library(ggplot2)
library(abjData)
library(dplyr)
data(package = "abjData")  # Para visualizar as listas de dados do dataset
#
# Se precisar de ajuda para começar, acesse o URL: https://r-graphics.org
#
#
#
# Para demonstrar a utilização da função, será utilizada uma base de dados da ABJ.
# Com ela, será criado um gráfico do IDH x Casos por 100K habitantes.
# 
# A partir da base de dados, vamos aprender a manipular os dados, fazer uma análise
# exploratória e depois criar a visualização dos dados por meio de um gráfico
#
# 2) Transformação dos dados:
#
# Pegaremos apenas uma parte do dataset para fazer as transformações de interesse
#
litigiosidade_plot <- litigiosidade |> 
  filter(justica = "Estadual", ano = 2020) |> 
  transmute(
    tribunal_uf,                    # Aqui foi selecionada a coluna tribunal_uf
    litig = novos / pop * 100000,   # Aqui foi criada uma nova coluna cruzando dados
    idhm                            # Aqui foi definido o idhm no eixo y
  )
#
# 3) Análise exploratória
#
litigiosidade_plot |> 
ggplot() +                           # Cria o fundo
  aes(x = idhm, y = litig) +         # Cria os eixos e a grade no fundo
  geom_point()                       # Cria a forma do gráfico
#
# 4) Otimizando a visualização do gráfico
#
litigiosidade_plot |> 
  ggplot() +
  aes(x = idhm, y = litig) + 
  geom_point(
    color = "darkblue",            # Cor dos pontos
    size = 3                       # Tamanho dos pontos
  ) + 
  geom_smooth(                     # Inserindo uma reta
    method = "lm",
    se = FALSE,
    color = "lightgray"
  ) +                  
  theme_minimal(14) +             # Tamanho da fonte
  labs(
    x = "Índice de Desenvolvimento Humano",                         # Labels
    y = "Litigiosidade\n(casos novos por 100.000 habitantes",
    title = "Litigiosidade e desenvolvimento",
    caption = "Fonte: CNJ e IBGE"
  )

# 5) Outra forma de apresentação - com os nomes das UF's no gráfico:
#
litigiosidade_plot |> 
  ggplot() +
  aes(x = idhm, y = litig) + 
  geom_text(
    aes(label = tribunal_uf),      # Colocando a UF no lugar dos pontos
    color = "darkblue",            # Cor dos pontos
    size = 4                       # Tamanho dos pontos
  ) + 
  geom_smooth(                     # Inserindo uma reta
    method = "lm",
    se = FALSE,
    color = "lightgray"
  ) +                  
  theme_minimal(14) +             # Tamanho da fonte
  labs(
    x = "Índice de Desenvolvimento Humano",                         # Labels
    y = "Litigiosidade\n(casos novos por 100.000 habitantes",
    title = "Litigiosidade e desenvolvimento",
    caption = "Fonte: CNJ e IBGE"
  )
#
#
############################# ÁRVORE DE DECISÃO ################################
#
# Árvore de decisão é um algoritmo de aprendizado de máquina supervisionado, que
# permite calcular a probabilidade de um evento com base no grau de incerteza
# de um atributo em relação ao resultado. Servem para classificar
#
# No direito, ela pode servir para fazer análise de desfecho dos casos. Calcula,
# por exemplo, o conhecimento, o provimento e a procedência
#
# O particionamento da árvore de decisão é realizado sob três orientações:
# 1 - Guloso (greedy)
# 2 - De cima para baixo (top-down)
# 3 - Recursivo (Recursive)
#
# O algoritmo escolhe a variável que vai no tronco e nos nós. Ele elenca as 
# mais importantes variáveis para compor o tronco, isto é, aquelas que têm o menor
# grau de impureza.
#
# Exemplificando com análise de condenação por uso/tráfico de drogas
#
drogas <- jsonlite::fromJSON("https://gist.githubusercontent.com/jjesusfilho/de00e737237fff76a171ed139998dd58/raw/1004d00cac207bd0410c3ed50b0d131bac4402fe/drogas.json")
#
# No caso do exemplo acima, não há nenhum que, presente aquele elmento, e.g., 
# reincidente, a decisão é sempre (100%) condenação ou absolvição. Chamamos esses
# nós de impuros, porque há alguma incerteza sobre eles. Se, por exemplo, casos
# de tráfico que caiam numa determinada vara são todos julgados procedentes,
# dizemos que aquele nó (vara x) é puro, isto é, não há incerteza em torno do
# comportamento daquela vara.
#
# A missão da Jurimetria com a árvore de decisão é calcular o grau de impureza
# de cada nó. Quanto maior a impureza, maior a incerteza envolvendo aquele nó
# (variável) a respeito do desfecho do processo. No jogar de uma moeda por cima,
# o grau de incerteza dela é de 50% por cento.
#
# Um dos métodos mais populares é calcular o valor de Gini. O valor de Gini tem
# esse nome em homenagem ao estatístico italiano Corrado Gini, que contribuiu 
# para a formação desse cálculo e também dá nome ao índice de Gini, que é uma
# medida de desigualdade social. Os dois não são a mesma coisa, mas tem a mesma
# origem. Para mais informações, ver a fórmula do cálculo de incerteza de Gini.

# O cálculo de impureza pode ser feito para cada nó da árvore, ou então para todos
# os nós da árvore. Para calcular a impureza de todos os nós da árvore, calcula-
# se a média ponderada das impurezas.
# 
# Se a impureza de uma variável no novo nó é maior do que a impureza da variável 
# no nó anterior, o nó anterior é mantido como o nó de folha.
#
# A função utilizada para fazer os cálculos de impureza é a "rpart"
#
modelo <- rpart::rpart(decisao ~ droga+camara+gramas+antecedentes, data = drogas)
#
#
########################### IDENTIFICANDO PARTES ###############################
#
#

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
#
###### LENDO OS PROCESSOS NA PASTA DATA RAW ##################
#
# Para ler os processos na pasta data-raw, você pode primeiro listar os dados
#
arquivos_cposg <- list.files("data-raw/cposg", full.names = TRUE)
#
################### PARALELIZANDO A LEITURA DOS DADOS ##########################
#
# Esta é uma outra forma de ler os dados quando a quantidade de dados obtida
# no cposg é muito grande. Nesse sentido, busca-se dividir o dataset em listas
# e paralelizar a leitura com vários workers.
#
# 1) Criando uma lista com a divisão dos dados com o pacote Jurisminer
#
grupos <- JurisMiner::dividir_sequencia(arquivos_cposg, 10)  #dividindo os dados em lista de 19
#
# 2) Paralelizando a leitura com o pacote "future.callr"
#
install.packages("future.callr")
library(future.callr)
#
# A função do pacote callr que pode ser utilizadas para essa finalidade é a "plan"
# com os argumentos "callr" ou "multisession"
#
plan(callr, workers = 6)   # Serão 6 processos trabalhando ao mesmo tempo para ler 
#
# Em seguida, utiliza a função future_map_dfr do pacote furrr para comandar o empilhamento
# dos dados lidos em cada uma das listas criadas. Para isso, a função de leitura
# dos dados do tjsp deverá ser acrescentada. O caminho até os dados que se deseja
# que sejam lidos, também deve ser indicado.
#
df_cposg <- furrr:::future_map_dfr(grupos, ~{
    tjsp::tjsp_ler_dados_cposg(.x, wide = TRUE)
  })
#
# Caso a quantidade de processos seja diferente após a leitura dos dados, em relação
# ao dataset inicial, é possível conferir se todos os processos que estão em um
# também estão no outro
#
#
library(tidyverse)
dt_cposg <- tibble(arquivos)

dt_cposg <- dt_cposg |> 
  mutate(processo = str_extract(arquivos_cposg, "\\d{20}"))

dt-cposg <- dt_cposg |> 
  anti_join(df_cposg)

amostra <- sample(dt_cposg$arquivos,1)

rstudioapi::viewer(amostra)

# O erro pode ter ocorrido na autenticação, caso o html visualizado peça o login
# Se for este o caso, é possível baixar os htmls faltantes
#
tjsp::tjsp_autenticar()

tjsp::tjsp_baixar_cposg(dt_cposg, "data-raw/cposg_faltantes")

# É possível fazer a leitura dos valores máximos dos julgados de forma paralelizada

arquivos_cjsg <- list.files("data/cjsg", full.names = TRUE, pattern = "cjsg")

cjsg <- map_dfr(arquivos_cjsg, ~{
  
  readRDS(.x) |> 
    mutate(valor = tjsp_obter_valor_max(ementa))
})

################## DIVIDINDO OS DADOS E SALVANDO DIVIDIDO ######################

# O primeiro passo é dividir os dados 

lista <- cjsg |> 
  group_split(grupo)


# O segundo passo é utilizar a função walk para salvar

walk2(lista, 1:10, ~saveRDS(.x, paste0("data/cjsg/cjsg",.y,".rds")))
#
############################### PARTES #########################################
#
#
partes <- furrr::future_map_dfr(grupos, ~{
  tjsp::tjsp_ler_partes(.x)
})

saveRDS(partes, "data/cposg/partes.rds")

# É possível conferir o tipo de parte

unique(partes$tipo_parte)

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
# transforme para apelado
#
partes_recurso_uniforme <- partes_recurso |> 
  dplyr::mutate(tipo_parte = dplyr::case_when(
    str_detect(tipo_parte, "(?i)apelad[oa]") ~ "apelado"
    ))
#
# No código acima, é possível utilizar Regex para classificar as partes como pessoa
# física ou jurídica, como algum tipo específico de organização, como banco, entre
# outras formas de classificação. Abaixo, um código de exemplo, que classifica as
# partes como "banco", "seguradora", "hospital", pessoa física ou jurídica:
#
partes <- partes |>
  dplyr::mutate(pessoa = dplyr::case_when(
    stringr::str_detect(parte, "(?i)(banco|finac|cr.edito)") ~ "banco",
    stringr::str_detect(parte, "(?i)(segur)") ~ "seguradora",
    stringr::str_detect(parte,"(?i)(\\bs[./]?a\\.?$|\\bs\\.\\a\\.|\\bs/a.?\\b|s\\sa$|ltda\\.?|\\b[aá]gua\\b|usina|empreend|com[ée]rci|representa|\\bME\\.?\\b|\\bMEI\\.?\\b|\\bEPP\\.?\\b|eirel[ei]|\\bs/?c\\b|companhia|\\bcia\\b)") ~ "PJ",
    TRUE ~ "PF"
  ))
#
# Para conferir se realmente deu certo a uniformização, é possível utilizar a 
# função "unique"
#
unique(partes$tipo_parte)
#
# É possível excluir o representante (advogado) e outros
#
partes$representante <- NULL

#
###################### MOVIMENTAÇÕES ###################################
#
# Lendo as movimentações
#
mov <- furrr::future_map_dfr(grupos, ~{
  tjsp::tjsp_ler_movimentacao(.x)
  })
#
# Separando as movimentações entre principal e secundaria
#
andamentos <- andamentos |> 
  separate(movimentacao, into = c("principal", "secundario"),
           sep = "\n\\s+",
           extra = "merge")
#
# Tempo das movimentações com o JurisMiner
#
# No código abaixo, vamos pegar o tempo acumulado das movimentações e o tempo
# entre cada movimentação
#
andamentos_tempo <- andamentos |>
  JurisMiner::tempo_movimentacao()
#
# No código abaixo, estamos calculando a duração total do processo
#
andamentos_tempo_processo <- andamentos_tempo |> 
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
########## VISUALIZANDO UMA AMOSTRA DOS PROCESSOS - EXPLORANDO OS DADOS ########
#
# A função utilizada para pegar uma amostra é a sample. Ela pode ser utilizada em
# conjunto com a função select. Na função select serão passados como argumentos
# as colunas que desejamos que componham a amostra.
#
amostra <- cjsg |>
  sample_n(20) |> 
  select(processo, ementa)
#
# É possível visualizar os julgados pela web(nvaegados) com o pacote DT e a função
# datatable
#
DT::datatable(amostra)
#
################## ACRESCENTANDO UMA COLUNA SOBRE EXISTÊNCIA DE LAUDO ##########
#
# O código abaixo serve para acrescentar no dataset, uma coluna que vai detectar
# a existência ou inexistência da palavra "laudo" na ementa. Caso a palavra laudo
# exista, a célula será preenchida com a palavra TRUE
#
cjsg <- cjsg |>
  mutate(laudo = str_detect(ementa, "laudo"))
# 
# Contando as ementas que citam a palavra laudo
#
table(cjsg$laudo)
#
View(valores_arbitrados <- str_extract(cjsg$ementa, "R\\$\\s?\\d\\S+"))
#
############## ACRESCENTANDO UMA COLUNA SOBRE VALORES ##########################
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
cjsg <- cjsg |> 
  mutate(valor_maximo = tjsp_obter_valor_max_ementa(ementa))
#
########### CRIANDO UM DATAFRAME APENAS COM AS INFORMAÇÕES DE INTERESSE ########
#
df <- cjsg |>
  select(processo, decisao, valor_maximo)

#
# Retirando o -Inf das colunas
#
df <- df |> 
  filter(valor_maximo != -Inf)
#
View(df)
#
################### TRANSFORMANDO O PARCIAL EM PROCEDENTE ####################
#
df <- df |>
  mutate(decisao = ifelse(decisao == "parcial", "provido", decisao))
#
#
################### INCLUINDO INFORMAÇÕES DOS METADADOS NO DF #################
#
# Inicialmente, é interessante explorar os metadados que se quer manipular. Os
# metadados disponíveis são, por exemplo, o número do processo, a sua situação
# a área, o assunto, a classe, o órgão julgador, a origem, o relator, o revisor
# a seção
#
count(metadados, relator, sort = TRUE) |> View()
#
valor_acao <- count(metadados, valor_da_acao, sort = TRUE) |> View()
# 
count(metadados, orgao_julgador, sort = TRUE) |> View()
#
count(metadados, origem, sort = TRUE) |> View()
# 
################# TRABALHANDO COM DADOS SOBRE OS RELATORES ####################
#
# É interessante criar um dataframe próprio utilizando a função mutate, para 
# trabalhar em cima de metadados como os dados sobre os relatores.
#
# 1) Colocando em caixa alta e tirando os acentos
#
# Uma das primeiras manipulações que podem ser feitas é colocar todos os nomes
# dos relatores em maiúsculo (função toupper) e também tirar os acentos (função
# rm_accent do pacote abjutils)
#
metadados_1 <- metadados |> 
  mutate(relator = toupper(relator) |> abjutils::rm_accent())
#
# 2) Colocando cada tipo de parte em uma coluna com a função pivot_wider - forma 1
#
partes_1 <- partes_tipo |> 
  pivot_wider(names_from = tipo_parte, values_from = pessoa, values_fill = as.list(NA_character_))
View(partes_1)
#
# 2.1) Colocando cada tipo de parte em uma coluna com a função pivot_wider - forma 2
# Esta segunda forma é a ideal
#
partes_2 <- partes_tipo |> 
  select(processo, tipo_parte, parte) |> 
  pivot_wider(names_from = tipo_parte, values_from = parte, values_fill = as.list(NA_character_))
#
# É possível fazer com que as colunas deixem de ser lista. Para isso, é necessário colapsar
# os vetores, como o vetor c("Hospital", "PF"), fazendo com que a palavra hospital e a palavra
# PF fiquem separadas por vírgulas. A função que pode ser utilizada para essa finalidade é a
# função str_c, como feito no exemplo abaixo
#
str_c(c("Hospital", "PF"), collapse = ", ")
#
# Para isso, será necessário ver e prever todos os casos de vetores. 

partes_21 <- partes_2 |>
  mutate(`Apelante:` = map_chr(`Apelante:`, ~{
    str_sort(.x) |>
      unique() |>
      str_c(collapse = ", ")
  }) 
  )

partes_21 <- partes_21 |>
  mutate(`Apelado:` = map_chr(`Apelado:`, ~{
    str_sort(.x) |>
      unique() |>
      str_c(collapse = ", ")
  }) 
  )

partes_21 <- partes_21 |>
  mutate(`Apelada:` = map_chr(`Apelada:`, ~{
    str_sort(.x) |>
      unique() |>
      str_c(collapse = ", ")
  }) 
  )
#
# Depois de converter a lista/vetor em caracteres separados por vírgula, é possível
# escolher apenas um termo para ficar na coluna. Isto é, caso haja PF e hospital, 
# é possível deixar somente hospital. Este processo pode ser repetido para a parte
# apelante, apelada, apelado etc.
#
partes_21 <- partes_21 |> 
  mutate(`Apelante:` = case_when(
    str_detect(`Apelante:`, "Hospital") ~ "Hospital",
    str_detect(`Apelante:`, "Seguradora") ~ "Seguradora",
    str_detect(`Apelante:`, "Hospital Veterinário") ~ "Hospital Veterinário",
    str_detect(`Apelante:`, "Centro de Saúde") ~ "Centro de Saúde",
    str_detect(`Apelante:`, "Santa Casa") ~ "Santa Casa",
    str_detect(`Apelante:`, "Associação") ~ "Associação",
    str_detect(`Apelante:`, "Fundação") ~ "Fundação",
    str_detect(`Apelante:`, "Clínica") ~ "Clínica",
    str_detect(`Apelante:`, "Maternidade") ~ "Maternidade",
    str_detect(`Apelante:`, "Universidade") ~ "Universidade",
    str_detect(`Apelante:`, "Ministério Público") ~ "Ministério Público",
    str_detect(`Apelante:`,  "PJ") ~  "PJ",
    str_detect(`Apelante:`,  "PF") ~  "PF",
  ))
#
partes_21 <- partes_21 |> 
  mutate(`Apelado:` = case_when(
    str_detect(`Apelado:`, "Hospital") ~ "Hospital",
    str_detect(`Apelado:`, "Seguradora") ~ "Seguradora",
    str_detect(`Apelado:`, "Hospital Veterinário") ~ "Hospital Veterinário",
    str_detect(`Apelado:`, "Centro de Saúde") ~ "Centro de Saúde",
    str_detect(`Apelado:`, "Santa Casa") ~ "Santa Casa",
    str_detect(`Apelado:`, "Associação") ~ "Associação",
    str_detect(`Apelado:`, "Fundação") ~ "Fundação",
    str_detect(`Apelado:`, "Clínica") ~ "Clínica",
    str_detect(`Apelado:`, "Maternidade") ~ "Maternidade",
    str_detect(`Apelado:`, "Universidade") ~ "Universidade",
    str_detect(`Apelado:`, "Ministério Público") ~ "Ministério Público",
    str_detect(`Apelado:`,  "PJ") ~  "PJ",
    str_detect(`Apelado:`,  "PF") ~  "PF",
  ))
#
partes_21 <- partes_21 |> 
  mutate(`Apelada:` = case_when(
    str_detect(`Apelada:`, "Hospital") ~ "Hospital",
    str_detect(`Apelada:`, "Seguradora") ~ "Seguradora",
    str_detect(`Apelada:`, "Hospital Veterinário") ~ "Hospital Veterinário",
    str_detect(`Apelada:`, "Centro de Saúde") ~ "Centro de Saúde",
    str_detect(`Apelada:`, "Santa Casa") ~ "Santa Casa",
    str_detect(`Apelada:`, "Associação") ~ "Associação",
    str_detect(`Apelada:`, "Fundação") ~ "Fundação",
    str_detect(`Apelada:`, "Clínica") ~ "Clínica",
    str_detect(`Apelada:`, "Maternidade") ~ "Maternidade",
    str_detect(`Apelada:`, "Universidade") ~ "Universidade",
    str_detect(`Apelada:`, "Ministério Público") ~ "Ministério Público",
    str_detect(`Apelada:`,  "PJ") ~  "PJ",
    str_detect(`Apelada:`,  "PF") ~  "PF",
  ))
#
View(partes_21)
#
# É possível verificar as categorias que existem em cada coluna com a função unique.
#
unique(partes_21$`Apelada:`)
unique(partes_21$`Apelante:`)
#
# É possível, ainda, contar a quantidade de vezes que cada categoria se repete nas 
# colunas com a função table.
#
table(partes_21$`Apelante:`)
table(partes_21$`Apelado:`)
table(partes_21$`Apelada:`)
#
# São várias as categorias, como clínica, fundação, hospital etc. Com a função
# mutate conjugada com a função ifelse é possível colocar todas dentro de uma 
# categoria só
#
partes_21 <- partes_21 |> 
  mutate(`Apelante:` = ifelse(`Apelante:` == "PF", "PF", "PJ"))
#
table(partes_21$`Apelante:`)
#
partes_21 <- partes_21 |> 
  mutate(`Apelado:` = ifelse(`Apelado:` == "PF", "PF", "PJ"))
#
partes_21 <- partes_21 |> 
  mutate(`Apelada:` = ifelse(`Apelada:` == "PF", "PF", "PJ"))
#
table(partes_21$`Apelado:`)
table(partes_21$`Apelada:`)
############################### JUNTANDO OS DADOS NUMA BASE ####################
#
# Anteriormente, foram feitas algumas manipulações nos dados, como a criação de
# uma coluna com os valores máximos e a criação de um dataframe com o nome de df
# apenas com algumas variáveis de interesse como o número do processo, a decisão
# e os valores
#
# a) Criação de uma função para extrair valores
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
# b) criação de uma coluna com os valores extraídos
#
cjsg <- cjsg |> 
  mutate(valor_maximo = tjsp_obter_valor_max_ementa(ementa))
#
# c) Criando uma coluna com o ano da decisao
#
cjsg <- cjsg |> 
  mutate(ano_decisao = lubridate::year(data_julgamento))
#
# Transformando os dados da coluna ano_decisao para números ordinais
#
cjsg <- cjsg |> 
  mutate(ano_decisao = factor(ano_decisao, ordered = TRUE))
#
table(cjsg$ano_decisao)
#
ano_decisao <- View(count(cjsg, ano_decisao, sort = TRUE))
#
#
# d) Seleção de apenas algumas variáveis
#
df <- cjsg |>
  select(processo, orgao_julgador, comarca, decisao, valor_maximo)
#
# e) Retirando o -Inf das colunas
#
df <- df |> 
  filter(valor_maximo != -Inf)
#
View(df)
#
# f) Juntando outras informações no dataframe e criando um novo chamado base
#
base <- df |> 
  inner_join(partes, by = "processo") |> 
  inner_join(select(metadados, processo, relator))
#
# Podemos retirar os NA's
#
base <- base |> 
  drop_na()
#
#
#################### RODANDO UMA REGRESSÃO LOGÍSTICA ###########################
#
# O primeiro passo é transformar a categoria das variáveis preditoras para fator
#
base <- base |> 
  mutate(across(c(decisao, orgao_julgador, relator, comarca, ano_decisao), as.factor))
#
# Depois, nós escolhemos o modelo de interesse
#
modelo <- glm(decisao ~ relator + orgao_julgador + comarca + ano_decisao, family = binomial(), data = base)
#
# É possível colocar algumas variáveis para interagir com o código abaixo, para tentar
# melhorar o modelo, utilizando os dois pontos entre as variáveis.
#
modelo <- glm(decisao ~ comarca:orgao_julgador + relator + ano_decisao, family = binomial(), data = base)

summary(modelo)
#
#
####################### CALCULANDO PROBABILIDADES #############################
#
preditos <- predict(modelo, base, type = "response")
#
base$probabilidade <- preditos
#
base <- base |> 
  mutate(predito = ifelse(probabilidade > .70, "provido", "improvido"))
#
# Calculando os erros e acertos do modelo
#
count(base, decisao, predito)
#
############ COMO RETIRAR OS RELATORES QUE TEM POUCAS DECISÕES #################
#
# O primeiro passo é agrupar por juiz. Ai depois tem uma função que pode ser usada 
# para criar uma coluna com a quantidade de decisões por relator. o script é o seguinte:
#
base <- base |> 
    group_by(relator) |>
  mutate(n = n())
#
# Se quisermos apagar a coluna da quantidade de decisões, é só utilizar a função
# NULL
#
base$n <- NULL
#
# Para filtrar os juízes que tem determinado número de decisões, a função é filter
#
base <- base |> 
  ungroup() |> 
  group_by(relator) |>
  filter(row_number() > 29) |> 
  ungroup()
#
#
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

#
# Para salvar o objeto acima, você pode rodar o seguinte código:
#
tipos_de_parte <- count(partes, tipo_parte, sort = TRUE)
saveRDS(tipos_de_parte, "docs/tipos_de_parte.rds")
#
############################### ANALISANDO ASSUNTOS ############################

library(quanteda)
cjsg <- cjsg |> 
  distinct(cdacordao, keep.all = TRUE)

corpo_assunto <- corpus(cjsg, docid_field = "cdacordao", text_field = "ementa")

laudo <- kwic(corpo_assunto, "laudo")
dano_estetico <- kwic(corpo_assunto, phrase("dano estético"))
amputado <- kwic(corpo_assunto, "amputado")
rosto <- kwic(corpo_assunto, "rosto")
sexual <- kwic(corpo_assunto, "sexual")

# Criando uma coluna para os julgados que mencionam o termo dano estético

cjsg_estetico <- cjsg |> 
  mutate(dano_estetico = str_detect(ementa, "(?i)dano est[ée]tico"))

table(cjsg_estetico$dano_estetico)

dano_estetico <- cjsg_estetico |>
  select(processo, dano_estetico)

################## FILTRANDO SOMENTE AS APELAÇÕES ############################

cjsg_apelacao <- filter(cjsg, classe == "Apelação Cível")


###################### FILTRANDO POR HOSPITAL ################################
#
hospitais <- partes |> 
  filter(str_detect(parte, "Hospital"))
#
# Esta filtragem poderia ser aprofundada por meio da busca de outros termos
#
hospitais <- partes |> 
  filter(str_detect(parte, "Hospital")) |> 
  mutate(Hospital = case_when(
    str_detect(parte, "(?i)odont") ~ "Odonto",
    str_detect(parte, "(?i)maternidade") ~ "Maternidade",
    str_detect(parte, "(?i)segur") ~ "Seguradora",
    str_detect(parte, "(?i)veterin[áa]ri[oa]") ~ "Veterinário",
    str_detect(parte, "(?i)sa[úu]de") ~ "Centro de Saúde",
    str_detect(parte, "(?i)santa\\s(?i)casa") ~ "Santa Casa",
    str_detect(parte, "(?i)associação") ~ "Associação",
    str_detect(parte, "(?i)fundação") ~ "Fundação",
    str_detect(parte, "(?i)cl[íi]nica") ~ "Clínica",
    str_detect(parte, "(?i)universi[dt]") ~ "Universidade",
    str_detect(parte, "(?i)minist[ée]rio Público") ~ "Ministério Público",
    str_detect(parte, "(?i)hosp") ~ "Hospital",
    str_detect(parte,"(?i)(\\bs[./]?a\\.?$|\\bs\\.\\a\\.|\\bs/a.?\\b|s\\sa$|ltda\\.?|\\bME\\.?\\b|\\bMEI\\.?\\b|\\bEPP\\.?\\b|eirel[ei]|\\bs/?c\\b|companhia|\\bcia\\b)") ~ "PJ",
    TRUE ~  "PF"
    ))
#
################## VERIFICANDO SE AS PARTES SE REPETEM ########################
#
p1 <- partes |> 
  mutate(repete = vctrs::vec_duplicate_detect(parte))
#
#
repetidos <- p1 |> filter(tipo_parte == "Apelante", repete == TRUE)
#
#
################ CRIANDO GRÁFICOS COM AS PARTES
#
# É possível criar um gráfico com os dados acima com a função ggplot
#
# 1) Tipo de gráfico 1
#
ggplot(hospitais) +
  geom_bar(aes (x = Hospital, fill = Hospital),
           show.legend = FALSE) +
  labs(x = "Tipo de hospital",
       y = "Quantidade",
       title = "Quantidade de julgados por hospital",
       caption = "Fonte: TJSP") +
  theme_minimal()
#
# Tipo de gráfico 2
#
hospitais |> 
  count(Hospital, sort = TRUE) |> 
  ggplot() +
  geom_bar(aes (x = reorder(Hospital, -n), 
                y = n, 
                fill = Hospital),
                stat = "identity",
           show.legend = FALSE) +
  scale_fill_viridis_d() +
  labs(x = "Tipo de instituição",
       y = "Quantidade",
       title = "Quantidade de julgados por instituição",
       caption = "Fonte: TJSP") +
  theme_minimal()
#
############# FAZENDO GRÁFICOS INTERATIVOS #####################
#
# Para isso, é necessário instalar o pacote echarts4r
#
install.packages("echarts4r")
library(echarts4r)
#
#
h <- count(hospitais, Hospital, sort = TRUE)

h |> 
  e_chart(Hospital) |> 
  e_bar(n) |> 
  e_tooltip()
#
saveRDS(h, "docs/hospitais.RDS")
#
##################### CRIANDO UM RELATÓRIO DA ANÁLISE ##########################
#
# A melhor forma de criar um relatório no R é com o R Markdown.
# Para isso, é necessário abrir um novo script do R Markdown
# Para gerar os documentos no formato PDF, é necessário instalar o pacote tinytex
#
install.packages("tinytex")
library(tinytex)  
#
# Existe, ainda, um RMD especial que pode ser instalado utilizando um pacote 
# especial chamadao flexdashboard
#
install.packages("flexdashboard")
library(flexdashboard)
#
####################### O APLICATIVO SHINY ##################################
#
# Para criar um aplicativo shiny, você precisa ir até o menu "File", "New File" e
# depois até o "Shiny web app"
#
################## RODANDO UM MODELO MAIS COMPLEXO DE ML #######################
#
#
base_modelo <- base |> 
  select(processo, decisao, comarca, ano_decisao, tipo_parte, relator)
# O primeiro passo é carregar o pacote tidymodels
install.packages("tidymodels")
library(tidymodels)
install.packages("themis")
library(themis)

#
# Em machine learning, nós trabalhamos com uma base treino e uma base teste, na 
# proporção de 3/4 para a base treino e 1/4 para a base teste
# 
data_split <- initial_split(base_modelo, prop = 3/4) #dividindo a base
#
# Criando dataframes para os dois sets
#
train_data <- training(data_split)
test_data <- testing(data_split)

data_folds <- vfold_cv(train_data,
                       v = 10,
                       repeats = 5)
#
#
moral_rec <-
  recipe(decisao ~., data = train_data) |> 
  update_role(processo, new_role = "ID") |> 
  step_dummy(all_nominal_predictors()) |> 
  step_downsample(decisao)

lr_mod <- 
  logistic_reg(penalty = tune(), mixture = tune()) %>%
  set_engine("glmnet") |> 
  set_mode("classification")

logit_grid <- lr_mod %>%
  hardhat::extract_parameter_set_dials() %>%
  grid_max_entropy(size = 10)

moral_wflow <-
  workflow() %>%
  add_model(lr_mod) %>%
  add_recipe(moral_rec)

tuned_model <- tune_grid(moral_wflow,
                         resamples = data_folds,
                         grid = logit_grid,
                         control = control_resamples(saved_pred = TRUE))

show_best(tuned_model, metric = "accuracy")

choose_acc <- tuned_model %>%
  select_best(metric = "accuracy")

final_wf <- finalize_workflow(moral_wf, choose_acc)

moral_fit <-
  moral_wflow %>%
  fit(data = train_data)

################ CRIANDO UM DATASET SOMENTE COM OS VALORES ######################
#
# Com esse dataset é possível verificar se os valores de condenação de um tipo
# específico de instituição são superiores a outro tipo
#
hospitais <- hospitais |> 
  inner_join(select(base, processo, valor_maximo))

valor_hospitais <- hospitais |> 
  group_by(Hospital) |> 
  summarize(media = mean(valor_maximo),
            soma = sum(valor_maximo),
            mediana = median(valor_maximo),
            minimo = min(valor_maximo),
            maximo = max(valor_maximo))

# É possível filtrar os valores no dataset utilizado como base:

base <- base |> 
  filter(valor_maximo <= 100000)

########################### CRIANDO UMA BASE MODELO ############################

base_modelo <- base |> 
  group_by(relator) |> 
  filter(row_number() > 10) |> 
  ungroup() |> 
  mutate(hospital = ifelse(is.na(hospital), "outra_instituicao", hospital)) |> 
  select(processo, ementa, ano_decisao, apelante, apelado) |> 
  drop_na() |> 
  mutate_all(as.factor)



################## JUNTANDO UMA COLUNA DE UM DATASET EM OUTRO ##################

base <- hospitais |> 
  select(processo, Hospital) |> 
  right_join(base, by = "processo") |> 
  mutate(banco = ifelse(is.na(banco), "outra_instituicao", banco))


####################### CRIANDO E TREINANDO UM MODELO ##########################

data_split <- initial_split(base_modelo, prop = 3/4)

# Criando data frames para os dois sets

train_data <- training(data_split)
test_data <- testing(data_split)
Data_folds <- vfold_cv(train_data,
                       v = 10,
                       repeats = 5)

moral_rec <-
  recipe(decisao ~ ., data = train_data) |> 
  update_role(processo, new_role = "ID") |> 
  step_dummy(all_nominal_predictors()) |>  #torna as variáveis dummy
  stepzv(all_predictors()) |>               #remove preditores com variancia zero
  step_downsample(decisao)

lr_mod <-
  logistic_reg(penalty = tune(), mixture = tune()) |> 
  set_engine("glmnet") |> 
  set_mode("classification")

logit_grid <- lr_mod %>%
  hardhat::extract_parameter_set_dials() %>%
  grid_max_entropy(size = 10)

moral_wflow <-
  workflow() %>%
  add_model(lr_mod) %>%
  add_recipe(moral_rec)

tuned_model <- tune_grid(moral_wflow,
                         resamples = data_folds,
                         grid = logit_grid,
                         control = contro_resamples(save_pred = TRUE))

show_best(tuned_model, metric = "accuracy")

choose_acc <- tuned_model %>%
  select_best(metric = "accuracy")

final_wf <- finalize_workflow(moral_wflow, choose_acc)

final_fitted <- last_fit(final_wf, data_split)

collect_predictions(final_fitted) %>%
  roc_curve(truth = decisao, .pred_improcedente) %>%
  autoplot() +
  labs(
    color = NULL,
    title = "Curva ROC",
    subtitle = "Com ajuste finalizado e predições na base de teste"
  )

preditos <- final_fitted$.predictions[[1]]

table(preditos$decisao, preditos$.pred_class)

count(preditos, decisao, .pred_class)

