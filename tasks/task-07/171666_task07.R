# # PPGCOMP - FURG | 23148P - Data Visualization and Exploratory Data Analysis | 02/2024 
# This notebook contains the solution for Task 07 of the course 23148P - Data Visualization and Exploratory Data Analysis - 02/2024 of the Graduate Program in Computing at FURG (PPGCOMP-FURG).

# **Professor:** Dr. Adriano Velasque Werhli.

# **Student:** Vitor Avelaneda.

# * **Contact:** avelaneda.vitor@gmail.com

# The repository with the notebooks can be accessed [here!](https://github.com/vitoravelaneda/23148P-Data_Visualization_and_Exploratory_Data_Analysis-PPGCOMP-FURG)

# ## Task:

# **Readings**

# For this class you should read topics 12.1, 12.4 from [here](https://clauswilke.com/dataviz/visualizing-associations.html), and the whole chapter [here](https://clauswilke.com/dataviz/time-series.html).

# **Scatter plot**

# - **a.** See the scatter plots [here](https://r-graph-gallery.com/50-51-52-scatter-plot-with-ggplot2.html). Create a dummy data set with 100 data points, $\{ x ∈ N, 1 ≤ x ≤ 100 \} $, where $y = \log(x) + N (\mu, \sigma^{2})$ with $\mu − 0$ and $\sigma = 0.2$. In R the normal distribution $N (\mu, \sigma^{2})$ is obtained with function rnorm.
#    - **1.** Create a scatter plot with this data.
#    - **2.** Add a linear trend using geom_smooth.
#    - **3.** Add the confidence interval.
#    - **4.** Add a LOESS trend with confidence interval.
#    - **5.** For LOESS try to use the parameter `span=0.2`.

# - **b.** Find a data set, or create one, for plotting a line graph similar to one of the examples [here](https://r-graph-gallery.com/line-plot.html).

# - **c.** Create a line plot where the x-axis represents time.

# ## Solutions:

# **Verify the installation of necessary packages.**

if (!requireNamespace("hrbrthemes", quietly = TRUE)) install.packages("hrbrthemes")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

# **Load necessary packages.**

library(hrbrthemes)
library(ggplot2)

# >**a.** See the scatter plots [here](https://r-graph-gallery.com/50-51-52-scatter-plot-with-ggplot2.html). Create a dummy data set with 100 data points, $\{ x ∈ N, 1 ≤ x ≤ 100 \} $, where $y = \log(x) + N (\mu, \sigma^{2})$ with $\mu − 0$ and $\sigma = 0.2$. In R the normal distribution $N (\mu, \sigma^{2})$ is obtained with function rnorm.

# Solution...

df <- data.frame(
  x = 1:100, 
  y = log(1:100) + rnorm(100, mean = 0, sd = 0.2) 
)

View(df)

# >**a. 1.** Create a scatter plot with this data.

# Solution...

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "black", size = 2) + 
  theme_minimal()

# >**a. 2.** Add a linear trend using geom_smooth.

# Solution...

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "black", size = 2) + 
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "solid") + 
  theme_minimal()

# >**a. 3.** Add the confidence interval.

# Solution...

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "black", size = 2) + 
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "solid") + 
  theme_minimal()

# >**a. 4.** Add a LOESS trend with confidence interval.

# Solution...

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "black", size = 2) + 
  geom_smooth(method = "loess", se = TRUE, color = "blue", linetype = "solid") + 
  theme_minimal()

# >**a. 5.** For LOESS try to use the parameter `span=0.2`.

# Solution...

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "black", size = 2) + 
  geom_smooth(method = "loess", span = 0.2, se = TRUE, color = "blue", linetype = "solid") + 
  theme_minimal()

# >**b.** Find a data set, or create one, for plotting a line graph similar to one of the examples [here](https://r-graph-gallery.com/line-plot.html).

# Create data set...

set.seed(123)
df_ts <- data.frame(
  Time = seq(as.Date("2010-01-01"), by = "month", length.out = 100),
  Value = rnorm(100, mean = 50, sd = 5) + seq(-10, 10, length.out = 100)
)
View(df_ts)

# >**c.** Create a line plot where the x-axis represents time.

# Solution...

ggplot(df_ts, aes(x = Time, y = Value)) +
  geom_line(color = "#69b3a2", size = 1) + 
  labs(
    title = "Fake Time Series",
    x = "Time",
    y = "Values"
  ) +
  theme_ipsum() + 
  theme(
    axis.title.x = element_text(size = 16, hjust = 0.5), 
    axis.title.y = element_text(size = 16, hjust = 0.5), 
    plot.title = element_text(size = 18, hjust = 0.5)
  )