create database emp;
use emp;

CREATE TABLE Dept (
    DeptNo INT PRIMARY KEY,
    DName VARCHAR(100),
    DLoc VARCHAR(100)
);

CREATE TABLE Employee (
    EmpNo INT PRIMARY KEY,
    EName VARCHAR(100),
    MgrNo INT,
    HireDate DATE,
    Sal DECIMAL(10, 2),
    DeptNo INT,
    FOREIGN KEY (DeptNo) REFERENCES Dept(DeptNo)
);

CREATE TABLE Project (
    PNo INT PRIMARY KEY,
    PLoc VARCHAR(100),
    PName VARCHAR(100)
);

CREATE TABLE Incentives (
    EmpNo INT,
    IncentiveDate DATE,
    IncentiveAmount DECIMAL(10, 2),
    PRIMARY KEY (EmpNo, IncentiveDate),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo)
);

CREATE TABLE AssignedTo (
    EmpNo INT,
    PNo INT,
    JobRole VARCHAR(100),
    PRIMARY KEY (EmpNo, PNo),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo),
    FOREIGN KEY (PNo) REFERENCES Project(PNo)
);

INSERT INTO Dept (DeptNo, DName, DLoc) VALUES
(1, 'HR', 'Bengaluru'),
(2, 'IT', 'Hyderabad'),
(3, 'Finance', 'Mysuru'),
(4, 'Marketing', 'Bengaluru'),
(5, 'Sales', 'Mysuru');

INSERT INTO Employee (EmpNo, EName, MgrNo, HireDate, Sal, DeptNo) VALUES
(101, 'Ram', 100, '2022-01-15', 50000, 1),
(102, 'Kumar', 101, '2023-03-22', 60000, 2),
(103, 'Mahesh', 101, '2021-11-05', 55000, 3),
(104, 'Suresh', 100, '2022-08-10', 65000, 4),
(105, 'Ramesh', 102, '2020-02-25', 70000, 5);

INSERT INTO Project (PNo, PLoc, PName) VALUES
(10, 'Bengaluru', 'Website Development'),
(11, 'Hyderabad', 'Data Analysis'),
(12, 'Mysuru', 'Database Migration'),
(13, 'Bengaluru', 'Marketing Campaign'),
(14, 'Hyderabad', 'System Integration');

INSERT INTO Incentives (EmpNo, IncentiveDate, IncentiveAmount) VALUES
(101, '2023-01-10', 2000),
(102, '2023-03-15', 2500),
(104, '2023-04-25', 3000),
(105, '2023-06-12', 1500);

INSERT INTO AssignedTo (EmpNo, PNo, JobRole) VALUES
(101, 10, 'Developer'),
(102, 11, 'Data Scientist'),
(103, 12, 'Analyst'),
(104, 13, 'Manager'),
(105, 14, 'Lead Engineer');

SELECT DISTINCT E.EmpNo
FROM Employee E
JOIN AssignedTo A ON E.EmpNo = A.EmpNo
JOIN Project P ON A.PNo = P.PNo
WHERE P.PLoc IN ('Bengaluru', 'Hyderabad', 'Mysuru');

SELECT E.EmpNo
FROM Employee E
LEFT JOIN Incentives I ON E.EmpNo = I.EmpNo
WHERE I.EmpNo IS NULL;

SELECT E.EName, E.EmpNo, E.DeptNo, A.JobRole, D.DLoc AS DeptLoc, P.PLoc AS ProjectLoc
FROM Employee E
JOIN Dept D ON E.DeptNo = D.DeptNo
JOIN AssignedTo A ON E.EmpNo = A.EmpNo
JOIN Project P ON A.PNo = P.PNo
WHERE D.DLoc = P.PLoc;

-- week 6 queries -->

SELECT m.ename, count(*)
FROM Employee e,Employee m
WHERE e.MgrNo = m.EmpNo
GROUP BY m.EName
HAVING count(*) =(SELECT MAX(mycount)
from (SELECT COUNT(*) mycount
FROM Employee
GROUP BY MgrNo) a);

SELECT *
FROM Employee m
WHERE m.EmpNo IN
(SELECT MgrNo
FROM Employee)
AND m.sal >
(SELECT avg(e.sal)
FROM Employee e
WHERE e.MgrNo = m.EmpNo );

select *
from Employee e,incentives i
where e.EmpNo=i.EmpNo and 2 = ( select count(*)
from incentives j
where i.IncentiveAmount <= j.IncentiveAmount )
and i.IncentiveDate like '2019-01-__';

SELECT *
FROM Employee E
WHERE E.DeptNo = (SELECT E1.DeptNo
FROM Employee E1
WHERE E1.EmpNo=E.MgrNo);

select distinct m.MgrNo from employee e, Employee m
where e.MgrNo = m.MgrNo and e.DeptNo=m.DeptNo and e.EmpNo in (
select distinct m.MgrNo from Employee e, Employee m
where e.MgrNo = m.MgrNo and e.DeptNo = m.DeptNo);