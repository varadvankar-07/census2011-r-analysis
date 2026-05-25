# census2011-r-analysis
# ============================================================
# Census 2011 - Data Science Workflow in R
# ============================================================

# Load required libraries
library(readr)
library(plotrix)

# Set working directory and load data
setwd("C:/Users/Varad Vankar/R")
data <- read_csv("census2011.csv", show_col_types = FALSE)
print(data)

# Preview first 20 rows
data_20 <- head(data, 20)
print(data_20)

# ============================================================
# Descriptive Statistics
# ============================================================

min(data_20$Population)
max(data_20$Population)
mean(data_20$Population)
median(data_20$Population)

# Custom mode function
mode_value <- function(x) {
  unique_x <- unique(x)
  unique_x[which.max(tabulate(match(x, unique_x)))]
}
mode_value(data$Population)

# Summary statistics for first 20 rows
summary(data_20)

# ============================================================
# Maharashtra Analysis
# ============================================================

maharashtra <- subset(data_20, State == "Maharashtra")
quantile(maharashtra$Literacy)
var(maharashtra$Literacy)
sd(maharashtra$Literacy)

# ============================================================
# Bihar Analysis - Correlation & Covariance
# ============================================================

Bihar <- subset(data_20, State == "Bihar")
cov(Bihar$`Sex-Ratio`, Bihar$Literacy)
cor(Bihar$`Sex-Ratio`, Bihar$Literacy)

# ============================================================
# West Bengal - 3D Pie Chart (Literacy > 50)
# ============================================================

wb_data <- subset(data, State == "West Bengal" & Literacy > 50)

pie3D(wb_data$Literacy,
      labels = wb_data$District,
      main = "Literacy Rate > 50 in West Bengal",
      col = rainbow(nrow(wb_data)),
      explode = 0.1)

# ============================================================
# Karnataka Analysis - Data Cleaning & Subsetting
# ============================================================

# Check and clean Growth column (remove '%' and convert to numeric)
class(data_20$Growth)
unique(data_20$Growth)[1:5]
data_20$Growth <- as.numeric(gsub("%", "", data_20$Growth))

# Explore Karnataka ranges
karnataka_all <- subset(data, State == "Karnataka")
range(karnataka_all$Population)
range(karnataka_all$Growth)

# Filter Karnataka: Population < 5,000,000 and Growth > 10
ka_data <- subset(data, State == "Karnataka" & Population < 5000000 & Growth > 10)
nrow(ka_data)

# ============================================================
# Karnataka - Box Plot & Histogram (Sex-Ratio)
# ============================================================

# Box Plot
boxplot(ka_data$`Sex-Ratio`,
        main = "Sex-Ratio in Karnataka",
        ylab = "Sex-Ratio",
        xlab = "District",
        col = "steelblue",
        border = "darkblue")

# Histogram
hist(ka_data$`Sex-Ratio`,
     main = "Sex-Ratio in Karnataka",
     xlab = "Sex-Ratio",
     ylab = "Frequency",
     col = "steelblue",
     border = "white")
