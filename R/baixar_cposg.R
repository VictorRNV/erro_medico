processos <- readRDS(here::here("data/processos.rds"))

processos <- JurisMiner::dividir_sequencia(processos, 7)

purrr::walk(processos, ~{
  
  tjsp::autenticar(login = XXXXXXXXXXX, password = XXXXXX)
  
  tjsp::tjsp_baixar_cposg(.x, diretorio = here::here("data-raw/cposg"))
  
})



?tjsp_autenticar
