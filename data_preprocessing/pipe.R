# pipe natif de R
v <- c(1.2, 8.7, 5.6, 11.4) # vector

v |> 
  mean() |> 
  round(digits = 1) |> 
  format(decimal.mark = ",") |> 
  paste0("La moyenne est de ", m = _, ".") |> 
  message()

# pipe de tidyverse
library(tidyverse)

v %>% 
  mean() %>%
  round(digits = 1) %>%
  format(decimal.mark = ",") %>%
  paste0("La moyenne est de ", ., ".") %>%
  message()

