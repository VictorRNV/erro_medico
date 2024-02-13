################# PREPARANDO OS DADOS ####################

# Carregar os pacotes necessários
library(ggplot2)
library(dplyr)
library(lubridate)

# Vamos transformar a coluna data_julgamento para o formato de data e, em seguida
# extrair o mês e o ano para agrupar os dados por esses períodos

# Supondo que cjsg_tcc seja o seu dataframe e data_julgamento a coluna com datas
cjsg_tcc$data_julgamento <- as.Date(cjsg_tcc$data_julgamento, format = "%Y-%m-%d")

# Criar uma coluna 'ano_mes' para agrupar por ano e mês
cjsg_tcc <- cjsg_tcc %>%
  mutate(ano_mes = format(data_julgamento, "%Y-%m"))

################### AGREGANDO OS DADOS #################

# Agora, agregue os dados para contar o número de julgamentos por mês

# Agregar dados por ano_mes
ano_mes_julgamento <- cjsg_tcc %>%
  mutate(ano_mes = as.Date(paste0(ano_mes, "-01"))) %>%
  group_by(ano_mes) %>%
  summarise(julgamentos = n())


saveRDS(ano_mes_julgamento, "data/ano_mes_julgamento.rds")
write.csv(ano_mes_julgamento, "data/ano_mes_julgamento.csv")
write_xlsx(ano_mes_julgamento, "data/ano_mes_julgamento.xlsx")

################## LINHA DO TEMPO ###################

# Finalmente, crie a linha do tempo com ggplot2 usando os dados agregados.

# Criar a linha do tempo
ggplot(ano_mes_julgamento, aes(x = ano_mes, y = julgamentos)) +
  geom_line(color = "#0073C2FF") +  # Linha azul
  geom_point(color = "#EFC000FF") +  # Pontos amarelos
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +
  theme_minimal(base_size = 14) +  # Tema minimalista com base de tamanho de fonte 14
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),  # Melhorar legibilidade dos rótulos do eixo x
        plot.title = element_text(face = "bold", size = 20),  # Título em negrito
        plot.subtitle = element_text(face = "italic"),  # Subtítulo em itálico
        legend.position = "bottom") +  # Legenda na parte inferior
  labs(x = "Data", y = "Quantidade de Julgamentos",
       title = "Linha do tempo com o número de julgamentos por mês",
       caption = "Fonte:  Resultados originais da pesquisa, com dados extraídos do e-SAJ do TJSP")
