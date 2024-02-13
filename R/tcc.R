cjsg_tcc <- filter(cjsg, classe == "Apelação Cível")
saveRDS(cjsg_tcc, "data/cjsg_tcc.rds")


############################# CORPUS ##########################################

corpo <- corpus(cjsg_tcc, docid = "cdacordao", text_field = "ementa")

laudo <- kwic(corpo, "laudo", window = 10)
impericia <- kwic(corpo, "imperícia", window = 10)
cachorro <- kwic(corpo, "cachorro", window = 10)
lesao_corporal <- kwic(corpo, phrase("lesão corporal"))
lesao <- kwic(corpo, "lesão", window = 10)
prescricao <- kwic(corpo, "prescrição", window = 10)
ginecologia <- kwic(corpo, "ginecologia", window = 10)
analgesico <- kwic(corpo, "analgésico", window = 10)

cjsg_laudo <- cjsg_tcc |>
  mutate(laudo = str_detect(ementa, "laudo"))


########################### DECISÕES POR COMARCA ##############################

comarcas_tcc <- count(cjsg_tcc, comarca)

comarcas_tcc <- comarcas_tcc |> 
  mutate(total_comarcas = sum(n)) |> 
  mutate(porcentagem = n / total_comarcas * 100)

########################### ANO DA DECISÃO #####################################

ano_decisao <- count(cjsg_tcc, ano_decisao)
ano_decisao

ano_decisao <- ano_decisao |> 
  mutate(total_ano = sum(n)) |> 
  mutate(porcentagem = n / total_ano * 100)

ano_decisao$n <- as.integer(ano_decisao$n)

saveRDS(ano_decisao, "data/ano_decisao.rds")

#Fazendo um histograma

ano_decisao_plot <- ggplot(ano_decisao, aes(x = ano_decisao, y = n)) +
  geom_bar(stat = "identity", fill = "blue", width = 0.7) +
  geom_text(aes(label = n), vjust = -0.2, color = "black", size = 3) +
  labs(x = "Ano da Decisão", y = "Quantidade (n)", title = "Quantidade de decisões por ano")

ggsave("ano_decisao_plot.png", plot = ano_decisao_plot, width = 10, height = 6, units = "in")

######################### TAXA DE REFORMA GERAL ###############################

taxa_reforma <- cjsg_tcc |> 
  count(decisao, decisao, sort = T) |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)

saveRDS(taxa_reforma, "data/taxa_reforma.rds")

# Fazendo um histograma

taxa_reforma_plot <- ggplot(taxa_reforma, aes(x = reorder(decisao, -n), y = n)) +
  geom_bar(stat = "identity", fill = "blue") +
  geom_text(aes(label = n), vjust = -0.2, color = "black", size = 3) +
  labs(x = "Desfecho", y = "Quantidade (n)", title = "Quantidade de desfechos por tipo") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



####################### TAXA DE REFORMA POR ÓRGÃO ############################

decisoes_por_camara <- cjsg_tcc |> 
  group_by(orgao_julgador) |> 
  count(orgao_julgador, decisao, sort = T) |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)

# Arredondando os valores

decisoes_por_camara$porcentagem <- round(decisoes_por_camara$porcentagem, digits = 2)

saveRDS(decisoes_por_camara, "data/decisoes_por_camara.rds")

# Criando um dataframe com as 10 comarcas com o maior número de processos

decisoes_por_orgao_10 <- data.frame(
  Órgão = c("8ª Câmara", "6ª Câmara", "2ª Câmara", "7ª Câmara", "9ª Câmara", 
              "5ª Câmara", "1ª Câmara", "4ª Câmara", "3ª Câmara", "10ª Câmara"),
  Improvido = c(416, 348, 330, 233, 281, 274, 248, 266, 226, 266),
  Provido = c(79, 67, 44, 112, 73, 47, 85, 83, 36, 36),
  Parcial = c(43, 63, 51, 59, 37, 78, 41, 34, 79, 52),
  Outros = c(27, 54, 39, 54, 59, 39, 34, 23, 53, 38),
  Total = c(565, 532, 464, 458, 450, 438, 408, 406, 394, 392)
)

saveRDS(decisoes_por_orgao_10, "data/decisoes_por_orgao_10.rds")

# Criando um gráfico de barras empilhadas

# Melt do dataframe para formatar os dados para o ggplot
decisoes_por_orgao_10_melted <- decisoes_por_orgao_10 %>%
  gather(Tipo, Quantidade, -Órgão, -Total)

# Definir a ordem correta dos tipos de decisões (do "Outros" ao "Provido")
ordem_tipos_decisoes <- c("Provido", "Parcial", "Improvido", "Outros")

