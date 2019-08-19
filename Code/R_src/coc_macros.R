token_common <- function(units_by_book){
  units_by_book %>%
  mutate(phrase_n = row_number()) %>%
  unnest_tokens(word, phrase) %>%
  mutate(word = word %>%
           str_replace_all("[[:punct:]]", "")
  )
}

coc_word_phrase <- function(token_by_unit){
  library(tidytext)
  library(dplyr)
  
  pairwise_count(token_by_unit,
                 word,
                 phrase_n)
}

write_corpus_coc <- function(token_by_phrase,
                             folder_base = "Austen/Corpus/Operated",
                             project_base = "../Outputs/Data/DiaData/"){
  
  folder <- paste0(project_base, folder_base)
  
  coced <- token_by_phrase %>%
    coc_word_phrase
  
  create_maybe_folder(here(folder))
  
  coced %>%
    data.table::fwrite(here(folder,"coc.csv"))
  
  coced %>%
    mutate(n = 1L) %>%
    data.table::fwrite(here(folder,"coc_bin.csv"))
  
}

walkwrite_nested_coc <- function(
  data,
  name,
  folder_base = "Austen/Text_as_is",
  project_base = "../Outputs/Data/DiaData/") {
  
  # get book name in characters
  book_shortname <- word(name)
  
  ## create folder if not exist
  book_folder <- here(
    paste0(project_base, folder_base,
           "/By_book/", book_shortname))
  
  create_maybe_folder(book_folder)
  
  ## unnest and write in csv file 
  unnested <- data %>%
    unnest(coc) %>%
    select(-book)
  
  unnested %>%
    data.table::fwrite(paste0(book_folder,"/coc.csv"))
  
  unnested %>%
    mutate(n = 1) %>%
    data.table::fwrite(paste0(book_folder,"/coc_bin.csv"))
}

split_and_walk_coc <- function(bookwise_coc,
                               folder_base = "Austen/Text_as_is",
                               project_base = "../Outputs/Data/DiaData/") {
  
  library(purrr)
  
  bookwise_list <- split(bookwise_coc, bookwise_coc$book)
  
  bookwise_list %>%
    iwalk(walkwrite_nested_coc,
          folder_base = folder_base,
          project_base = project_base)
}

unnest_coc_book <- function(nested_coc){
  nested_coc %>%
    dplyr::select(book, coc) %>%
    tidyr::unnest(coc)
}

coc_book <- function(phrase_data){
  phrase_data %>%
    dplyr::group_by(book) %>%
    tidyr::nest(data = c(phrase_n, word)) %>%
    dplyr::mutate(
    coc = data %>% purrr::map(pairwise_count,word, phrase_n)
  ) %>%
    dplyr::select(-data)
}

sharing_words <- function(token_by_unit){
  library(dplyr)
  library(purrr)
  split(token_by_unit, token_by_unit$book) %>%
    purrr::map("word") %>%
    purrr::reduce(dplyr::intersect)
}