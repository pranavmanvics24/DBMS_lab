use supplier;
-- 1. Using Scheme diagram, Create tables by properly specifying the primary keys and the foreign keys.
CREATE TABLE SUPPLIERS (
    SID CHAR(5) PRIMARY KEY,
    SNAME VARCHAR(50) NOT NULL,
    CITY VARCHAR(50)
);

CREATE TABLE PARTS (
    PID CHAR(5) PRIMARY KEY,
    PNAME VARCHAR(50) NOT NULL,
    COLOR VARCHAR(10)
);

CREATE TABLE CATALOG (
    SID CHAR(5),
    PID CHAR(5),
    COST DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (SID, PID),
    FOREIGN KEY (SID) REFERENCES SUPPLIERS(SID),
    FOREIGN KEY (PID) REFERENCES PARTS(PID)
);

-- 2. Insert appropriate records in each table.
INSERT INTO SUPPLIERS (SID, SNAME, CITY) VALUES
('10001', 'Acme Widget', 'Bangalore'),
('10002', 'Atlas', 'Kolkata'),
('10003', 'Vimal', 'Mumbai'),
('10004', 'Reliance', 'Delhi');

INSERT INTO PARTS (PID, PNAME, COLOR) VALUES
('20001', 'Book', 'Red'),
('20002', 'Pen', 'Red'),
('20003', 'Pencil', 'Green'),
('20004', 'Mobile', 'Green'),
('20005', 'Charger', 'Black');

INSERT INTO CATALOG (SID, PID, COST) VALUES
('10001', '20001', 10.00),
('10001', '20002', 10.00),
('10001', '20003', 10.00),
('10001', '20004', 10.00),
('10002', '20001', 10.00),
('10002', '20002', 20.00),
('10003', '20002', 30.00),
('10003', '20003', 40.00),
('10004', '20003', 40.00);

-- 3. Find the pnames of parts for which there is some supplier.
SELECT DISTINCT
    P.PNAME
FROM
    PARTS P
INNER JOIN
    CATALOG C ON P.PID = C.PID;

-- 4. Find the snames of suppliers who supply every part.
SELECT
    S.SNAME
FROM
    SUPPLIERS S
INNER JOIN
    CATALOG C ON S.SID = C.SID
GROUP BY
    S.SID, S.SNAME
HAVING
    COUNT(C.PID) = (SELECT COUNT(PID) FROM PARTS);

-- 5. Find the snames of suppliers who supply every red part.
SELECT
    S.SNAME
FROM
    SUPPLIERS S
INNER JOIN
    CATALOG C ON S.SID = C.SID
INNER JOIN
    PARTS P ON C.PID = P.PID
WHERE
    P.COLOR = 'Red'
GROUP BY
    S.SID, S.SNAME
HAVING
    COUNT(DISTINCT P.PID) = (SELECT COUNT(PID) FROM PARTS WHERE COLOR = 'Red');

-- 6. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.
SELECT
    P.PNAME
FROM
    PARTS P
INNER JOIN
    CATALOG C ON P.PID = C.PID
INNER JOIN
    SUPPLIERS S ON C.SID = S.SID
GROUP BY
    P.PID, P.PNAME
HAVING
    COUNT(DISTINCT C.SID) = 1
    AND MAX(CASE WHEN S.SNAME = 'Acme Widget' THEN 1 ELSE 0 END) = 1;

-- 7. Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part).
SELECT DISTINCT
    C.SID
FROM
    CATALOG C
INNER JOIN
    (
        SELECT
            PID,
            AVG(COST) AS AVG_COST
        FROM
            CATALOG
        GROUP BY
            PID
    ) AS AvgCost ON C.PID = AvgCost.PID
WHERE
    C.COST > AvgCost.AVG_COST;

-- 8. For each part, find the sname of the supplier who charges the most for that part.
SELECT
    P.PNAME,
    S.SNAME
FROM
    PARTS P
INNER JOIN
    CATALOG C ON P.PID = C.PID
INNER JOIN
    SUPPLIERS S ON C.SID = S.SID
INNER JOIN
    (
        SELECT
            PID,
            MAX(COST) AS MAX_COST
        FROM
            CATALOG
        GROUP BY
            PID
    ) AS MaxCost ON C.PID = MaxCost.PID AND C.COST = MaxCost.MAX_COST;