# install packages
install.packages("mapsf")

# load packages
library(mapsf)

# load martinique
mtq <- mf_get_mtq()

# initialize a base map
mf_map(x = mtq, col = "orange",
       border = "white")

# plot symbology
mf_map(x = mtq, type = "prop", var = "POP",
       leg_title = "Population", add = TRUE)

# add title and layout
mf_layout(title = "Martinique",
          credits = "Sources: IGN, 2018")

