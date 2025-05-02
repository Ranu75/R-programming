# Charger les packages
source("utils/packages.R")

# Charger les fonctions
source("scripts/load_data.R")
source("scripts/store_data.R")

# Définition des chemins
db_path = "data/employees_db.sqlite"

# Exécution des codes
log_info("1. Chargement des fichiers CSV")
csv_data = read_csv_files("data/")

log_info("2. Stockage des données dans SQLite")
save_to_sqlite(csv_data, db_path)

log_info("3. Lecture de la base de données")
employees_data = read_from_sqlite(db_path, "employees")

log_info("3.bis. Manipulation des données via SQL")
con = dbConnect(SQLite(), db_path)
emp_salaries = dbGetQuery(con, 
          "SELECT e.emp_no, d.dept_name, e.birth_date, e.sex, e.hire_date, s.salary, t.title
           FROM departments d
          INNER JOIN dept_emp de
          ON d.dept_no = de.dept_no
          INNER JOIN employees e
          ON de.emp_no = e.emp_no
          INNER JOIN salaries s
          ON e.emp_no = s.emp_no
          INNER JOIN titles t
          ON e.emp_title_id = t.title_id;")

manager_salaries = dbGetQuery(con, 
          "SELECT e.emp_no, d.dept_name, e.birth_date, e.sex, e.hire_date, s.salary, t.title
           FROM departments d
          INNER JOIN dept_manager dm
          ON d.dept_no = dm.dept_no
          INNER JOIN employees e
          ON dm.emp_no = e.emp_no
          INNER JOIN salaries s
          ON e.emp_no = s.emp_no
          INNER JOIN titles t
          ON e.emp_title_id = t.title_id;")

log_info("4. Data preprocessing")
emp_salaries = compute_age(emp_salaries, "birth_date", "hire_date")
manager_salaries = compute_age(manager_salaries, "birth_date", "hire_date")

log_info("5. Exploitations des données")

## Taille des données 
dim(emp_salaries)
dim(manager_salaries)

## Nombre total des employés et managers
emp_salaries %>% summarise(n_distinct(emp_no))
manager_salaries %>% summarise(n_distinct(emp_no))

## Répartition des employés et managers
counting(emp_salaries, "sex", "emp_no")
counting(manager_salaries, "sex", "emp_no")
counting(emp_salaries, "dept_name", "emp_no")
counting(manager_salaries, "dept_name", "emp_no")
counting(emp_salaries, "title", "emp_no")

## Statistiques sur le salaire
result_salary(emp_salaries, "sex", "salary")
result_salary(emp_salaries, "title", "salary")

## Visualisation des données
### Histogramme des salaires
ggplot(emp_salaries, aes(x = salary)) +
  geom_histogram(bins = 30, fill = "orange", alpha = 0.7) +
  labs(title = "Répartition des salaires", x = "Salaire", y = "Nombre d'employés")

### Répartition des employés par département
ggplot(emp_salaries, aes(y = dept_name)) +
  geom_bar(bins = 30, fill = "blue", alpha = 0.7) +
  labs(title = "Répartition des employés", x = "Nombre d'employés", y = "Département")

