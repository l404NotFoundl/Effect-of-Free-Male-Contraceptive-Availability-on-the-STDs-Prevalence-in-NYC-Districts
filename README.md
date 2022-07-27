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


## Introduction
Outline:
* Effect of free male contraceptive availability on the prevalence of  HIV in NYC
* Fake and Real - Population
	*	Fake Data -  NYC residents who have done HIV tests
	* Real Data - NYC residents who have done HIV tests and are 13 years or older
* NYC’s public health department provides free condoms throughout NYC and its boroughs
* Planned parenthoods in the city also provide contraceptives
* Other private institutions also provide male contraceptives such as the male contraceptive project
* By providing access to contraceptives, there is a reduction in pregnancies and STD (Sexually Transmitted Diseases)
* Reduction of unwanted pregnancies and STDs in the community will reduce future healthcare costs

Formal:

Over the past 6 years, the New York Department of Health and Mental Hygiene (NYC DOHMH) had been actively monitoring the NYC Condom Availability Program and collecting the data from different sources. This program was designed to provide free male condoms and other sexually related products to the public, such as female condoms, lubricant, etc. Not only the NYC DOHMH wanted to know the effect of distributing free male contraceptives on the prevalence of Sexually Transmitted Diseases (STDs) in the city, they also wanted to use the analytic methods to further understand the advantage and drawbacks of delivering free condoms to the public and alter the related public health policies based on the analysis results.


## Methodology

### Constructing the OMOP Tables

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


## Result


## Discussion
### Limitation
### Improvement


## Conclusion


## Reference
