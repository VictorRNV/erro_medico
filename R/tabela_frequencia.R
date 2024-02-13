###################### COMO CRIAR UMA TABELA DE FREQUÊNCIA #####################

# 1) CARREGAR OS PACOTES NECESSÁRIOS

library(googlesheets4) # Serve para ler dados de planilhas do Google Sheets
library(tidyverse)     # Serve para manipular dados
library(writexl)       # Serve para exportar dados do R

############## 2) CRIAR OS OBJETOS NECESSÁRIOS #########

# Aqui pode ser criado um objeto chamado link_dados, que vai conter o URL da
# planilha de dados do Google Sheets

link_dados <- "substituit_pelo_URL"
dados <- read_sheet(link_dados, sheet = 3)  # Os argumentos passados são a base
                                            # de dados e a coluna de interesse, 
                                            # que, no caso, é a terceira

#################### 4) CRIANDO A TABELA DE FREQUÊNCIAS ########################

# Aqui está sendo contada a quantidade de resultados de acordo com as colunas 
# assunto e decisao_sentenca.
#
# Depois está sendo calculada a proporcao, pegando o valor da coluna (n) e 
# dividindo pela soma desses valores
# 
# Depois está sendo calculada a frequência acumulada e a proporção acumulada

tabela_frequencias <- dados |> 
  count(assunto, decisao_sentenca) |> 
  mutate(proporcao = n / sum(n),
         frequencia_acumulada = cumsum(n),
         proporcao_acumulada = cumsum(proporcao))
  
################## 3) EXPORTANDO A TABELA DE FREQUENCIAS #######################

# Aqui estamos carregando o pacote writexl, chamando a função writex_xlsx e 
# e salvando os dados no diretório data-raw


library(writexl)
write_xlsx("data-raw/a_frequencia_resultado.xlsx")








