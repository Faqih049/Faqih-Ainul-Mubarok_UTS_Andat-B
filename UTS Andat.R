# Read Data
library(readr)
getwd()
setwd("D:/")
dataandat = read.csv("Analisis Data.CSV", sep=";", header=T)
dataandat

#Check the Packaging
nrow(dataandat)
ncol(dataandat)
str(dataandat)

#look at the top and the bottom of your data
head(dataandat[,c(2:8)])
tail(dataandat[,c(2:8)])


#Checking Your "n" s
table(dataandat$time_spend_company)
colSums(is.na(dataandat))
dim(dataandat)

#Validate with at least one external data source
summary(dataandat$satisfaction_level)
quantile(dataandat$satisfaction_level, seq(0, 1, 0.1), na.rm = TRUE)

#Make a Plot
library(ggplot2)
ggplot(dataandat, aes(x = as.factor(time_spend_company), y = satisfaction_level, 
                      fill = as.factor(time_spend_company))) +
  geom_boxplot() +
  labs(title = "Boxplot Tingkat Kepuasan Berdasarkan Lama Bekerja di Perusahaan",
       x = "Time Spent in Company",
       y = "Satisfaction Level") 

#try the easy solution first
library(dplyr)
  dataandat %>%
    group_by(time_spend_company) %>%
    summarize(
      mean_satisfaction = mean(satisfaction_level, na.rm = TRUE),
      median_satisfaction = median(satisfaction_level, na.rm = TRUE))

  
# Model
model = lm(satisfaction_level ~ time_spend_company, data = dataandat)
summary(model)

# Membuat histogram untuk satisfaction_level
hist(dataandat$satisfaction_level, 
     main="Histogram Satisfaction Level",
     xlab="Satisfaction Level",
     col="lightblue", 
     border="black", 
     breaks=20)
# Menghitung rata-rata dan simpangan baku
mean_satisfaction <- mean(dataandat$satisfaction_level, na.rm = TRUE)
sd_satisfaction <- sd(dataandat$satisfaction_level, na.rm = TRUE)

# Plot histogram data dan overlay distribusi normal
hist(dataandat$satisfaction_level, 
     main="Histogram vs. Normal Distribution", 
     xlab="Satisfaction Level", 
     col="lightblue", 
     border="black", 
     breaks=20, 
     probability=TRUE)

# Overlay distribusi normal
curve(dnorm(x, mean=mean_satisfaction, sd=sd_satisfaction), 
      col="red", 
      lwd=2, 
      add=TRUE)
