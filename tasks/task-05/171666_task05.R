# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 
# This notebook contains the solution for Task 05 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ## Solutions:

# **Verify the installation of necessary packages.**

if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

# **Load necessary packages.**

library(readr)
library(ggplot2)
library(RColorBrewer)
library(scales)

# **Reading the Data:**

my.data <- data.frame(read.csv("./data_mortalidade_Regiao.csv"))
linha<-c(6) 
my.data.novo <- my.data[-linha,]

# ### Exercise 1:

ggplot(my.data.novo, aes(x=Região, y=Total)) + 
  geom_bar(stat = "identity")

# ### Exercise 2:

ggplot(my.data.novo, aes(x=Região, y=Total)) + 
  geom_bar(stat = "identity",color="black", fill="darkorange2")

# ### Exercise 3:

ggplot(my.data.novo, aes(x=Região, y=Total, fill=Região)) + 
  geom_bar(stat = "identity",color="black")+
  scale_fill_brewer(palette = "Set3") 

# ### Exercise 4:

ggplot(my.data.novo, aes(x=Região, y=Total, fill=Região)) +
  geom_bar(stat = "identity",color="black") +
    scale_fill_manual(values =c('blue', 'darkolivegreen3', 'plum4', 'red', 'yellow3'))

# ### Exercise 5:

ggplot(my.data.novo, aes(x=reorder(Região, Total), y=Total, fill=Região)) +
  geom_bar(stat = "identity",color="black") +
  scale_fill_manual(values =c('blue', 'darkolivegreen3', 'plum4', 'red', 'yellow3'))

# ### Exercise 7:

ggplot(my.data.novo, aes(x=reorder(Região, Total), y=Total, fill=Região)) +
  geom_bar(stat = "identity",color="black") +
  scale_fill_manual(values =c('blue', 'darkolivegreen3', 'plum4', 'red', 'yellow3'))+
  labs(title= "Mortes no Brasil por região em 2021",x = "", y = "Total de Mortes")

# ### Exercise 8:

ggplot(my.data.novo, aes(x=reorder(Região, Total), y=Total, fill=Região)) +
  geom_bar(stat = "identity",color="black") +
  coord_flip()+
  scale_fill_manual(values =c('blue', 'darkolivegreen3', 'plum4', 'red', 'yellow3'))+
  labs(title= "Mortes no Brasil por região em 2021",x = "", y = "Total de Mortes")+
  scale_y_continuous(labels = comma_format(big.mark = ".",
                                           decimal.mark = ","))+  theme_light()+
  theme(
    text = element_text(size = 12),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank()
    )