# Criação do gráfico de barras empilhadas com todos os ajustes estéticos, incluindo a ordenação decrescente das comarcas, as cores personalizadas e a ordem dos tipos de decisões
orgaos_10_empilhadas <- ggplot(decisoes_por_orgao_10_melted, aes(x = reorder(Órgão, -Total), y = Quantidade, fill = factor(Tipo, levels = ordem_tipos_decisoes))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Decisões por Órgão Julgador", x = "Órgão Julgador", y = "Total de Decisões", fill = "Tipo de Decisão") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotacionar rótulos em 45 graus
        legend.position = "top",                           # Posicionar a legenda na parte superior
        legend.title = element_blank(),                    # Remover título da legenda
        legend.background = element_blank(),               # Remover fundo da legenda
        panel.grid.major.x = element_blank())              # Remover linhas de grade verticais

# Definir as cores personalizadas para cada tipo de decisão
cores_personalizadas <- c("Improvido" = "red", "Provido" = "green", "Parcial" = "yellow", "Outros" = "gray")
orgaos_10_empilhadas <- orgaos_10_empilhadas + scale_fill_manual(values = cores_personalizadas)

# Exibir o gráfico
print(orgaos_10_empilhadas)

ggsave(filename = "orgaos_10_empilhadas.png", plot = comarcas_10_empilhadas, width = 10, height = 6, dpi = 300)

###################### TAXA DE REFORMA POR COMARCA #############################

decisoes_por_comarca <- cjsg_tcc |> 
  group_by(comarca) |> 
  count(comarca, decisao, sort = T) |>
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes *100)

# Arredondando os valores

decisoes_por_comarca$porcentagem <- round(decisoes_por_comarca$porcentagem, digits = 2)

saveRDS(decisoes_por_comarca, "data/decisoes_por_comarca.rds")

# Criando um dataframe com as 10 comarcas com o maior número de processos

decisoes_por_comarca_10 <- data.frame(
  Comarca = c("São Paulo", "Guarulhos", "Santos", "Campinas", "São Bernardo do Campo", 
              "Santo André", "Osasco", "São José do Rio Preto", "Sorocaba", "Ribeirão Preto"),
  Improvido = c(884, 97, 89, 85, 93, 91, 58, 53, 52, 41),
  Provido = c(239, 17, 20, 21, 13, 15, 15, 18, 11, 13),
  Parcial = c(210, 18, 19, 17, 13, 9, 7, 4, 11, 14),
  Outros = c(132, 15, 13, 14, 10, 4, 8, 8, 9, 11),
  Total = c(1465, 147, 141, 137, 129, 119, 88, 83, 83, 79)
)

saveRDS(decisoes_por_comarca_10, "data/decisoes_por_comarca_10.rds")

# Criando um gráfico de barras empilhadas

# Melt do dataframe para formatar os dados para o ggplot
decisoes_por_comarca_10_melted <- decisoes_por_comarca_10 %>%
  gather(Tipo, Quantidade, -Comarca, -Total)

# Definir a ordem correta dos tipos de decisões (do "Outros" ao "Provido")
ordem_tipos_decisoes <- c("Provido", "Parcial", "Improvido", "Outros")

# Criação do gráfico de barras empilhadas com todos os ajustes estéticos, incluindo a ordenação decrescente das comarcas, as cores personalizadas e a ordem dos tipos de decisões
comarcas_10_empilhadas <- ggplot(decisoes_por_comarca_10_melted, aes(x = reorder(Comarca, -Total), y = Quantidade, fill = factor(Tipo, levels = ordem_tipos_decisoes))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Decisões por Comarca", x = "Comarca", y = "Total de Decisões", fill = "Tipo de Decisão") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotacionar rótulos em 45 graus
        legend.position = "top",                           # Posicionar a legenda na parte superior
        legend.title = element_blank(),                    # Remover título da legenda
        legend.background = element_blank(),               # Remover fundo da legenda
        panel.grid.major.x = element_blank())              # Remover linhas de grade verticais

# Definir as cores personalizadas para cada tipo de decisão
cores_personalizadas <- c("Improvido" = "red", "Provido" = "green", "Parcial" = "yellow", "Outros" = "gray")
comarcas_10_empilhadas <- comarcas_10_empilhadas + scale_fill_manual(values = cores_personalizadas)

# Exibir o gráfico
print(comarcas_10_empilhadas)

ggsave(filename = "comarcas_10_empilhadas.png", plot = comarcas_10_empilhadas, width = 10, height = 6, dpi = 300)

####################### TAXA DE REFORMA POR JULGADOR ###########################

decisoes_por_relator <- cjsg_tcc |> 
  group_by(relator) |> 
  count(relator, decisao, sort = T) |>
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes *100)

# Arredondando os valores

decisoes_por_relator$porcentagem <- round(decisoes_por_relator$porcentagem, digits = 2)

saveRDS(decisoes_por_relator, "data/decisoes_por_relator.rds")

# Criando um dataframe com as 10 comarcas com o maior número de processos

decisoes_por_relator_10 <- data.frame(
  Relator = c("Relator 1", "Relator 2", "Relator 3", "Relator 4", "Relator 5", 
              "Relator 6", "Relator 7", "Relator 8", "Relator 9", "Relator 10"),
  Improvido = c(66, 61, 62, 74, 62, 59, 58, 67, 51, 61),
  Provido = c(20, 19, 9, 2, 10, 20, 5, 8, 8, 4),
  Parcial = c(12, 15, 16, 10, 11, 0, 19, 9, 11, 14),
  Outros = c(16, 1, 7, 7, 10, 11, 8, 3, 16, 7),
  Total = c(114, 96, 94, 93, 93, 90, 90, 87, 86, 86)
)

