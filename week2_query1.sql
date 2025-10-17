CREATE DATABASE dhiksha_bank;
USE dhiksha_bank;

CREATE TABLE branch (
  Branch_name VARCHAR(30),
  Branch_city VARCHAR(25),
  assets INT,
  PRIMARY KEY (Branch_name)
);

CREATE TABLE BankAccount (
  Accno INT,
  Branch_name VARCHAR(30),
  Balance INT,
  PRIMARY KEY (Accno),
  FOREIGN KEY (Branch_name) REFERENCES branch(Branch_name)
);

CREATE TABLE BankCustomer (
  Customername VARCHAR(20),
  Customer_street VARCHAR(30),
  CustomerCity VARCHAR(35),
  PRIMARY KEY (Customername)
);

CREATE TABLE Depositer (
  Customername VARCHAR(20),
  Accno INT,
  PRIMARY KEY (Customername, Accno),
  FOREIGN KEY (Accno) REFERENCES BankAccount(Accno),
  FOREIGN KEY (Customername) REFERENCES BankCustomer(Customername)
);

CREATE TABLE Loan (
  Loan_number INT,
  Branch_name VARCHAR(30),
  Amount INT,
  PRIMARY KEY (Loan_number),
  FOREIGN KEY (Branch_name) REFERENCES branch(Branch_name)
);

INSERT INTO branch (Branch_name, Branch_city, assets) 
VALUES 
  ("SBI_Chamrajpet", "Bangalore", 50000),
  ("SBI_ResidencyRoad", "Bangalore", 10000),
  ("SBI_ShivajiRoad", "Bombay", 20000),
  ("SBI_ParlimentRoad", "Delhi", 10000),
  ("SBI_Jantarmantar", "Delhi", 20000);

INSERT INTO BankAccount (Accno, Branch_name, Balance) 
VALUES 
  (1, "SBI_Chamrajpet", 2000),
  (2, "SBI_ResidencyRoad", 5000),
  (3, "SBI_ShivajiRoad", 6000),
  (4, "SBI_ParlimentRoad", 9000),
  (5, "SBI_Jantarmantar", 8000),
  (6, "SBI_ShivajiRoad", 4000),
  (8, "SBI_ResidencyRoad", 4000),
  (9, "SBI_ParlimentRoad", 3000),
  (10, "SBI_ResidencyRoad", 5000),
  (11, "SBI_Jantarmantar", 2000);

INSERT INTO BankCustomer (Customername, Customer_street, CustomerCity) 
VALUES 
  ("Avinash", "Bull_Temple_Road", "Bangalore"),
  ("Dinesh", "Bannergatta_Road", "Bangalore"),
  ("Mohan", "NationalCollege_Road", "Bangalore"),
  ("Nikil", "Akbar_Road", "Delhi"),
  ("Ravi", "Prithviraj_Road", "Delhi");

INSERT INTO Depositer (Customername, Accno) 
VALUES 
  ("Avinash", 1),
  ("Dinesh", 2),
  ("Nikil", 4),
  ("Ravi", 5),
  ("Avinash", 8),
  ("Nikil", 9),
  ("Dinesh", 10),
  ("Nikil", 11);

INSERT INTO Loan (Loan_number, Branch_name, Amount) 
VALUES 
  (1, "SBI_Chamrajpet", 1000),
  (2, "SBI_ResidencyRoad", 2000),
  (3, "SBI_ShivajiRoad", 3000),
  (4, "SBI_ParlimentRoad", 4000),
  (5, "SBI_Jantarmantar", 5000);

select Branch_name, concat(assets/100000,'lakhs')assets_in_lakhs from branch;

