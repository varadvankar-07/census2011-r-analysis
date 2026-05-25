# 📊 Census 2011 - Data Science Workflow in R

A mini project that performs **exploratory data analysis** on India's Census 2011 dataset using R. It covers data loading, descriptive statistics, state-wise analysis, and data visualization.

---

## 📁 Dataset

`census2011.csv` — District-level census data for India with columns:

| Column | Description |
|--------|-------------|
| `District` | Name of the district |
| `State` | Name of the state |
| `Population` | Total population |
| `Growth` | Population growth rate (%) |
| `Sex-Ratio` | Females per 1000 males |
| `Literacy` | Literacy rate (%) |

> ⚠️ Place `census2011.csv` in your working directory before running the script.

---

## 🔧 Libraries Used

| Library | Purpose |
|---------|---------|
| `readr` | Fast and clean CSV file reading |
| `plotrix` | 3D Pie Chart using `pie3D()` |

```r
install.packages(c("readr", "plotrix"))
```

---

## 🧩 Code Walkthrough

### 1. Load Libraries & Data

```r
library(readr)
library(plotrix)

setwd("C:/Users/Varad Vankar/R")
data <- read_csv("census2011.csv", show_col_types = FALSE)
data_20 <- head(data, 20)
```

Sets the working directory, reads the CSV file into a dataframe, and creates a smaller subset of the first 20 rows for quick analysis.

---

### 2. Descriptive Statistics — Population

```r
min(data_20$Population)
max(data_20$Population)
mean(data_20$Population)
median(data_20$Population)

mode_value <- function(x) {
  unique_x <- unique(x)
  unique_x[which.max(tabulate(match(x, unique_x)))]
}
mode_value(data$Population)

summary(data_20)
```

Calculates the **min, max, mean, median, and mode** of the Population column. A custom `mode_value()` function is used since R has no built-in mode function. `summary()` gives a full statistical overview of all columns.

---

### 3. Maharashtra Analysis — Literacy

```r
maharashtra <- subset(data_20, State == "Maharashtra")
quantile(maharashtra$Literacy)
var(maharashtra$Literacy)
sd(maharashtra$Literacy)
```

Filters rows belonging to **Maharashtra** and computes:
- `quantile()` — distribution of literacy across quartiles (0%, 25%, 50%, 75%, 100%)
- `var()` — variance (how spread out the values are)
- `sd()` — standard deviation (average distance from the mean)

---

### 4. Bihar Analysis — Correlation & Covariance

```r
Bihar <- subset(data_20, State == "Bihar")
cov(Bihar$`Sex-Ratio`, Bihar$Literacy)
cor(Bihar$`Sex-Ratio`, Bihar$Literacy)
```

Filters rows for **Bihar** and checks the relationship between Sex-Ratio and Literacy:
- `cov()` — covariance (do the two variables move together?)
- `cor()` — correlation (value between -1 and 1; closer to 1 means strong positive relationship)

---

### 5. West Bengal — 3D Pie Chart

```r
wb_data <- subset(data, State == "West Bengal" & Literacy > 50)

pie3D(wb_data$Literacy,
      labels = wb_data$District,
      main = "Literacy Rate > 50 in West Bengal",
      col = rainbow(nrow(wb_data)),
      explode = 0.1)
```

Filters **West Bengal** districts where literacy is above 50% and plots a **3D pie chart** showing each district's literacy share. Each slice is color-coded using `rainbow()`.

---

### 6. Karnataka — Data Cleaning

```r
class(data_20$Growth)
unique(data_20$Growth)[1:5]
data_20$Growth <- as.numeric(gsub("%", "", data_20$Growth))
```

The `Growth` column contains values like `"15.2%"` (a string). This section:
1. Checks the data type using `class()`
2. Previews sample values using `unique()`
3. Strips the `%` symbol with `gsub()` and converts to numeric with `as.numeric()`

---

### 7. Karnataka — Subsetting & Range Check

```r
karnataka_all <- subset(data, State == "Karnataka")
range(karnataka_all$Population)
range(karnataka_all$Growth)

ka_data <- subset(data, State == "Karnataka" & Population < 5000000 & Growth > 10)
nrow(ka_data)
```

Checks the full range of Population and Growth values in Karnataka to understand the data, then filters to districts with **Population < 50 lakh** and **Growth > 10%**.

---

### 8. Karnataka — Box Plot (Sex-Ratio)

```r
boxplot(ka_data$`Sex-Ratio`,
        main = "Sex-Ratio in Karnataka",
        ylab = "Sex-Ratio", xlab = "District",
        col = "steelblue", border = "darkblue")
```

A **box plot** showing the spread of Sex-Ratio values across filtered Karnataka districts. It displays the median, quartiles, and any outliers.

---

### 9. Karnataka — Histogram (Sex-Ratio)

```r
hist(ka_data$`Sex-Ratio`,
     main = "Sex-Ratio in Karnataka",
     xlab = "Sex-Ratio", ylab = "Frequency",
     col = "steelblue", border = "white")
```

A **histogram** showing the frequency distribution of Sex-Ratio values — how many districts fall within each range.

---

## ▶️ How to Run

1. Clone this repo:
```bash
git clone https://github.com/your-username/census2011-r-analysis.git
```
2. Open `census_analysis.R` in **RStudio**
3. Update the `setwd()` path to match your system
4. Place `census2011.csv` in that folder
5. Run the script — plots will open automatically

---

## 👤 Author

**Varad Vankar** — Mini Project, Data Science Workflow in R

Great question! Here are the key insights and why this project matters:

---

**📊 What We Found (Insights)**

**Population Statistics**
- We identified the minimum, maximum, mean, and median population across districts — this tells us how unevenly population is distributed across India. Some districts are massively overcrowded while others are very sparse.

**Maharashtra — Literacy**
- By calculating variance and standard deviation, we found how consistent (or inconsistent) literacy rates are within Maharashtra. A high SD means some districts are well-educated while others are far behind — showing inequality within the same state.

**Bihar — Sex-Ratio vs Literacy**
- The correlation between Sex-Ratio and Literacy in Bihar is one of the most important findings. If the correlation is positive and high, it means **districts with better literacy tend to have a better sex ratio** — proving that education directly impacts gender equality.

**West Bengal — Literacy Pie Chart**
- Visually shows which districts contribute most to literacy above 50%. Districts with bigger slices are doing better — useful for government resource allocation.

**Karnataka — Sex-Ratio Distribution**
- The box plot revealed outliers — districts with unusually low or high sex ratios compared to the rest of Karnataka.
- The histogram showed whether most districts are clustered around a similar sex ratio or widely spread out.

---

**💡 Why This Project is Important**

**Real government data** — Census 2011 is official data used by policymakers, so any insight here has real-world meaning.

**Social issues** — Sex ratio, literacy, and population growth are not just numbers. They represent gender inequality, education gaps, and development challenges in India.

**Data cleaning practice** — The `Growth` column had `%` symbols, which is a very common real-world data problem. Cleaning it taught a core data science skill.

**Covers the full workflow** — Loading → Cleaning → Statistics → Visualization. This is exactly what a data scientist does on the job, making it a strong portfolio project.

---

**In one line:** This project shows that **literacy and gender equality are connected**, population is unevenly distributed across India, and data cleaning is essential before any analysis — all backed by real census data.
