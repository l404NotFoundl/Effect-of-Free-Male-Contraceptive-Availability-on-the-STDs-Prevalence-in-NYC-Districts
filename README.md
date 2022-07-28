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
![image](https://user-images.githubusercontent.com/70513470/181394484-676f83d0-2622-407e-be1b-01c9ff818baf.png "ER Diagram of the OMOP Tables")
(Figure 1. ER Diagram for Fake Patients)

The fake database was created in the Microsoft SQL Server 2018 following the OMOP common data model framework. To have more information diversity in our study, we decided to use 5 different tables to built this relational database: **PERSON**, **Condition_occurrence**, **Visit_occurrence**, **ZIPcode**, and **Test_site**.

In the **PERSON** table, we set the Patient ID (PID) as the primary key, and the Medical Record Number (MRN) as the candidate key. The ZIPcode was set as the foreign key to link with other tables in the database. We also made some fake demographic information for each patient, including the Gender, Race, Age, Address, and ZIPcode. This table provided some basic information for each patient. After creating the table in the database, we made 10 fake patients and filled in some fake values for each field in the table with no missing values.

In the **Condition_occurrence** table, we set the Condition ID (CID) as the primary key and the Patient ID (PID) as the foreign key to link with the **PERSON** table. This table represents the condition that each fake patient has. Other than primary and foreign keys, we also included the Condition name and HIV status in this table to have a more detailed description for each condition. The Condition ID was created by referencing the ICD 10 code for 10 different HIV variants. They range from B20 to B23, including some floating numbers.

For the **Visit_occurrence** table, we set the Visit ID (VID) as the primary key and the Patient ID (PID) as the foreign key to link with the **PERSON** and **Condition_occurrence** tables. In this table, we included some important information related to the HIV test. The Test type was set as "HIV/AIDs test" for all fake patients. The Site ID was extracted from the real dataset "**HIV Testing Locations**". The Test date and the Test result was made based on the fake patients' information.

In the study, we also included 2 subtables that can be used as references. We first made a **ZIPcode** table that contains all the zip codes in the **PERSON** table. Then, based on the district separation in the "NYC Condom Availability Program" public dataset, we filled in the Borough for each zip code and set the City as "NYC" for all the records. The ZIPcode was set as the primary key for this table, and the Borough as the foreign key. In addition, we created a **Test_site** table that contains demographic information for each Site ID that appear in the **Visit_occurrence** table, like Website and Phone numbers. Those information were directly extracted from the real dataset "**Test Locations**". The primary key of this table was set as the Side_ID, and the foreign key was set as the ZIPcode. 


### Creating Sample Patient Table


### ETL Process of the Public Data Source

### Creating Table_1


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
