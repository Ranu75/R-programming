source("utils/packages.R")

# Charger toutes les fonctions définies dans le dossier "scripts"
scripts_files = list.files("scripts", pattern = "\\.R$", full.names = TRUE)
lapply(scripts_files, source)

# Charger le package pour réaliser des test unitaires
library(testthat)

log_info("Exécution des tests unitaires")

test_that("Lecture des fichiers CSV fonctionne", {
  csv_data = read_csv_files("data/")
  expect_type(csv_data, "list")
  expect_true(all(sapply(csv_data, is.data.frame)))
})

test_that("Stockage des données dans la BDD", {
  db_path = "data/employees_db.sqlite"
  csv_data = read_csv_files("data/")
  save_to_sqlite(csv_data, db_path)
  con = dbConnect(SQLite(), db_path)
  list_table = dbListTables(con)
  expect_true(length(list_table) > 0)
})

test_that("Lecture des données", {
  employees_data = read_from_sqlite(db_path, "employees")
  expect_true(is.data.frame(employees_data))
})

test_that("Calcul de l'âge", {
  db_path = "data/employees_db.sqlite"
  con = dbConnect(SQLite(), db_path)
  emp_salaries = dbGetQuery(con,
                            "SELECT * FROM employees;")
  dbDisconnect(con)
  emp_salaries = compute_age(emp_salaries, "birth_date", "hire_date")
  expect_true(is.numeric(emp_salaries$hire_age))
})

log_info("Tests unitaires terminés avec succès")