########################################### TAXA REFORMA SAUDE ###########

library(dplyr)

taxa_reforma_tipo_parte <- partes_tipo %>%
  select(processo, tipo_parte, parte_tipo) %>%
  left_join(cjsg_tcc %>% select(processo, decisao), by = "processo")

taxa_reforma_tipo_parte_filtrada <- taxa_reforma_tipo_parte %>%
  filter(
    tipo_parte %in% c("Apelante:"),
    parte_tipo != "PF"
  )

# Verifique se há processos duplicados
duplicados <- duplicated(taxa_reforma_tipo_parte_filtrada$processo)

# Agora, você pode verificar os valores duplicados
valores_duplicados <- taxa_reforma_tipo_parte_filtrada$processo[duplicados]

# Se houver valores duplicados, eles estarão em "valores_duplicados"
# Você pode visualizar ou manipular esses valores conforme necessário

taxa_reforma_tipo_parte_filtrada_sem_duplicatas <- taxa_reforma_tipo_parte_filtrada %>%
  distinct(processo, .keep_all = TRUE)

taxa_reforma_saude <- taxa_reforma_tipo_parte_filtrada_sem_duplicatas |>
  count(decisao, decisao, sort = T) |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)

taxa_reforma_saude$porcentagem <- round(taxa_reforma_saude$porcentagem, 2)

saveRDS(taxa_reforma_saude, "taxa_reforma_saude.rds")

################################### TAXA DE REFORMA PF #########################

taxa_reforma_tipo_parte2 <- partes_tipo %>%
  select(processo, tipo_parte, parte_tipo) %>%
  left_join(cjsg_tcc %>% select(processo, decisao), by = "processo")

taxa_reforma_tipo_parte_filtrada2 <- taxa_reforma_tipo_parte2 %>%
  filter(
    tipo_parte %in% c("Apelante:"),
    parte_tipo == "PF"
  )

# Verifique se há processos duplicados
duplicados2 <- duplicated(taxa_reforma_tipo_parte_filtrada2$processo)

# Agora, você pode verificar os valores duplicados
valores_duplicados2 <- taxa_reforma_tipo_parte_filtrada2$processo[duplicados2]

# Se houver valores duplicados, eles estarão em "valores_duplicados"
# Você pode visualizar ou manipular esses valores conforme necessário

taxa_reforma_tipo_parte_filtrada_sem_duplicatas2 <- taxa_reforma_tipo_parte_filtrada2 %>%
  distinct(processo, .keep_all = TRUE)

taxa_reforma_pf <- taxa_reforma_tipo_parte_filtrada_sem_duplicatas2 |> 
  count(decisao, decisao, sort = T) |> 
  mutate(total_decisoes = sum(n)) |> 
  mutate(porcentagem = n / total_decisoes * 100)

taxa_reforma_pf$porcentagem <- round(taxa_reforma_pf$porcentagem, 2)

saveRDS(taxa_reforma_pf, "taxa_reforma_pf.rds")

########################## RASCUNHO ##################################

#taxa_reforma_tipo_parte_filtrada <- taxa_reforma_tipo_parte %>%
#  filter(
#    tipo_parte %in% c("Apelante:", "Apte/Apdo:", "Apdo/Apte:", "Apda/Apte:"),
#    parte_tipo != "PF"
#  )


#taxa_reforma_tipo_parte_filtrada2 <- taxa_reforma_tipo_parte2 %>%
#  filter(
#    tipo_parte %in% c("Apelante:", "Apte/Apdo:", "Apdo/Apte:", "Apda/Apte:"),
#    parte_tipo == "PF"
#  )