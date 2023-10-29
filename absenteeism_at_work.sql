--crear unión de tablas
select * from Absenteeism_at_work as a
	left join compensation as c
		on a.ID = c.ID
	left join Reasons as r
		on a.Reason_for_absence = r.Number;

--encontrar empleados más saludables para bono de transporte
select * from Absenteeism_at_work
	where Social_drinker = 0 
	and Social_smoker = 0
	and Body_mass_index < 25
	and Absenteeism_time_in_hours < (select Avg(Absenteeism_time_in_hours) from Absenteeism_at_work);

--optimizar consulta
select 
	a.ID,
	r.Reason,
	Body_mass_index,
	Month_of_absence,
		CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
			 WHEN Body_mass_index between 18.5 and 25 THEN 'Healthy Weight'
			 WHEN Body_mass_index between 25 and 30 THEN 'Overweight'
			 WHEN Body_mass_index > 30 THEN 'Obese'
		ELSE 'Unknown' END as BMI_Category,
		CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
			 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
			 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
			 WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
		ELSE 'Unknown' END as Seasons_names,
	Day_of_the_week,
	Transportation_expense,
	Education,
	Son,
	Social_drinker,
	Social_smoker,
	Pet,
	Disciplinary_failure,
	Work_load_Average_day,
	Absenteeism_time_in_hours
	from Absenteeism_at_work as a
	left join compensation as c
		on a.ID = c.ID
	left join Reasons as r
		on a.Reason_for_absence = r.Number;