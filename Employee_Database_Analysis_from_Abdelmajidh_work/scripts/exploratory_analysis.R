log_info("Fonction pour exploiter les données")

#' Count the number of employee by an indicator
#' 
#' @param df A dataframe
#' @param feature A string
#' @param id A string
#' @return The count of population by an indicateur
#' @example
#' counting(emp_salaries, "title", "emp_no")
counting = function(df, feature, id){
  result = df %>% group_by(.data[[feature]]) %>% summarise(n_distinct(.data[[id]]))
  return(result)
}

#' Statistics on the salary by population
#' 
#' @param df A dataframe
#' @param feature A string
#' @param salary A string
#' @return The count of population by an indicateur
#' @example
#' counting(emp_salaries, "title", "salary")
result_salary = function(df, feature, salary){
  result = df %>% group_by(.data[[feature]]) %>% summarise(mean(.data[[salary]]),
                                                           sd(.data[[salary]]),
                                                           median(.data[[salary]]),
                                                           quantile(.data[[salary]], probs = 0.25),
                                                           quantile(.data[[salary]], probs = 0.75))
  return(result)
}

