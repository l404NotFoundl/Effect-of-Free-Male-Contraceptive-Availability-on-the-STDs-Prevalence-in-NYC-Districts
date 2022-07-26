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