## Load data

log_info("Chargement du module de lecture des CSV")

read_csv_files = function(directory){
  # parcourir les fichiers 
  files = list.files(directory, pattern = "\\.csv$", full.names = TRUE)
  # charger les données et les enregistrer sous forme de liste
  list_data = lapply(files, read.csv)
  # renommer le nom de chaque élément
  names(list_data) = gsub(".csv", "", basename(files))
  return(list_data)
}

