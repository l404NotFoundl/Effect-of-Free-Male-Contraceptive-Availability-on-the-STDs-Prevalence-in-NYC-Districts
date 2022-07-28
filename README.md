![WCM_PopulationHealthSciences_LOGO_HZSS1L_CLR_RGB](https://user-images.githubusercontent.com/70513470/180572999-76810a03-3a0a-4dbe-b6fd-47b0b211dfec.png)



# Effect of Free Male Contraceptive Availability on the HIV Prevalence in NYC Districts

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


## **Introduction**

Over the past 6 years, the New York Department of Health and Mental Hygiene (NYC DOHMH) had been actively monitoring the NYC Condom Availability Program and collecting the data from different sources. This program was designed to provide free male condoms and other sexually related products to the public, such as female condoms, lubricant, etc. Not only the NYC DOHMH wanted to know the effect of distributing free male contraceptives on the prevalence of Sexually Transmitted Diseases (STDs) in the city, they also wanted to use the analytic methods to further understand the advantage and drawbacks of delivering free condoms to the public and alter the related public health policies based on the analysis results.

Aside from the government agencies, there were other private institutions who also provided male contraceptives, like the Male Contraceptive Project. By providing free access to contraceptives, the NYC DOHMH and other related research facilities were expecting a reduction in the unwanted pregnancies and STDs in the community and as a result reducing the future healthcare costs.

To further analyze the influence of having free available contraceptives in the communities in different district in the New York City and their correlation with the prevalence of HIV, our research team raised the research question: How does the availability of free contraceptives in NYC affect HIV rates in the respective communities?

In our project, we extracted 3 relavant public available datasets from NYC OpenData ('https://opendata.cityofnewyork.us/'). These datasets include "**NYC Condom Availability Program - HIV condom distribution locations**", "**DOHMH HIV/AIDS Annual Report**", and fianlly the "**HIV Testing Locations**". The "NYC Condom Availability Program" contains a list of over 325 venues across the five boroughs in NYC that actively distribute free safer sex products. The creation and maintenance of the online dataset is supported by the NYC Department of Health and Mental Hygiene. This dataset also covers some geographic information on those locations, like open hours, address, zipcode, coordinates, etc. The "DOHMH HIV/AIDS Annual Report" contains data reported to the HIV Epidemiology and Field Services Program. It includes some information like HIV diagnosis rates by borough in NYC, HIV diagnosis rates by gender, HIV diagnosis rates by age and race, etc. The "HIV Testing Locations" has the location and facility information for places in New York City that provide HIV testing. In this dataset, the Site ID, Site name, hours of operation and agencies are listed separately.

In addition to the real public data source, we also created some fake HIV patients' data that can be used as a reference to compare the result. The fake datasets were built using the Microsoft SQL Server 2018. The fake datasets follows the OMOP Common Data Model framework. The fake datasets will be connected with the 3 real datasets  from NYC Open Data to analyze the relationship between the fake patients' HIV status and the availability of the free male condoms in the area and district. To better visualize the condom distribution density in the NYC, we also built the heat maps and marker maps using the Google Geocoding API.  

## **Methodology**

### Constructing the OMOP Tables
![image](https://user-images.githubusercontent.com/70513470/181394484-676f83d0-2622-407e-be1b-01c9ff818baf.png "ER Diagram of the OMOP Tables")<center>[Figure 1. ER Diagram for Fake Patients]</center>

The fake database was created in the Microsoft SQL Server 2018 following the OMOP common data model framework. To have more information diversity in our study, we decided to use 5 different tables to built this relational database: **PERSON**, **Condition_occurrence**, **Visit_occurrence**, **ZIPcode**, and **Test_site**.

In the **PERSON** table, we set the Patient ID (PID) as the primary key, and the Medical Record Number (MRN) as the candidate key. The ZIPcode was set as the foreign key to link with other tables in the database. We also made some fake demographic information for each patient, including the Gender, Race, Age, Address, and ZIPcode. This table provided some basic information for each patient. After creating the table in the database, we made 10 fake patients and filled in some fake values for each field in the table with no missing values.

In the **Condition_occurrence** table, we set the Condition ID (CID) as the primary key and the Patient ID (PID) as the foreign key to link with the **PERSON** table. This table represents the condition that each fake patient has. Other than primary and foreign keys, we also included the Condition name and HIV status in this table to have a more detailed description for each condition. The Condition ID was created by referencing the ICD 10 code for 10 different HIV variants. They range from B20 to B23, including some floating numbers.

For the **Visit_occurrence** table, we set the Visit ID (VID) as the primary key and the Patient ID (PID) as the foreign key to link with the **PERSON** and **Condition_occurrence** tables. In this table, we included some important information related to the HIV test. The Test type was set as "HIV/AIDs test" for all fake patients. The Site ID was extracted from the real dataset "**HIV Testing Locations**". The Test date and the Test result was made based on the fake patients' information.

In the study, we also included 2 subtables that can be used as references. We first made a **ZIPcode** table that contains all the zip codes in the **PERSON** table. Then, based on the district separation in the "NYC Condom Availability Program" public dataset, we filled in the Borough for each zip code and set the City as "NYC" for all the records. The ZIPcode was set as the primary key for this table, and the Borough as the foreign key. In addition, we created a **Test_site** table that contains demographic information for each Site ID that appear in the **Visit_occurrence** table, like Website and Phone numbers. Those information were directly extracted from the real dataset "**Test Locations**". The primary key of this table was set as the Side_ID, and the foreign key was set as the ZIPcode.


### Creating Sample Patient Table

To better represents the information inside the OMOP tables, we also created a sample patient table by joining the OMOP tables using their primary and foreign keys and selecting the columns of interests. The SQL Query code used for this purpose are listed below.

```SQL=
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

The resulting table includes some demographic information of each fake patient and also the Condition ID and name from Condition_occurrence table. The HIV status and the test date, type, and result were also included, along with the test Site ID.

|PID |MRN |Age |Gender |Race |Address |ZIPcode |Borough |CID |Condition_name |HIV_status |Test_type |Test_date |Site_ID |Test_result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1001 | 57011 | 25 | Male | White | 2425 Grand Avenue | 10468 | Bronx | B20 | HIV | Positive | HIV/AID Test | 2015-04-06 00:00:00.000 | 810 | Positive |
|1002|	57012|	37|	Female|	Asian	|601 E 20th St|	10010|	Manhattan	|B20.1|	HIV	|Positive|	HIV/AID Test	|2015-07-25 00:00:00.000|	53|	Positive|
|1003|	57013|	23|	Female|	Black	|2830 Jackson Ave	|11101|	Queens|	B20.2|	HIV	|Negative|	HIV/AID Test|	2014-03-11 00:00:00.000|	90|	Negative|
|1004|	57014|	19|	Male|	Black|	310 W 55th St|	10019	|Manhattan|	B21|	HIV	|Positive|	HIV/AID Test|	2014-09-20 00:00:00.000	|167|	Positive|
|1005	|57015|	22|	Female|	White|	179 E 93rd St	|10128|	Manhattan	|B21.1|	HIV|	Negative|	HIV/AID Test|	2015-02-27 00:00:00.000	|822|	Negative|
|1006	|57016|	31|	Male|	Hispanic|	2642 Broadway	|10025|	Manhattan|	B22|HIV	|Negative|	HIV/AID Test|	2015-06-06 00:00:00.000	|524|	Negative|
|1007	|57017|	52|	Female|	Asian|	327 E 116th St|	10029|	Manhattan|	B23|	HIV	|Positive|	HIV/AID Test|	2015-08-23 00:00:00.000|	119	|Positive|
|1008	|57018|	44|	Male|	Black|	456 Main St	|10044|	Roosevelt Island|	B24|	HIV|	Negative|	HIV/AID Test|	2015-05-14 00:00:00.000|	605|	Negative|
|1009	|57019|	28|	Male|	White|	171 Wyckoff St|	11217|	Brooklyn|	B22.1|	HIV|	Negative|	HIV/AID Test|	2015-05-01 00:00:00.000|	442	|Negative|
|1010	|57020|	33|	Female|	Hispanic|	443 Greene Ave|	11216|	Brooklyn|	B23.2|	HIV	|Positive|	HIV/AID Test	|2015-04-06 00:00:00.000|	542|Positive|

<center>[Table 1. Sample Patient Information]</center>

### ETL Process of the Public Data Source

1. The 3 public datasets (real data) were downloaded from the NYC Open Data into our local directory in the csv format. The "NYC Condom Availability" dataset was created in 2018, and was updated annually until today. The "DOHMH HIV/AIDS Annual Report" dataset was created in 2016, and the most recent update was in 2018. The "HIV Testing Locations" dataset was first created in 2016, and the most recent update was in 2021.

2. The public datasets (real data) were then imported into the local Microsoft SQL Server using the SQL Server Import and Export Wizard. During the importing process, we manually excluded some columns since they are not relavant to our study.

3. With both real and fake datasets in the local MS SQL Server, we then linked them together using their primary or foreign keys, for example, ZIPcode, Borough, and Site ID.

4. Based on the information contained in both real and fake data, the temporary tables were created. Those temp tables include: ZIPcode vs. Condom Availability, Borough vs. Condom Availability, Borough vs. Average HIV Diagnosis Rate, Borough vs. Condom Availability vs. Avg HIV Diag Rate (Note: the Condom Availability was calculated as the number of condom distribution centers with free male condoms).

### Creating Table_1

To clean the datasets and better prepare for the downstream analysis process, the research team decided to create a Table_1 that include all the information needed to conduct the data analysis and generate the target result. In the SQL Query, the research team selected the columns of interests from different tables and temp tables into a new table called Table_1. The left join was used for all the joining processes since the team wanted to keep every unique record from the PERSON table into the Table_1. The tables and temp tables we used include: PERSON, ZIP_vs_Condom, Condition_occurrence, ZIPcode, Borough_vs_Avg_diagrate, Condom_by_Borough. The Table_1 was then ordered by the Patient ID (PID). The SQL Query and the resulting Table_1 are listed below.

```SQL=
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

|PID|	MRN	|Gender	|Race|	Age	|Address|	Borough	|ZIPcode|	HIV_status|	#_AvaiCond_inZip|	#_AvaiCond_inBorough|	Avg_HIV_DiagRate_by_Borough|
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|1001|	57011	|Male	|White	|25|2425 Grand Avenue	|Bronx|	10468	|Positive|	7|	125|	46.4560999550819
|1002	|57012|	Female|	Asian|	37|	601 E 20th St|	Manhattan	|10010	|Positive	|2	|244	|53.9006544549248|
|1003	|57013|	Female|	Black	|23	|2830 Jackson Ave|	Queens	|11101|	Negative|	3	|107|	21.1922908728339
|1004	|57014|	Male|	Black|	19|	310 W 55th St|	Manhattan	|10019|	Positive|	5	|244	|53.9006544549248|
|1005	|57015|	Female|	White	|22|	179 E 93rd St	|Manhattan|	10128	|Negative|	NULL	|244|	53.9006544549248|
|1006	|57016|	Male|	Hispanic|	31|	2642 Broadway|	Manhattan	|10025|	Negative|	8	|244|	53.9006544549248
|1007	|57017|	Female|	Asian|	52|	327 E 116th St|	Manhattan|	10029	|Positive	|9	|244|	53.9006544549248|
|1008|	57018	|Male	|Black|	44|	456 Main St|Manhattan|	10044	|Negative|	NULL|	NULL|	NULL|
|1009	|57019|	Male|	White|	28|	171 Wyckoff St|	Brooklyn|	11217	|Negative	|11	|216	|35.827733327349|
|1010	|57020|	Female|	Hispanic	|33	|443 Greene Ave|	Brooklyn|	11216	|Positive|	18|	216|	35.827733327349|

<center>[Table 2. Table_1]</center>

> Note: Some NULL values are due to lack of data in the public datasets. The patient with PID 1008 does not have some corresponding values since the public dataset does not include zip code `10044`, even though we've already updated the Borough from "Roosevelt Island" to "Manhattan".


### Analysis on Fake Data


### Analysis on Real Data


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


## **Result**


## **Discussion**
### Limitation
### Improvement


## **Conclusion**


## **Reference**
