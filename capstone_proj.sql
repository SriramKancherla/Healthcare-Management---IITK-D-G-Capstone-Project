use sqllearners;

create schema healthcare;
use healthcare;
select * from healthcare.diabetic_data;

#Total Number of Patient Encounters
select count(*) as total_encounters from healthcare.diabetic_data;

#Top 10 Most frequent Diagnoses																																																																																																										
select diag_1 as diagnosis,count(*) as frequency from healthcare.diabetic_data group by diag_1 order by frequency desc limit 10;

#Avg length of hospital stay for each admission type 
select admission_type_id,avg(time_in_hospital) as avg_time_in_hospital from healthcare.diabetic_data group by admission_type_id;

#no of readmitted patients and their percentage out of total encounters
select count(*) as readmitted_count,round((count(*)*100.00/(select count(*) from healthcare.diabetic_data)),2) as percentage from healthcare.diabetic_data where readmitted = 'NO';

#age distribution of patients
select count(*) a	s patient_count,age from healthcare.diabetic_data group by age order by age;

#most common procedures
select medical_specialty,count(*) as procedure_count from healthcare.diabetic_data where medical_specialty is not null group by medical_specialty order by procedure_count desc limit 5;

#avg no of medications prescribes for patients accordin																																																																																																																																																																																																																																																																																																																																																																				g to each age group 
select age,avg(num_medications) as avg_no_of_medications from healthcare.diabetic_data group by age order by age;

#readmission rates across different payer codes
SELECT payer_code,sum(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) AS readmitted_count,count(*) AS total_encounters,
round((SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS readmission_rate
FROM healthcare.diabetic_data
GROUP BY payer_code
ORDER BY readmission_rate DESC;
