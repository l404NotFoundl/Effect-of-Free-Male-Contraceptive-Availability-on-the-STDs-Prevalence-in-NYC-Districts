USE [DBMS Final Project]

/* Create a table that has all unique Zipcodes and the # of available male condoms in each Zipcode (area) */
SELECT Zipcode, COUNT(Condoms_Male) AS #_of_Available_Male_Condom
INTO ZIP_vs_Condom
FROM NYC_Condom_Availability
GROUP BY Zipcode

SELECT * FROM ZIP_vs_Condom;


/* Create a table that has all unique boroughs and the average HIV diagnosis rate in each borough */
SELECT Borough, AVG(HIV_diagnosis_rate) AS Avg_HIV_diag_rate
INTO Borough_vs_Avg_diagrate
FROM HIV_AIDS_Annual_Report_2016
WHERE Borough NOT LIKE 'All'
GROUP BY Borough
ORDER BY Avg_HIV_diag_rate

SELECT * FROM Borough_vs_Avg_diagrate;

/* Link all the tables together into Table_1 and select the useful columns */
SELECT p.PID, 
	   MRN, 
	   Gender, 
	   Race, 
	   Age, 
	   p.Address, 
	   z1.Borough, 
	   p.ZIPcode, 
	   c.HIV_status, 
	   z.#_of_Available_Male_Condom AS #_AvaiCond_inZip,
	   b1.#_Available_Male_Condom AS #_AvaiCond_inBorough,
	   b.Avg_HIV_diag_rate AS Avg_HIV_DiagRate_by_Borough
INTO Table_1
FROM PERSON AS p
LEFT JOIN ZIP_vs_Condom AS z
ON p.ZIPcode = z.Zipcode
LEFT JOIN Condition_occurrence AS c
ON c.PID = p.PID
LEFT JOIN ZIPcode AS z1
ON z1.ZIPcode = p.ZIPcode
LEFT JOIN Borough_vs_Avg_diagrate AS b
ON b.Borough = z1.Borough
LEFT JOIN Condom_by_Borough AS b1
ON b1.Borough = z1.Borough
ORDER BY PID;

SELECT * FROM Table_1;


SELECT COUNT(PID) AS Count_of_Person, 
	   HIV_status, 
	   SUM(#_AvaiCond_inZip) AS Sum_of_AvaiCond_inZip,
	   SUM(#_AvaiCond_inBorough) AS Sum_of_AvaiCond_inBorough
FROM Table_1
GROUP BY HIV_status;