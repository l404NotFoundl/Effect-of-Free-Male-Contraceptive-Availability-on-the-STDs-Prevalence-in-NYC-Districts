USE [DBMS Final Project]

SELECT TOP 10 *
INTO Top10_Zipcodes_#AvaiCond
FROM ZIP_vs_Condom
WHERE Zipcode NOT LIKE '0'
ORDER BY #_of_Available_Male_Condom DESC

SELECT *
FROM Top10_Zipcodes_#AvaiCond;
