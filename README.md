# Demographic Disparities in Mental Health Medication Use — A U.S. Study

## Overview
This project explores how **prescription drug use for mental health** varies across demographic groups in the United States, analyzing data by **age**, **race/ethnicity**, **gender**, **anxiety/depression symptoms**, **education**, and **state**.  
The dataset — *“Mental_Health_Care_in_the_Last_4_Weeks”* — was sourced from [Data.gov](https://catalog.data.gov/dataset/mental-health-care-in-the-last-4-weeks).

It integrates **SQL**, **Python**, and **R** for data processing, analysis, and visualization to highlight disparities in access and treatment patterns across demographic groups.

---

## Repository Structure

```
Data_engineer_projects/
│
├── Codes/
│   ├── sql_analysis.sql
│   ├── mental_health_pythoncode.py
│   └── mental_health_analysis_R.R
│
├── data/
│   └── Mental_Health_Care_in_the_Last_4_Weeks.csv
|──images/
```

---

## SQL Analysis — Regional Trends

**File:** `sql_analysis.sql`

### Steps to Run
1. Import the dataset into your SQL environment (MySQL, AWS RDS, or DuckDB).  
2. Create schema and table:
   ```sql
   CREATE SCHEMA lneralerProject;
   ```
3. Query the data sample:
   ```sql
   SELECT * 
   FROM `lneralerProject`.`Mental_Health_Care_in_the_Last_4_Weeks`
   LIMIT 100;
   ```
4. Aggregate and calculate state-wise medication usage:
   ```sql
   CREATE TEMPORARY TABLE temp_agg_data_1 AS
   SELECT 
       State,
       AVG(Value) AS Avg_Medication_Use,
       COUNT(*) AS Total_Respondents
   FROM 
       `lneralerProject`.`Mental_Health_Care_in_the_Last_4_Weeks`
   WHERE 
       Indicator = 'Took Prescription Medication for Mental Health, Last 4 Weeks'
   GROUP BY 
       State;

   SELECT 
       State,
       Avg_Medication_Use,
       Total_Respondents,
       (Avg_Medication_Use / Total_Respondents) * 100 AS Percentage_Medication_Use
   FROM 
       temp_agg_data_1
   ORDER BY 
       Percentage_Medication_Use DESC;
   ```

This produces a state-wise ranking of mental health medication usage.

---

## Python Analysis — Race & Ethnicity

**File:** `mental_health_pythoncode.py`

### Steps to Run
1. Place the dataset in your working directory (e.g., `Downloads` or your repo folder).  
2. Run the following script:
   ```python
   import pandas as pd
   import matplotlib.pyplot as plt
   import seaborn as sns
   import os

   dq = r'C:\Users\ASUS\Downloads'
   os.chdir(dq)
   dv = pd.read_csv('Mental_Health_Care_in_the_Last_4_Weeks.csv')

   dv_race = dv[dv['Group'] == 'By Race/Hispanic ethnicity']
   prevalence_rates = dv_race.groupby('Subgroup')['Value'].mean().reset_index()

   plt.figure(figsize=(10, 6))
   sns.barplot(data=prevalence_rates, x='Subgroup', y='Value', palette='viridis')
   plt.title('Prevalence of Prescription Medication Use Across Racial/Ethnic Groups')
   plt.xlabel('Race/Ethnicity Subgroup')
   plt.ylabel('Prevalence (%)')
   plt.xticks(rotation=45, ha='right')
   plt.tight_layout()
   plt.show()
   ```

This script computes average prevalence by racial/ethnic group and visualizes it as a bar chart.

---

## R Analysis — Age and Anxiety/Depression

**File:** `mental_health_analysis_R.R`

### Steps to Run
1. Set working directory and load data:
   ```R
   setwd("C:/Users/ASUS/Downloads")
   d <- read.csv("Mental_Health_Care_in_the_Last_4_Weeks.csv")
   ```
2. Load required libraries:
   ```R
   library(tidyverse)
   library(ggplot2)
   library(dplyr)
   library(broom)
   ```
3. Analyze medication use by age:
   ```R
   d_age <- d %>% 
     filter(Indicator == "Took Prescription Medication for Mental Health, Last 4 Weeks" & Group == "By Age") %>% 
     drop_na(Value)

   ggplot(data = d_age, aes(x = Subgroup, y = Value)) +
     geom_boxplot() +
     labs(title = "Variation in Prescription Drug Use Across Age Categories",
          x = "Age Category", y = "Percentage (%)") +
     theme_minimal()
   ```
4. Compare groups with and without anxiety/depression:
   ```R
   d_anxiety <- d %>% filter(Subgroup == "Experienced symptoms of anxiety/depression in past 4 weeks")
   d_no_anxiety <- d %>% filter(Subgroup == "Did not experience symptoms of anxiety/depression in the past 4 weeks")

   t_test_result <- t.test(d_anxiety$Value, d_no_anxiety$Value)
   print(t_test_result)
   ```

This compares prevalence across age groups and tests the relationship between medication use and anxiety symptoms.

---

## AWS Integration

The dataset can be hosted and analyzed using **AWS RDS** and **S3**:

- Upload the dataset to an **S3 bucket**.  
- Connect your **AWS RDS MySQL** instance using Workbench or SQL client.  
- Execute queries from `sql_analysis.sql` for regional analysis and aggregation.

---
##Images
Contains images of results

## Key Findings

- **Age:** 50–59 age group shows the highest medication use.  
- **Gender:** Women show higher prevalence than men.  
- **Race/Ethnicity:** Non-Hispanic White > Hispanic/Latino > Black > Asian.  
- **Symptoms:** Individuals with anxiety/depression symptoms use medications about 3× more.  
- **Region:** West Virginia has the highest usage; Hawaii has the lowest.  

---

## References

- [Mental Health Care in the Last 4 Weeks — Data.gov](https://catalog.data.gov/dataset/mental-health-care-in-the-last-4-weeks)  
- Villaume et al., *JAMA Network Open*, 2023  
- Johnson et al., *Journal of Health and Social Behavior*, 2021  
- Askari et al., *Community Mental Health Journal*, 2022  

---

## Author

**Lavanya Nerale Ramesh**   
Email: lavanya03398@gmail.com

