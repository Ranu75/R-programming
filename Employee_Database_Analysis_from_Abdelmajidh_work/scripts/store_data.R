log_info("Convertir les données de fichier csv dans la bdd")

# Sauvegarder les données dans une base de données SQLite 
save_to_sqlite = function(data_list, db_path){
  # Connexion d'une base de données
  con = dbConnect(SQLite(), db_path)
  # Parcour les tables une par une
  for (name in names(data_list)){
    # Stockage de la table
    dbWriteTable(con, name, data_list[[name]], overwrite = TRUE, row.names = FALSE)
  }
  # Déconnecter de la base de données
  dbDisconnect(con)
}

log_info("Lire les données de fichier csv dans la bdd")

# Lire les données dans une base de données SQLite
read_from_sqlite <- function(db_path, table_name) {
  # Connexion d'une base de données
  con <- dbConnect(SQLite(), db_path)
  # Lecture de la table
  data <- dbReadTable(con, table_name)
  dbDisconnect(con)
  
  return(data)
}