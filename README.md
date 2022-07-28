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

The fake database was created in the Microsoft SQL Server 2018 following the OMOP common data model framework. To have more information diversity in our study, we decided to use 5 different tables to built this relational database: **PERSON**, **Condition_occurrence**, **Visit_occurrence**, **ZIPcode**, and **Test_site**.

![image](https://user-images.githubusercontent.com/70513470/181394484-676f83d0-2622-407e-be1b-01c9ff818baf.png)

In the PERSON table,

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
