# US Accident data analysis
install.packages("dplyr")
install.packages("janitor")
install.packages("ggplot2")
install.packages("crayon")
install.packages("corrplot")

library(dplyr)
library(janitor)
library(ggplot2)
library(crayon)
library(corrplot)
library(tidyverse)
library(multcomp)

# Set working directory
setwd("C:/Users/chris/Desktop/Data Projects 2023/Traffic Project/Data")

# Read the CSV file using the read.csv() function

data = read.csv("US_Accidents_Dec21_updated.csv", header = TRUE, stringsAsFactors = FALSE)

# Renaming columns

data_clean = data %>% clean_names()

# checking new names

colnames(data_clean)

# Pulls columns associated with weather, and removes missing values

weather_data <- data_clean %>%
  dplyr::select(severity, start_time, end_time, start_lat, start_lng, temperature_f, wind_chill_f, humidity, pressure_in, visibility_mi, wind_direction, wind_speed_mph, precipitation_in) %>%
  filter(!is.na(temperature_f) & !is.na(wind_chill_f) & !is.na(humidity) & !is.na(pressure_in) & !is.na(visibility_mi) & !is.na(wind_direction) & !is.na(wind_speed_mph) & !is.na(precipitation_in))

# Data analysis

# Summary of data

summary(weather_data)

# Correlation matrix

cor(weather_data[, c("severity", "temperature_f", "wind_chill_f", "humidity", "pressure_in", "visibility_mi", "wind_speed_mph")])

# Correlation between severity and temperature_f = -0.03856769, this indicates
# a week negative correlation. Severity and wind chill also weak neg 
# at -0.04194407. Correlation does not equal causation there may still be 
# a relationship.

#histogram for Severity

ggplot(weather_data, aes(x=severity)) + 
  geom_histogram(fill="lightblue", bins = 10) + 
  ggtitle("Histogram of Severity") +
  xlab("Severity") + ylab("Count")


# Density plot for temperature by severity

ggplot(weather_data, aes(x = temperature_f, fill = as.factor(severity))) +
  geom_density(alpha = 0.5) +
  ggtitle("Density Plot of Temperature by Severity Level") +
  xlab("Temperature (F)") +
  ylab("Density")

#Correlation Matrix plot
# Create a correlation matrix using the relevant columns
cor_matrix <- cor(weather_data[, c("temperature_f", "wind_chill_f", "humidity", "pressure_in", "visibility_mi", "wind_speed_mph", "precipitation_in")])

# Plot the correlation matrix
corrplot(cor_matrix, type = "upper", method = "circle", tl.col = "black", diag = FALSE)

# #In this case, we can see that temperature_f and wind_chill_f are highly positively correlated (correlation coefficient of 0.94), which is expected since wind chill is calculated based on temperature and wind speed.
# There is a moderate negative correlation between wind_speed_mph and pressure_in (-0.45), which suggests that as wind speed increases, air pressure tends to decrease, and vice versa.
# There is a weak negative correlation between humidity and pressure_in (-0.17), which suggests that there may be some relationship between these two variables, but it is not very strong.
# Other variables in the data set show little or no correlation with each other.

# Hypothesis Testing and ANOVA (Analysis of Variance)

#Performing Analysis of Variance 
# Null Hypothesis: There is no significant difference in the mean temperature between different severity levels.
# Alternative Hypothesis: There is a significant difference in the mean temperature between at least one pair of severity levels.

temp_by_severity = aov(temperature_f ~ severity, data = weather_data)

# Summarize the ANOVA results
summary(temp_by_severity)

# #The ANOVA table shows that there is a significant difference
# in the mean temperature among the different severity levels
# of weather conditions (F=3299, p<0.001). The null hypothesis
# can be rejected, and we can conclude that there is
# a statistically significant difference in the mean
# temperature for different severity levels.

# Post hoc tests to determine which groups
# differ significantly from each other, since ANOVA only tells
# us that there is a significant difference among the groups,
# but not which one is different.

# Convert 'severity' to factor
weather_data$severity <- as.factor(weather_data$severity)

# One-way ANOVA
model <- aov(temperature_f ~ severity, data = weather_data)
summary(model)

# Post hoc tests using Tukey's HSD method
TukeyHSD(model)

# The Tukey HSD compares the means of temperature for each
# severity level to each other.

# The p-values in this output are all 0, indicating that
# there is strong evidence to suggest that the mean 
# temperature differs significantly between each pair
# of severity levels.

# #Overall, this output suggests that severity level is a 
# significant predictor of temperature and that there are 
# significant differences in temperature between each pair 
# of severity levels.

#Conclusion

# Based on the results of the statistical analysis, we can
# draw some conclusions about the relationship between
# severity level and temperature in this dataset.

# First, the one-way ANOVA test indicates that there
# is a significant difference in mean temperature among
# the four severity levels (F = 3299, p < 0.001).
# This suggests that severity level may be a useful predictor
# of temperature.

# Second, the post-hoc Tukey multiple comparisons test
# shows that all pairs of severity levels have significantly
# different mean temperatures, except for severity levels 2 and 3.
# Specifically, severity level 4 has the lowest mean temperature
# , followed by severity level 1, then severity level 3,
# and finally severity level 2.

# These findings suggest that severity level may be a useful
# predictor of temperature, with higher severity levels
# associated with lower temperatures. However, further analysis
# is needed to determine the causal relationship between severity
# level and temperature, as well as to evaluate the predictive
# power of severity level in a larger, more diverse dataset.





















