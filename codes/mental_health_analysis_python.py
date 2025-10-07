import pandas as pd
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
dq = r'C:\Users\ASUS\Downloads'
os.chdir(dq)


import os
os.chdir(dq)
dv = pd.read_csv('Mental_Health_Care_in_the_Last_4_Weeks.csv')
print(dv.head())

dv_hispanic = dv[dv['Subgroup'] == 'Hispanic or Latino']
dv_white = dv[dv['Subgroup'] == 'Non-Hispanic White, single race']
dv_black = dv[dv['Subgroup'] == 'Non-Hispanic Black, single race']
dv_asian = dv[dv['Subgroup'] == 'Non-Hispanic Asian, single race']
dv_other = dv[dv['Subgroup'] == 'Non-Hispanic, other races and multiple races']

prev_rates = {
    'Hispanic or Latino': dv_hispanic['Value'].mean(),
    'Non-Hispanic White': dv_white['Value'].mean(),
    'Non-Hispanic Black': dv_black['Value'].mean(),
    'Non-Hispanic Asian': dv_asian['Value'].mean(),
    'Non-Hispanic Other': dv_other['Value'].mean()
}

print("Prevalence Rates:")
for group, rate in prev_rates.items():
    print(f"{group}: {rate:.2f}%")
	


dg_race = dv[dv['Group'] == 'By Race/Hispanic ethnicity']

prevalence_rates = dg_race.groupby('Subgroup')['Value'].mean().reset_index()

plt.figure(figsize=(10, 6))
sns.barplot(data=prevalence_rates, x='Subgroup', y='Value', palette='viridis')
plt.title('Prevalence of Prescription Medication Use Across Racial/Ethnic Groups')
plt.xlabel('Race/Ethnicity Subgroup')
plt.ylabel('Prevalence (%)')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()