saveRDS(decisoes_por_relator_10, "data/decisoes_por_relator_10.rds")

# Criando um gráfico de barras empilhadas

# Melt do dataframe para formatar os dados para o ggplot
decisoes_por_relator_10_melted <- decisoes_por_relator_10 %>%
  gather(Tipo, Quantidade, -Relator, -Total)

# Definir a ordem correta dos tipos de decisões (do "Outros" ao "Provido")
ordem_tipos_decisoes <- c("Provido", "Parcial", "Improvido", "Outros")

# Criação do gráfico de barras empilhadas com todos os ajustes estéticos, incluindo a ordenação decrescente das comarcas, as cores personalizadas e a ordem dos tipos de decisões
relator_10_empilhadas <- ggplot(decisoes_por_relator_10_melted, aes(x = reorder(Relator, -Total), y = Quantidade, fill = factor(Tipo, levels = ordem_tipos_decisoes))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Decisões por Relator", x = "Relator", y = "Total de Decisões", fill = "Tipo de Decisão") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotacionar rótulos em 45 graus
        legend.position = "top",                           # Posicionar a legenda na parte superior
        legend.title = element_blank(),                    # Remover título da legenda
        legend.background = element_blank(),               # Remover fundo da legenda
        panel.grid.major.x = element_blank())              # Remover linhas de grade verticais

# Definir as cores personalizadas para cada tipo de decisão
cores_personalizadas <- c("Improvido" = "red", "Provido" = "green", "Parcial" = "yellow", "Outros" = "gray")
relator_10_empilhadas <- relator_10_empilhadas + scale_fill_manual(values = cores_personalizadas)

# Exibir o gráfico
print(relator_10_empilhadas)

ggsave(filename = "relator_10_empilhadas.png", plot = relator_10_empilhadas, width = 10, height = 6, dpi = 300)

########################### DURACAO DO PROCESSO ###############################


# a) Lendo os andamentos dos processos
#
andamentos <- tjsp_ler_movimentacao(diretorio = "data-raw/cposg")
#
# b) Salvando os dados
#
saveRDS(andamentos, "data/andamentos.rds")
write.csv(andamentos, "data/andamentos.csv")
#
#
# c) Além disso, é possível ler somente a data de entrada do processo no 2º grau
# Isso pode ser útil para calcular o tempo entre a entrada e a decisão. A função
# utilizada para isso é a seguinte:
#
entrada <- ler_entrada(diretorio = "data-raw/cposg")
saveRDS(entrada, "data/entrada.rds")
#
# Por fim, é possível ler o dispositivo da decisão
#
decisao <- tjsp_ler_dispositivo(diretorio = "data-raw/cposg")
#
# d) Apresentadas as possibilidades acima, podemos ir, de fato, para o cálculo do 
# tempo de duração dos processos com as strings a seguir:
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

saveRDS(duracao_total, "data/duracao_total.rds")

# Juntando apenas a coluna "duracao" do dataset "duracao_total" com "cjsg_tcc"
cjsg_tcc <- left_join(cjsg_tcc, duracao_total %>% select(processo, duracao), 
                      by = "processo")
duracao <- cjsg_tcc |> 
  filter(duracao != -Inf) |> 
  drop_na() |> 
# group_by(decisao) |>
  summarize(media = mean(duracao),
            soma = sum(duracao),
            mediana = median(duracao),
            minimo = min(duracao),
            maximo = max(duracao))

saveRDS(duracao, "data/duracao.rds")



############################# VALOR DAS CONDENAÇÕES ###########################

valores <- cjsg_tcc |>
  filter(valor_maximo != -Inf) |>
  drop_na() |>
  group_by(decisao) |> 
  summarize(media = mean(valor_maximo),
            soma = sum(valor_maximo),
            mediana = median(valor_maximo),
            minimo = min(valor_maximo),
            maximo = max(valor_maximo))

############################# VALOR DA CAUSA ##################################

# Juntando apenas a coluna "valor_da_acao" do dataset "metadados" com "cjsg_tcc"
cjsg_tcc <- left_join(cjsg_tcc, metadados%>% select(processo, valor_da_acao), 
                      by = "processo")
valor_acao <- count(cjsg_tcc, valor_da_acao, sort = TRUE) |> View()

cjsg_tcc_sem_duplicatas <- distinct(cjsg_tcc, .keep_all = TRUE)

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

table(partes_tipo$parte_tipo)

saveRDS(partes_tipo, "data/partes_tipo.rds")

####################### DATATABLE ##################################

# Criando um datatable com o número do processo, a ementa, a decisao e o valor
#
datatable(select(cjsg_tcc, processo, decisao, ementa, valor_maximo, duracao))
