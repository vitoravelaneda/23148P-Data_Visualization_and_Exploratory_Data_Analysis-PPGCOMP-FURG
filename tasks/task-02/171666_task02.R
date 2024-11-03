# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 

# This notebook contains the solution for Task 02 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ## Task

# Considering our first data set, about the number of Brazilian Championships create the R code necessary to produce the most similar possible graph to the one available [here!](./CampeonatoBrasileiro.pdf)

# Note that you'll have to update the original csv file adding the state of each national team.

# ## Solution

# > Install packeges R:

if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")

# > Import librarys R:

library(ggplot2)
library(tidyverse)
library(RColorBrewer)

# > Check colors:

display.brewer.all()

# > Cleaning workspace:

rm(list = ls())

# > Import dataset:

my.data <- data.frame(read.csv("./campeoes.csv"))

# > Reorganizing dataset:

my.data.all <- cbind(my.data, Estado = c("SP", "SP", "RJ", "SP", "SP", "MG", "RJ", "RJ", "MG", "RS", "BA", "RJ", "RS", 
                                          "PR", "PR", "SP", "PE"))

# > Plotting data:

ggplot(my.data.all, aes(x = reorder(Time,+Titulos), y = Titulos, fill = Estado)) +
  geom_bar(stat = "identity") + 
  coord_flip() +
  scale_fill_manual(values = c("BA" = "red", "MG" = "#1166bf", "PE" = "#44BB34", "PR" = "#bb1199", 
                               "RJ" = "darkorange", "RS" = "#FFFF33", "SP" = "#AA4000")) +
  labs(title = "Campeonato Brasileiro", x = "", y = "Nro de Títulos") +
  scale_y_continuous(breaks = seq(0, 12, by = 2)) +
  theme_minimal() +
  theme(
    text = element_text(size = 18),
    panel.grid.major.y = element_blank(),  
    panel.grid.minor.y = element_blank()   
  )