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

# Lire les données dans une base de données SQLite
read_from_sqlite = function(db_path){
  # Connexion d'une base de données
  con = dbConnect(SQLite(), db_path)
  list_data = c()
  for (data in db_path){
    # Lecture des tables
    df = dbReadTable(con, data)
    list_data = c(list_data, df)
  }
  # Déconnecter de la base de données
  dbDisconnect(con)
  return(list_data)
}