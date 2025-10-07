setwd("C:/Users/ASUS/Downloads")
d <- read.csv("Mental_Health_Care_in_the_Last_4_Weeks.csv")

library(tidyverse)
library(ggplot2)

str(d)
summary(d)

d_age <- d %>% 
  filter(Indicator == "Took Prescription Medication for Mental Health, Last 4 Weeks" & Group == "By Age")

d_age <- d_age %>% drop_na(Value)
d_age$Value <- as.numeric(d_age$Value)

a_summary <- d_age %>% 
  group_by(Subgroup) %>% 
  summarise(
    Mean_Value = mean(Value),
    Median_Value = median(Value),
    Min_Value = min(Value),
    Max_Value = max(Value)
  )

print(a_summary)

ggplot(data = d_age, aes(x = Subgroup, y = Value)) +
  geom_boxplot() +
  labs(
    title = "Variation in Prescription Drug Use Across Age Categories",
    x = "Age Category",
    y = "Percentage (%)"
  ) +
  theme_minimal()
#3
library(dplyr) 

d_anxiety <- d %>%
  filter(Subgroup == "Experienced symptoms of anxiety/depression in past 4 weeks")

d_no_anxiety <- d %>%
  filter(Subgroup == "Did not experience symptoms of anxiety/depression in the past 4 weeks")

prevalence_anxiety <- mean(d_anxiety$Value)
prevalence_no_anxiety <- mean(d_no_anxiety$Value)

t_test_result <- t.test(d_anxiety$Value, d_no_anxiety$Value)
print(t_test_result)

ggplot(d, aes(x = Value, y = LowCI)) +
  geom_point() +
  facet_wrap(~Subgroup) +
  labs(title = "Scatterplot: Medication Use vs Anxiety/Depression Symptoms",
       x = "Prevalence of Medication Use (%)",
       y = "Low Confidence Interval") +
  theme_minimal()

library(broom)
d$Value <- as.numeric(d$Value)
med_symptoms <- d %>%
  filter(Subgroup %in% c("Did not experience symptoms of anxiety/depression in the past 4 weeks", 
                         "Experienced symptoms of anxiety/depression in past 4 weeks"))


med_symptoms$Symptoms <- ifelse(med_symptoms$Subgroup == "Experienced symptoms of anxiety/depression in past 4 weeks", 1, 0)



lm_model <- lm(Symptoms ~ Value, data = med_symptoms)

summary(lm_model)

lm_coefficients <- tidy(lm_model, conf.int = TRUE)

ggplot(med_symptoms, aes(x = Value, y = Symptoms)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Medication Use Value", y = "Symptoms (Binary)", title = "Linear Regression: Medication Use and Symptoms") +
  theme_minimal()
