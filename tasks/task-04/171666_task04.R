# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 
# This notebook contains the solution for Task 04 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ## Task:

# In the zip file you find a data set and a graph that was produced with this data set. For producing this graph the data has to go through some transformations using functions like:

# pivot_longer(), separate_wider_delim(),  pivot_wider()

# Try to produce [the same graph](./basketball/basketball.pdf) and handle the R code as the result. 

# ## Solution

# **Package Installation and Loading:**

# Install packages if not already installed

if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

# Load the necessary libraries

library(readr)
library(tidyverse)
library(ggplot2)

# **Reading the Data:**

my.data <- read_csv("./basketball/Basketball.csv")

# **Inspecting the Data:**

head(my.data)
View(my.data)
glimpse(my.data)

# **Tidying the Data:**

# Transforming the data to a long format and relabeling gender

my_data_tidy <- my.data %>%
  pivot_longer(cols = c(female.player, male.player),    
               names_to = "gender",                    
               values_to = "player") %>%              
  mutate(gender = ifelse(gender == "female.player", "female", "male"))

# Spreading the data so that different statistics appear as separate columns

my_data_tidy <- my_data_tidy %>%
  pivot_wider(names_from = stat,       
              values_from = amount)

# Grouping and arranging by player for easier visualization

my_data_tidy <- my_data_tidy %>%
  group_by(player) %>%  
  arrange(player)

# **Viewing the Tidy Data:**

View(my_data_tidy)
glimpse(my_data_tidy)

# **Converting Year to a Factor:**

my_data_tidy <- my_data_tidy %>%
  mutate(year = as.factor(year))

# **Data Visualization Plot:**

ggplot(my_data_tidy, aes(x = gender, y = assists, fill = year)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Gender", y = "Assists") +
  theme_gray() +
  theme(
    text = element_text(size = 18)) +
  scale_fill_manual(name = "Year",values = c("1" = "#fd8472", "2" = "#219dad"))