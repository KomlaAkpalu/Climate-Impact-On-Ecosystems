### R Script for Data Analysis

## Set the working directory
setwd("C:/Users/julien/Desktop/PhD_50/ANTWERP")

#### Question 1: ANPP vs Annual Temperature Analysis
# Load necessary libraries
library(ggplot2)
# Reading the dataset
annual_production <- read.csv("annual_production.csv")
# Plotting ANPP vs Annual Temperature
ggplot(annual_production, aes(x=ANNUAL_TEMPERATURE, y=ANPP)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title="ANPP vs Annual Temperature", x="Annual Temperature", y="ANPP") +
  theme_minimal()
# Linear model
lm_result <- lm(ANPP ~ ANNUAL_TEMPERATURE, data = annual_production)
summary(lm_result)

#### Question 2: Logarithmic Transformation and Kruskal-Wallis Test
library(dplyr)
# Transform ANPP values to logarithmic scale and add it to the dataframe
annual_production <- annual_production %>%
  mutate(logANPP = log(ANPP))
# Kruskal-Wallis test
kruskal.test(logANPP ~ MANAGEMENT, data = annual_production)

#### Question 3: Fungal Richness in Microbial Diversity
library(tidyr)
# Reading the dataset
microbial_diversity <- read.csv("microbial_diversity.csv")
# Calculating fungal richness (number of non-zero OTUs) for each sample
microbial_diversity$fungal_richness <- rowSums(microbial_diversity[, grepl("OTU_", names(microbial_diversity))] > 0)
# Plotting Fungal Richness vs Soil Temperature for each grassland type
ggplot(microbial_diversity, aes(x=AverageTemperature, y=fungal_richness, color=grassland)) +
  geom_point() +
  facet_wrap(~grassland) +
  labs(title="Fungal Richness vs Soil Temperature", x="Average Temperature", y="Fungal Richness") +
  theme_minimal()
