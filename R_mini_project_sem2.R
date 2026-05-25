library(readr)
kgetwd()
setwd("C:/Users/Varad Vankar/R")
data <- read_csv("census2011.csv",show_col_types = FALSE)
print(data)

data_20 <- head(data, 20)

print(data_20)

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

maharashtra <- subset(data_20, State == "Maharashtra")
quantile(maharashtra$Literacy)

var(maharashtra$Literacy)

sd(maharashtra$Literacy)


Bihar <- subset(data_20, State == "Bihar")

cov(Bihar$`Sex-Ratio`,Bihar$Literacy)
cor(Bihar$`Sex-Ratio`, Bihar$Literacy)

#Plotting
wb_data <- subset(data, State == "West Bengal" & Literacy > 50)


library(plotrix)
pie3D(wb_data$Literacy,
      labels = wb_data$District,
      main = "Literacy Rate > 50 in West Bengal",
      col = rainbow(nrow(wb_data)),
      explode = 0.1)

ka_data <- subset(data, State == "Karnataka" & Population < 3000 & Growth > 15)

nrow(ka_data)
head(ka_data)
class(data_20$Growth)
class(data_20$Growth)        
unique(data_20$Growth)[1:5]
data_20$Growth <- as.numeric(gsub("%", "", data_20$Growth))
ka_data <- subset(data, State == "Karnataka" & Population < 3000 & Growth > 15)
nrow(ka_data) 
karnataka_all <- subset(data, State == "Karnataka")

range(karnataka_all$Population)  
range(karnataka_all$Growth)     

ka_data <- subset(data, State == "Karnataka" & Population < 5000000 & Growth > 10)
nrow(ka_data)
boxplot(ka_data$`Sex-Ratio`,
        main = "Sex-Ratio in Karnataka",
        ylab = "Sex-Ratio",
        xlab = "District",
        col = "steelblue",
        border = "darkblue")


hist(ka_data$`Sex-Ratio`,
     main = "Sex-Ratio in Karnataka",
     xlab = "Sex-Ratio",
     ylab = "Frequency",
     col = "steelblue",
     border = "white")

