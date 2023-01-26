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
# c) data: local onde serão colocados os dados limpos, depois de processados. 
# Esta pasta será criada dentro da pasta principal do projeto.
#
# d) docs: pasta onde serão colocados os documentos, como os relatórios. Ficará
# na pasta principal do projeto
#
# e) R: pasta onde serão colocados os scripts, ou seja, os códigos que criamos,
# baixamos e utilizamos para analisar os dados. Esta pasta ficará na pasta
# principal do projeto

############################ COMO CITAR ########################################

# Jesus Filho, José de, Trecenti, Júlio (2020) Coleta e organização do Tribunal 
# de Justiça de São Paulo URL https://jjesusfilho.github.io/tjsp

######################### PACOTES NECESSÁRIOS/ÚTEIS ############################

# Instalando

install.packages("remotes") # O pacote remotes permite instalar pacotes não oficiais
install.packages("abjutils") # O pacote tjsp serve para baixar decisões do tjsp
install.packages("tidyverse") # Ferramentas para análises jurimétricas usada pela ABJ
install_github("jjesusfilho/tjsp")
remotes::install_github("jjesusfilho/tjsp") #junção de remotes com o pacote tjsp
install.packages("devtools")
devtools::install_github("jjesusfilho/stf")  # Instalando o pacote STF


# Carregando

library(tjsp)
library(remotes)
library(abjutils)
library(tidyverse)
library(stf)
library(stj)
library(trf1)
library(trf3)

# Entendendo

?tjsp
?remotes

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
function(){}     # Serve para criar funções

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
# O PIPE
#
# O pipe pode ser chamado com o Ctrl + Shift + m = |> ou %>%
#
# O pipe caminha da esquerda para a direita e de cima para baixo
#
a <- 1:10
a |>
  sum() |> 
  sqrt()

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
# Acima temos a função remotes, seguinta da função install_github. Nos argumentos,
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
# diretório indicado pelo usuário

# 2 - O segundo grupo inicia com o verbo ler e serve para ler as decisões baixa-
# das em HTML e as dispor em tabelas

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

# ETAPA 2 - Depois, lemos as informações sobre os processos

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
  assunto = "",          # Código do assunto processual preenchido com o objeto
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
# i) no campo “Assunto”, serão selecionados os termos # “erro médico” (código 10434), 
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
  livre = "erro médico",        
  aspas = TRUE,     
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
# 4) Depois que você clicar em consultar novamente, procure na coluna name, a 
# a linha que está com o nome "resultadoCompleta.do" (será a primeira)
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
# Loop ou laço de repetição. São os iteradores for e while. Eles funcionam na 
# mesma lógica da função vetorizada. Ele aplica um operação sobre cada elemento
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
# d (1,2,3,...), ou seja, é a variável sobre a qual a função vetorizada atuará
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
# Ela faz um loop ou um laço de repetição com
# as variáveis do objeto. Aplica-se, portanto, uma operação sobre cada elemento.
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
# Para aprender a manipular os dados, pode ser utilizado os bancos de dados tra-
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

write_delim(voos, "data/voos.csv",, delim = ";")

#

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
# As funções mais relevantes e básicas do dplyr são as seguintes:
# 
# 1) select() para selecionar colunas
# 
# 2) filter() para filtrar linhas
#
# 3) count() para gerar frequências
#
# 4) mutate() para transformar colunas ou gerar novas colunas
#
# 5) summarize() para gerar sumários/resumos
#
# 6) arrange() para ordenar o dataframe com base em uma ou mais colunas
#
# 7) group_by() serve para usarmos juntamente com outras
#

