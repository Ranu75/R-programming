log_info("Sauvegarder les résultats dans la bdd")

save_result = function(db_path, table, title){
  # Connexion d'une base de données
  con = dbConnect(SQLite(), db_path)
  # Enregistrer une table dans la base de données
  dbWriteTable(con, title, table, overwrite = TRUE, row.names = FALSE)
  # Déconnecter de la base de données
  dbDisconnect(con)
}






