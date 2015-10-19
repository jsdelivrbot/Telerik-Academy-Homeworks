-- 1. Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
--		Use a nested SELECT statement.
----------------------------
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees)            
----------------------------------------------------------------
-- 2. Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
----------------------------
SELECT FirstName, LastName, Salary
	FROM Employees
	WHERE Salary <
	(SELECT MIN(Salary) * 1.1 FROM Employees) 
----------------------------------------------------------------
--Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
--Use a nested SELECT statement.
----------------------------
SELECT FirstName, LastName, d.Name, Salary 
	FROM Employees e 
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
    WHERE Salary =
        (SELECT MIN(Salary) FROM Employees 
        WHERE DepartmentID = d.DepartmentID)
----------------------------------------------------------------
--Write a SQL query to find the average salary in the department #1.
----------------------------
SELECT AVG(Salary) AS [Average Salary]
	FROM Employees
	WHERE DepartmentID = 1
----------------------------------------------------------------
--Write a SQL query to find the average salary in the "Sales" department.
----------------------------
SELECT AVG(Salary) AS [Average Salary]
	FROM Employees e
JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
----------------------------------------------------------------
--Write a SQL query to find the number of employees in the "Sales" department.
----------------------------
SELECT Count(*) 
	FROM Employees e
JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
----------------------------------------------------------------
--Write a SQL query to find the number of all employees that have manager.
----------------------------
SELECT COUNT(ManagerID)
	FROM Employees
----------------------------------------------------------------
--Write a SQL query to find the number of all employees that have no manager.
----------------------------
SELECT COUNT(*)
	FROM Employees
	WHERE ManagerID IS NULL
----------------------------------------------------------------
--Write a SQL query to find all departments and the average salary for each of them.
----------------------------
SELECT AVG(Salary) AS [Average Salary], d.Name
	FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	GROUP BY d.Name
----------------------------------------------------------------
--Write a SQL query to find the count of all employees in each department and for each town.
----------------------------
SELECT COUNT(e.EmployeeID) AS [Employees Count], t.Name AS [Town], d.Name AS [Department]
	FROM Employees e
	JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
	GROUP BY d.Name, t.Name
----------------------------------------------------------------
--Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.
----------------------------
SELECT e.FirstName, e.LastName
	FROM Employees e
	JOIN Employees emp
		ON emp.ManagerID = e.EmployeeID
	GROUP BY e.FirstName,e.LastName
	HAVING COUNT(e.EmployeeID) = 5
----------------------------------------------------------------
--Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
----------------------------
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS [Employee Name],
	   COALESCE(emp.FirstName + ' '+ emp.LastName, 'no manager') AS [Manager Name]
	FROM Employees e
	LEFT JOIN Employees emp
		ON e.ManagerID = emp.EmployeeID
----------------------------------------------------------------
--Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) -function.
----------------------------
SELECT LastName
	FROM Employees
	WHERE LEN(LastName) = 5
----------------------------------------------------------------
--Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds".
--Search in Google to find how to format dates in SQL Server.
----------------------------
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy HH:mm:ss:fff')
----------------------------------------------------------------
--Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
--Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
--Define the primary key column as identity to facilitate inserting records.
--Define unique constraint to avoid repeating usernames.
--Define a check constraint to ensure the password is at least 5 characters long.
----------------------------
CREATE TABLE Users (
    UserId int IDENTITY PRIMARY KEY,
    Username nvarchar(50) NOT NULL CHECK (LEN(Username) > 3) UNIQUE,
    Pass nvarchar(256) NOT NULL CHECK (LEN(Pass) > 5),
    FullName nvarchar(50) NOT NULL CHECK (LEN(FullName) > 5),
    LastLoginTime DATETIME NOT NULL,
) 
GO
----------------------------------------------------------------
--Write a SQL statement to create a view that displays the users from the Users table that have been in the system today.
--Test if the view works correctly.
----------------------------
CREATE VIEW [Logged Users Today] AS 
	SELECT Username FROM Users
	WHERE DATEDIFF(DAY, LastLoginTime, GETDATE()) = 0
