create_maybe_folder <- function(folder){
  if(!dir.exists(folder)){
  dir.create(folder, recursive = TRUE)
  }
}