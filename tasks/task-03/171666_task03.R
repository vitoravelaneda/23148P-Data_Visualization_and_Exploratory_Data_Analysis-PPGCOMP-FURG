# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 
# This notebook contains the solution for Task 03 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ### Exercises
# 1. Load the tab delimited file small_file.txt using the function read_delim. The
# loaded data should be attributed to the variablem my.data. After having the data in
# the variable:
#     * Inspect the data with the function `head()`, `view()` and `glimpse()`
#     * Using the function `filter()` from tidyverse library show only the rows that are from category D
#     * Using the solution above, show only rows with category D and ordered by lenght
#     * Calculate de mean of the Lenght of Category D and of Category A using the filters above and the function `mean()`. Remember that you can attribute the resulto of a pipe to a variable.

# 2. You have been provided the file student_grade.csv. Load this data and put it in a
# tidy format. Think about:
#     * Which of the columns are annotations and which are measurements?
#     * How many different types of measurement are there?
#     * Are all of the measurements of the same type in a single column?
#     * What is the name of the variable being measured? I has its name in on column?
#     * After tidying are there any NA values which should be removed?
#     * Are there any columns with repeated information in its rows that should be removed?
#     * Remove NA
#     * What is the mean and standard deviation of the grades in questions 1 and 2?

# ### Solution 1:

# Importing the data and assigning it to the variable `my.data`.

my.data <- read.delim('small_file.txt', header = TRUE)

# Checking if the dplyr package is installed and importing the package:

if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
library(dplyr)

# Visualizing the data:

head(my.data)
View(my.data)
glimpse(my.data)

# Filtering the data by `category == D`.

my.data %>%
  filter(Category == "D")

# Organizing `category == D` by `Length`.

my.data %>%
  filter(Category == "D") %>%
  arrange(Length)

# Calculating the mean of `Length`:

D_data <- data.frame(
  my.data %>%
    filter(Category == "D")
)

mean(D_data$Length)

# Assigning the mean to the variable `D_mean`:

D_mean <- my.data %>%
  filter(Category == "D") %>%
  summarise(mean_length_D = mean(Length)) %>%
  pull(mean_length_D)

# Calculating the mean of `Length`:

A_data <- data.frame(
  my.data %>%
    filter(Category == "A")
)

mean(A_data$Length)

# Filtering the data by `category == A`, calculating the `mean` of `Length`, and assigning it to the variable `A_mean`.

A_mean <- my.data %>%
  filter(Category == "A") %>%
  summarise(mean_length_A = mean(Length)) %>%
  pull(mean_length_A)

# ### Solution 2:

# Checking if the `readr` package is installed and importing the package:

if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
library(readr)

# Importing the data and assigning it to the variable `my.data2`.

my.data2 <- read_csv("student_grade.csv")

# Visualizing the data:

View(my.data2)
glimpse(my.data2)

# > Which of the columns are annotations and which are measurements?

# * The columns `Year`, `Class`, and `Students` are annotations, and the others are measures.

# > How many different types of measurement are there?

# * The data contains 11 measurement columns, each associated with a different question and representing each student's score.

# > Are all of the measurements of the same type in a single column?

# * No. The data contains multiple columns with scores assigned to each question.

# > What is the name of the variable being measured? I has its name in on column?

# * Analyzing the context of the data, the columns from Q1 to Q11 represent different questions from an assessment. They do not have clear names but are likely scores obtained in the evaluation.

# > After tidying are there any NA values which should be removed?

if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")

library(tidyr)
library(stringr)

my.data2.tidy <- my.data2 %>%
  pivot_longer(cols = starts_with("Q"),
               names_to = "Question",
               values_to = "Score") %>%
  mutate(Question = str_remove(Question, "Q"))

head(my.data2.tidy)

# * Yes, there are NA values to be removed

# > Are there any columns with repeated information in its rows that should be removed?

# * There is a column for the year and another for the student's class; although this data may be repetitive, it is still important.

# > Remove NA

my.data2.tidy <- my.data2.tidy %>%
  drop_na()

head(my.data2.tidy)

# > What is the mean and standard deviation of the grades in questions 1 and 2?

# Mean and standard deviation Question 1:

stats_question1 <- my.data2.tidy %>%
  filter(Question == 1) %>%
  summarise(
    mean_score = mean(Score, na.rm = TRUE),
    sd_score = sd(Score, na.rm = TRUE)
  )

stats_question1

# Mean and standard deviation Question 2:

stats_question2 <- my.data2.tidy %>%
  filter(Question == 2) %>%
  summarise(
    mean_score = mean(Score, na.rm = TRUE),
    sd_score = sd(Score, na.rm = TRUE)
  )

stats_question2