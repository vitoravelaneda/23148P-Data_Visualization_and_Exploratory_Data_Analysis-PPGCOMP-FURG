# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 
# This notebook contains the solution for Task 06 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ## Solutions:

# **Verify the installation of necessary packages.**

if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")
if (!requireNamespace("showtext", quietly = TRUE)) install.packages("showtext")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

# **Load necessary packages.**

library(ggplot2)
library(tidyverse)
library(RColorBrewer)
library(showtext)
library(scales)

# ### Tidy Data:

# **Reading the Data:**

my.data <- data.frame(read.csv("../task-05/data_mortalidade_Regiao.csv"))

head(my.data)

# **Remove `Total` line:**

linha<-c(6) 
df <- my.data[-linha,]
head(df)

# **Rename age group columns by range:**

df <- rename(df, '<1' = 'Menor.1.ano')
df <- rename(df, '1~4' = 'X1.a.4.anos')
df <- rename(df, '5~9' = 'X5.a.9.anos')
df <- rename(df, '10~14' = 'X10.a.14.anos')
df <- rename(df, '15~19' = 'X15.a.19.anos')
df <- rename(df, '20~29' = 'X20.a.29.anos')
df <- rename(df, '30~39' = 'X30.a.39.anos')
df <- rename(df, '40~49' = 'X40.a.49.anos')
df <- rename(df, '50~59' = 'X50.a.59.anos')
df <- rename(df, '60~69' = 'X60.a.69.anos')
df <- rename(df, '70~79' = 'X70.a.79.anos')
df <- rename(df, '>80' = 'X80.anos.e.mais')
df <- rename(df, 'Ignorada' = 'Idade.ignorada')

head(df)

# **Remove `Total` column:**

df$Total <- NULL

head(df)

# **Transforming the data frame `df` from `wide` to `long` format:**

df_long <- df %>%
  pivot_longer(cols = -Região, names_to = "FaixaEtaria", values_to = "TotalMortes")

head(df_long)

# **Reordering by age group:**

df_long$FaixaEtaria <- factor(df_long$FaixaEtaria, levels = c(
    "<1", "1~4", "5~9", "10~14", "15~19", "20~29", "30~39", "40~49", 
    "50~59", "60~69", "70~79", ">80", "Ignorada"
    ))

head(df_long)


# ### Exercise 1:

ggplot(df_long, aes(x = Região, y = TotalMortes, fill = FaixaEtaria)) +
  geom_bar(stat = "identity", position = "dodge",color="black") +
  labs(title = "Mortes no Brasil por região em 2021", x = "", y = "Total de Mortes") +
  scale_fill_brewer(palette = "Paired") +
  theme_light() +
  theme(legend.position = "right", legend.title = element_text(size = 10))

# ### Exercise 2:

ggplot(df_long, aes(x = Região, y = TotalMortes, fill = FaixaEtaria)) +
  geom_bar(stat = "identity", position = "stack",color="black") +
  labs(title = "Mortes no Brasil por região em 2021", x = "", y = "Total de Mortes") +
  scale_fill_brewer(palette = "Set3") +
  theme_light() +
  theme(legend.position = "right", legend.title = element_text(size = 10))

# ### Exercise 3:

ggplot(df_long, aes(x = Região, y = TotalMortes, fill = FaixaEtaria)) +
  geom_bar(stat = "identity", position = "fill", color="black") +
  labs(title = "Mortes no Brasil por região em 2021", 
       x = "", y = "Total de Mortes") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_brewer(palette = "Paired", name = "Faixa Etária") +
  theme_minimal() +
  theme(legend.position = "right", legend.title = element_text(size = 10))

# ### Exercise 4:

ggplot(df_long, aes(x = Região, y = FaixaEtaria, fill = TotalMortes)) +
  geom_tile() +
  labs(x = "Região", y = "FaixaEtaria") +
  scale_fill_distiller(palette = "Spectral", name = "NroMortes") +
  theme_minimal() +
  theme(legend.position = "right", legend.title = element_text(size = 10),
        axis.text.x = element_text(angle = 45, hjust = 1))

# ### Exercise 5:

ggplot(df_long, aes(x = Região, y = FaixaEtaria, fill = TotalMortes)) +
  geom_tile(color = "black") +
  geom_text(aes(label = TotalMortes), color = "black", size = 5) +
  labs(x = "Região", y = "Faixa Etária") +
  scale_fill_distiller(palette = "Spectral", name = "NroMortes") +
  theme_minimal() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size = 10),
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1), 
    axis.text.y = element_text(size = 12),  
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14)
  )