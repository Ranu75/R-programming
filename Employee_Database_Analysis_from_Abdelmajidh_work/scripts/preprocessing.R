log_info("Calculer l'âge")

#' Count the number of employee by an indicator
#' 
#' @param df A dataframe
#' @param birth_date A birth date
#' @param hire_date A hire date
#' @return The age of hire
#' @example
#' counting(emp_salaries, "birth_date", "hire_date")
compute_age = function(df, birth_date, hire_date){
  df = df %>% 
    mutate(birth_date = mdy(birth_date), 
                     hire_date = mdy(hire_date)) %>%
    mutate(hire_age = time_length(birth_date %--% hire_date, unit = "years"))
    
  return(df)
}
