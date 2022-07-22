USE [DBMS Final Project]

/* Create a tbale that has all unique Boroughs and the number of 
   available male comdoms in each borough */
SELECT Borough, COUNT(Condoms_Male) AS #_Available_Male_Condom
INTO Condom_by_Borough
FROM NYC_Condom_Availability
WHERE Borough NOT LIKE 'NULL'
GROUP BY Borough

SELECT * FROM Condom_by_Borough;


/* Create a table that has all unique Boroughs and the average 
   HIV diagnosis rate in each borough */
SELECT Borough, AVG(HIV_diagnosis_rate) AS Avg_HIV_Diag_Rate
INTO HIV_DiagRate_by_Borough
FROM HIV_AIDS_Annual_Report_2016
WHERE Borough NOT LIKE 'ALL'
GROUP BY Borough

SELECT * FROM HIV_DiagRate_by_Borough;


/* Join the 2 tables */
SELECT c.Borough, #_Available_Male_Condom, h.Avg_HIV_Diag_Rate
INTO Borough_#ofCondoms_AvgHIVdiagRate
FROM Condom_by_Borough AS c
INNER JOIN HIV_DiagRate_by_Borough AS h
ON c.Borough = h.Borough
ORDER BY #_Available_Male_Condom, Avg_HIV_Diag_Rate

SELECT * FROM Borough_#ofCondoms_AvgHIVdiagRate
ORDER BY Avg_HIV_Diag_Rate;