GO
----------------------------------------------------------------
--Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint).
--Define primary key and identity column.
----------------------------
CREATE TABLE Groups(
	GroupId int IDENTITY PRIMARY KEY,
	Name nvarchar(50) NOT NULL UNIQUE
)
GO
----------------------------------------------------------------
--Write a SQL statement to add a column GroupID to the table Users.
--Fill some data in this new column and as well in the `Groups table.
----------------------------
ALTER TABLE Users
	ADD GroupID int NOT NULL
GO

ALTER TABLE Users
	ADD CONSTRAINT FK_Users_Groups
	FOREIGN KEY (GroupId)
	REFERENCES Groups(GroupId)
GO
----------------------------------------------------------------
--Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
----------------------------

----------------------------------------------------------------
--Write SQL statements to insert several records in the Users and Groups tables.
----------------------------
INSERT INTO Groups VALUES
    ('Telerik Academy')


INSERT INTO Users VALUES
    ('Pesho', 'pass233', 'Peshov', GETDATE(), 1),
    ('Gosho', 'mass233', 'Goshov', GETDATE(), 1)

----------------------------------------------------------------
--Write SQL statements to update some of the records in the Users and Groups tables.
----------------------------
UPDATE Users
	SET Username = REPLACE(Username, 'Pesho', 'Nesho')
	WHERE UserId = 1

UPDATE Groups
	SET Name = REPLACE(Name, 'Telerik Academy', 'Telerik')
	WHERE GroupId = 1

----------------------------------------------------------------
--Write SQL statements to delete some of the records from the Users and Groups tables.
----------------------------
DELETE FROM Users
WHERE Username LIKE '%v';

DELETE FROM Groups
WHERE Name = 'Telerik'
----------------------------------------------------------------
--Write SQL statements to insert in the Users table the names of all employees from the Employees table.
--Combine the first and last names as a full name.
--For username use the first letter of the first name + the last name (in lowercase).
--Use the same for the password, and NULL for last login time.
----------------------------
INSERT INTO Users (Username, FullName, Pass)
        (SELECT LOWER(CONCAT(FirstName, '.', LastName)),
                CONCAT(FirstName, ' ', LastName),
                LOWER(CONCAT(FirstName, '.', LastName))
        FROM Employees)
GO
----------------------------------------------------------------
--Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010.
----------------------------
UPDATE Users
    SET Pass = NULL
    WHERE DATEDIFF(day, LastLoginTime, '2010-3-10 00:00:00') > 0
----------------------------------------------------------------
--Write a SQL statement that deletes all users without passwords (NULL password).
----------------------------
DELETE  
    FROM Users
    WHERE Pass IS NULL
----------------------------------------------------------------
--Write a SQL query to display the average employee salary by department and job title.
----------------------------
SELECT AVG(e.Salary) AS [Average Salary], 
        d.Name AS [Department], 
        e.JobTitle
    FROM Employees e 
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.Name, e.JobTitle

----------------------------------------------------------------
--Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
----------------------------
SELECT MIN(e.Salary),
        d.Name AS [Department],
        e.JobTitle, 
        MIN(CONCAT(e.FirstName, ' ', e.LastName)) AS [Employee]
    FROM Employees e 
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.Name, e.JobTitle
----------------------------------------------------------------
--Write a SQL query to display the town where maximal number of employees work.
----------------------------
SELECT TOP 1 t.Name AS [Town], COUNT(*) AS [Number of Employees]
FROM Employees e
	JOIN Addresses a
		ON e.AddressID = a.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY COUNT(*) DESC
----------------------------------------------------------------
--Write a SQL query to display the number of managers from each town.
----------------------------
SELECT t.Name AS [Town], COUNT(e.EmployeeID) as [ManagersCount]
    FROM Employees e 
    JOIN Addresses a
        ON e.AddressID = a.AddressID
    JOIN Towns t
        ON t.TownID = a.TownID
    GROUP BY t.Name
----------------------------------------------------------------
--Write a SQL to create table WorkHours to store work reports for each employee (employee id, date, task, hours, comments).
--Don't forget to define identity, primary key and appropriate foreign key.
--Issue few SQL statements to insert, update and delete of some data in the table.
--Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
--For each change keep the old record data, the new record data and the command (insert / update / delete).
----------------------------
CREATE TABLE WorkHours (
    WorkReportId int IDENTITY,
    EmployeeId Int NOT NULL,
    OnDate DATETIME NOT NULL,
    Task nvarchar(256) NOT NULL,
    Hours Int NOT NULL,
    Comments nvarchar(256),
    CONSTRAINT PK_Id PRIMARY KEY(WorkReportId),
    CONSTRAINT FK_Employees_WorkHours 
        FOREIGN KEY (EmployeeId)
        REFERENCES Employees(EmployeeId)
) 
GO

DECLARE @counter int;
SET @counter = 20;
WHILE @counter > 0
BEGIN
    INSERT INTO WorkHours(EmployeeId, OnDate, Task, [Hours])
    VALUES (@counter, GETDATE(), 'TASK: ' + CONVERT(varchar(10), @counter), @counter)
    SET @counter = @counter - 1
END

UPDATE WorkHours
    SET Comments = 'Time is up'
    WHERE [Hours] > 8

DELETE 
    FROM WorkHours
    WHERE EmployeeId IN (1, 3, 5, 7, 13)

CREATE TABLE WorkHoursLogs (
    WorkLogId int,
    EmployeeId Int NOT NULL,
    OnDate DATETIME NOT NULL,
    Task nvarchar(256) NOT NULL,
    Hours Int NOT NULL,
    Comments nvarchar(256),
    [Action] nvarchar(50) NOT NULL,
    CONSTRAINT FK_Employees_WorkHoursLogs
        FOREIGN KEY (EmployeeId)
        REFERENCES Employees(EmployeeId),
    CONSTRAINT [CC_WorkReportsLogs] CHECK ([Action] IN ('Insert', 'Delete', 'DeleteUpdate', 'InsertUpdate'))
) 
GO

CREATE TRIGGER tr_InsertWorkReports ON WorkHours FOR INSERT
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'Insert'
    FROM inserted
GO

CREATE TRIGGER tr_DeleteWorkReports ON WorkHours FOR DELETE
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'Delete'
    FROM deleted
GO

CREATE TRIGGER tr_UpdateWorkReports ON WorkHours FOR UPDATE
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'InsertUpdate'
    FROM inserted

INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'DeleteUpdate'
    FROM deleted
GO

DELETE 
    FROM WorkHoursLogs

INSERT INTO WorkHours(EmployeeId, OnDate, Task, [Hours])
    VALUES (25, GETDATE(), 'TASK: 25', 25)

DELETE 
    FROM WorkHours
    WHERE EmployeeId = 25

UPDATE WorkHours
    SET Comments = 'Updated'
    WHERE EmployeeId = 2
----------------------------------------------------------------
--Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother -t-ables.
--At the end rollback the transaction.
----------------------------
BEGIN TRAN

    ALTER TABLE Departments
        DROP CONSTRAINT FK_Departments_Employees
    GO

    DELETE * 
        FROM Employees e
        JOIN Departments d
            ON e.DepartmentID = d.DepartmentID
        WHERE d.Name = 'Sales'

ROLLBACK TRAN
----------------------------------------------------------------
--Start a database transaction and drop the table EmployeesProjects.
--Now how you could restore back the lost table data?
----------------------------
BEGIN TRANSACTION

    DROP TABLE EmployeesProjects

ROLLBACK TRANSACTION
----------------------------------------------------------------
--Find how to use temporary tables in SQL Server.
--Using temporary tables backup all records from EmployeesProjects and restore them back after dropping and re-creating the table.
----------------------------
CREATE TABLE #TemporaryTable (
	EmployeeId INT,
	ProjectId INT
)

INSERT INTO #TemporaryTable
SELECT EmployeeId, ProjectId
FROM EmployeesProjects

DROP TABLE EmployeesProjects

CREATE TABLE EmployeesProjects (
	EmployeeId INT,
	ProjectId INT,
	CONSTRAINT PK_EmployeesProjects PRIMARY KEY(EmployeeID, ProjectID),
	CONSTRAINT FK_EmployeesProjects_Employees FOREIGN KEY(EmployeeID) 
	REFERENCES Employees(EmployeeID),
	CONSTRAINT FK_EmployeesProjects_Projects FOREIGN KEY(ProjectID) 
	REFERENCES Projects(ProjectID)
)

INSERT INTO EmployeesProjects
SELECT EmployeeId, ProjectId
FROM #TemporaryTable
----------------------------------------------------------------