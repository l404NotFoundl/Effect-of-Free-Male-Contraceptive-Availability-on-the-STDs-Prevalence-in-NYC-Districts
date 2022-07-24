![WCM_PopulationHealthSciences_LOGO_HZSS1L_CLR_RGB](https://user-images.githubusercontent.com/70513470/180572999-76810a03-3a0a-4dbe-b6fd-47b0b211dfec.png)



# Effect of Free Male Contraceptive Availability on the STDs Prevalence in NYC Districts
###### Author: Abdullah Altamammi; Jing Gao; Nathanael George
###### Database Management Final Project
###### Create Date: 07/22/2022
> Table of content:
- [Introduction](#introduction)
- [Methodology](#methodology)
  * [Constructing the OMOP Tables](#constructing-the-omop-tables)
  * [Creating Sample Patient Table](#creating-sample-patient-table)
  * [ETL Process of the Public Data Source](#etl-process-of-the-public-data-source)
  * [Creating Table_1](#creating-table_1)
  * [Analysis on Fake Data](#analysis-on-fake-data)
  * [Analysis on Real Data](#analysis-on-real-data)
  * [Comparing the Results](#comparing-the-results)
- [Result](#result)
- [Discussion](#discussion)
  * [Limitation](#limitation)
  * [Improvement](#improvement)
- [Conclusion](#conclusion)
- [Reference](#reference)


## Introduction


## Methodology

### Constructing the OMOP Tables

### Creating Sample Patient Table

```sql=
USE [DBMS Final Project]

CREATE TABLE PERSON(
	PID int NOT NULL,
	MRN int NOT NULL,
	Gender varchar(25) NULL,
	Race varchar(25) NULL,
	Age int NULL,
	Address varchar(250) NULL,
	ZIPcode varchar(25) NOT NULL,
	CONSTRAINT PID_PK PRIMARY KEY (PID),
	CONSTRAINT ZIPcode_FK FOREIGN KEY (ZIPcode) REFERENCES ZIPcode(ZIPcode)
	);

INSERT INTO PERSON VALUES(1001, 57011, 'Male', 'White', 25, '2425 Grand Avenue', '10468')
INSERT INTO PERSON VALUES(1002, 57012, 'Female', 'Asian', 37, '601 E 20th St', '10010')
INSERT INTO PERSON VALUES(1003, 57013, 'Female', 'Black', 23, '2830 Jackson Ave', '11101')
INSERT INTO PERSON VALUES(1004, 57014, 'Male', 'Black', 19, '310 W 55th St', '10019')
INSERT INTO PERSON VALUES(1005, 57015, 'Female', 'White', 22, '179 E 93rd St', '10128')
INSERT INTO PERSON VALUES(1006, 57016, 'Male', 'Hispanic', 31, '2642 Broadway', '10025')
INSERT INTO PERSON VALUES(1007, 57017, 'Female', 'Asian', 52, '327 E 116th St', '10029')
INSERT INTO PERSON VALUES(1008, 57018, 'Male', 'Black', 44, '456 Main St', '10044')
INSERT INTO PERSON VALUES(1009, 57019, 'Male', 'White', 28, '171 Wyckoff St', '11217')
INSERT INTO PERSON VALUES(1010, 57020, 'Female', 'Hispanic', 33, '443 Greene Ave', '11216')

SELECT *
FROM PERSON;

CREATE TABLE Condition_occurrence(
	CID varchar(25) NOT NULL,
	PID int NOT NULL,
	Condition_name varchar(25) NOT NULL,
	HIV_status varchar(25) NOT NULL,
	CONSTRAINT CID_PK PRIMARY KEY (CID),
	CONSTRAINT PID_FK FOREIGN KEY (PID) REFERENCES PERSON(PID)
	)

INSERT INTO Condition_occurrence VALUES('B20', 1001, 'HIV', 'Positive')
INSERT INTO Condition_occurrence VALUES('B20.1', 1002, 'HIV', 'Positive')
INSERT INTO Condition_occurrence VALUES('B20.2', 1003, 'HIV', 'Negative')
INSERT INTO Condition_occurrence VALUES('B21', 1004, 'HIV', 'Positive')
INSERT INTO Condition_occurrence VALUES('B21.1', 1005, 'HIV', 'Negative')
INSERT INTO Condition_occurrence VALUES('B22', 1006, 'HIV', 'Negative')
INSERT INTO Condition_occurrence VALUES('B23', 1007, 'HIV', 'Positive')
INSERT INTO Condition_occurrence VALUES('B24', 1008, 'HIV', 'Negative')
INSERT INTO Condition_occurrence VALUES('B22.1', 1009, 'HIV', 'Negative')
INSERT INTO Condition_occurrence VALUES('B23.2', 1010, 'HIV', 'Positive')

SELECT *
FROM Condition_occurrence;


CREATE TABLE Visit_occurrence(
	VID int NOT NULL,
	PID int NOT NULL,
	Test_type varchar(250) NULL,
	Site_ID int NULL,
	Test_date datetime NULL,
	Test_result varchar(250) NULL,
	CONSTRAINT VID_PK PRIMARY KEY (VID),
	FOREIGN KEY (PID) REFERENCES PERSON(PID)
	)

INSERT INTO Visit_occurrence VALUES(4801, 1001, 'HIV/AID Test', 810, '04-06-2015', 'Positive')
INSERT INTO Visit_occurrence VALUES(4802, 1002, 'HIV/AID Test', 53, '07-25-2015', 'Positive')
INSERT INTO Visit_occurrence VALUES(4803, 1003, 'HIV/AID Test', 90, '03-11-2014', 'Negative')
INSERT INTO Visit_occurrence VALUES(4804, 1004, 'HIV/AID Test', 167, '09-20-2014', 'Positive')
INSERT INTO Visit_occurrence VALUES(4805, 1005, 'HIV/AID Test', 822, '02-27-2015', 'Negative')
INSERT INTO Visit_occurrence VALUES(4806, 1006, 'HIV/AID Test', 524, '06-06-2015', 'Negative')
INSERT INTO Visit_occurrence VALUES(4807, 1007, 'HIV/AID Test', 119, '08-23-2015', 'Positive')
INSERT INTO Visit_occurrence VALUES(4808, 1008, 'HIV/AID Test', 605, '05-14-2015', 'Negative')
INSERT INTO Visit_occurrence VALUES(4809, 1009, 'HIV/AID Test', 442, '05-01-2015', 'Negative')
INSERT INTO Visit_occurrence VALUES(4810, 1010, 'HIV/AID Test', 542, '04-06-2015', 'Positive')

SELECT *
FROM Visit_occurrence;

CREATE TABLE Test_site(
	Site_ID int NOT NULL,
	Site_name varchar(250) NULL,
	Website varchar(250) NULL,
	Phone_num varchar(250) NULL,
	Address varchar(250) NULL,
	Borough varchar(250) NULL,
	ZIPcode varchar(25) NULL,
	CONSTRAINT Site_ID_PK PRIMARY KEY (Site_ID),
	FOREIGN KEY (ZIPcode) REFERENCES ZIPcode(ZIPcode)
	)

INSERT INTO Test_site VALUES(810, 'Office of the Manhattan Borough President', 'manhattanbp.nyc.gov', '212-669-8300', '1 Centre Street', 'Manhattan', '10007')
INSERT INTO Test_site VALUES(53, 'Clinic - Lenox Avenue', NULL, '(212) 961-5742', '115 West 116th Street', 'Manhattan', '10026')
INSERT INTO Test_site VALUES(90, 'HHC Gouverneur Health', 'http://www.nyc.gov/html/hhc/gouverneur/html/home/home.shtml', '(212) 238-7897', '227 Madison Street', 'Manhattan', '10002')
INSERT INTO Test_site VALUES(167, 'Morrisania Chest Center Clinic', NULL, '(718) 579-4157', '1309 Fulton Avenue', 'Bronx', '10456')
INSERT INTO Test_site VALUES(822, 'BronxCare Fulton Family Medicine', NULL, '(718) 901-8000', '1276 Fulton Avenue', 'Bronx', '10456')
INSERT INTO Test_site VALUES(524, 'Community Health Action of Staten Island- Main Office', 'http://chasiny.org', '718-808-1300', '56 Bay Street', 'Staten Island', '10301')
INSERT INTO Test_site VALUES(119, 'La Familia Unida', NULL, '(718) 292-3315', '541-549 East 138th Street', 'Bronx', '10454')
INSERT INTO Test_site VALUES(605, 'Metroplus Healthplan', NULL, '(212) 908-8600', '160 Water St', 'Manhattan', '10038')
INSERT INTO Test_site VALUES(442, 'Transdiaspora Network', NULL, NULL, NULL, NULL, NULL)
INSERT INTO Test_site VALUES(542, 'NYP - Westchester Division', 'http://nyp.org/facilities/westchester.html', '(914) 682-9100', '21 BLOOMINGDALE ROAD', 'Manhattan', '10605')

SELECT *
FROM Test_site;

CREATE TABLE ZIPcode(
	ZIPcode varchar(25) NOT NULL,
	Borough varchar(200) NOT NULL,
	City varchar(200) NOT NULL
	CONSTRAINT ZIPcode_PK PRIMARY KEY (ZIPcode)
	)

INSERT INTO ZIPcode VALUES('10468', 'Bronx', 'New York')
INSERT INTO ZIPcode VALUES('10010', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('11101', 'Queens', 'New York')
INSERT INTO ZIPcode VALUES('10019', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10128', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10025', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10029', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10044', 'Roosevelt Island', 'New York')
INSERT INTO ZIPcode VALUES('11217', 'Brooklyn', 'New York')
INSERT INTO ZIPcode VALUES('11216', 'Brooklyn', 'New York')
INSERT INTO ZIPcode VALUES('10007', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10026', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10002', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10456', 'Bronx', 'New York')
INSERT INTO ZIPcode VALUES('10301', 'Staten Island', 'New York')
INSERT INTO ZIPcode VALUES('10454', 'Bronx', 'New York')
INSERT INTO ZIPcode VALUES('10038', 'Manhattan', 'New York')
INSERT INTO ZIPcode VALUES('10605', 'Manhattan', 'New York')

SELECT *
FROM ZIPcode;


/* Create a sample patient table that includes some important 
   information of the Patient, Visit, and Conditions*/
SELECT p.PID, p.MRN, Age, Gender, Race, p.Address, p.ZIPcode, 
	   z.Borough, c.CID, c.Condition_name, c.HIV_status, 
	   v.Test_type, v.Test_date, v.Site_ID, v.Test_result
INTO Patient_Sample_Table
FROM PERSON AS p
INNER JOIN Condition_occurrence AS c
ON p.PID = c.PID
INNER JOIN Visit_occurrence AS v
ON v.PID = p.PID
LEFT JOIN ZIPcode AS z
ON p.ZIPcode = z.ZIPcode;

/* Check out the newly created sample patient table*/
SELECT *
FROM Patient_Sample_Table;
```
### ETL Process of the Public Data Source

### Creating Table_1
```sql=
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
```

### Analysis on Fake Data
```sql=
SELECT COUNT(PID) AS Count_of_Person, 
	   HIV_status, 
	   SUM(#_AvaiCond_inZip) AS Sum_of_AvaiCond_inZip,
	   SUM(#_AvaiCond_inBorough) AS Sum_of_AvaiCond_inBorough
FROM Table_1
GROUP BY HIV_status;
```

### Analysis on Real Data
```sql=
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
```

* Top 10 Zipcodes with the most available condom distribution centers that has free male condoms
```sql=
USE [DBMS Final Project]

SELECT TOP 10 *
INTO Top10_Zipcodes_#AvaiCond
FROM ZIP_vs_Condom
WHERE Zipcode NOT LIKE '0'
ORDER BY #_of_Available_Male_Condom DESC

SELECT *
FROM Top10_Zipcodes_#AvaiCond;
```

### Comparing the Results


## Result


## Discussion
### Limitation
### Improvement


## Conclusion


## Reference
