create schema lneralerProject;
select * from `lneralerProject`.`Mental_Health_Care_in_the_Last_4_Weeks` limit 100 ;

    
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
