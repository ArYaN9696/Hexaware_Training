/*Create a trigger to updates the Stock (quantity) table whenever new order placed in orders tables*/

CREATE TRIGGER tupdatestock
ON sales.orders
AFTER INSERT
AS
BEGIN
    UPDATE production.stocks
    SET quantity = s.quantity - oi.quantity
    FROM production.stocks s
    INNER JOIN sales.order_items oi 
	ON s.product_id = oi.product_id
    INNER JOIN inserted i 
	ON oi.order_id = i.order_id
    WHERE s.store_id = i.store_id;
END
GO

/*Create a trigger to that prevents deletion of a customer if they have existing orders.*/
CREATE TRIGGER tdeletion
ON sales.customers
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM sales.orders o
        INNER JOIN deleted d ON o.customer_id = d.customer_id
    )
    BEGIN
        RAISERROR ('Cannot delete customer. Customer has existing orders.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM sales.customers
        WHERE customer_id IN (SELECT customer_id FROM deleted);
    END
END;
GO


/*Create Employee,Employee_Audit  insert some test data
	b) Create a Trigger that logs changes to the Employee Table into an Employee_Audit Table*/

CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1, 1) PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1),
    DOB DATE,
    DeptId INT,
    Salary DECIMAL(10, 2)
)

CREATE TABLE Employee_Audit (
    AuditID INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeID INT,
    Name VARCHAR(100),
    Gender CHAR(1),
    DOB DATE,
    DeptId INT,
    Salary DECIMAL(10, 2),
    AuditAction VARCHAR(10),  
    AuditDate DATETIME DEFAULT GETDATE()  
)

INSERT INTO Employee (Name, Gender, DOB, DeptId, Salary)
VALUES 
('Aryan Rastogi', 'M', '1990-04-15', 1, 50000),
('Riya Sharma', 'F', '1985-12-10', 2, 60000),
('Suresh Patel', 'M', '1992-09-20', 3, 45000),
('Priya Singh', 'F', '1994-05-25', 4, 55000)

CREATE TRIGGER tEmployeeAudit
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO Employee_Audit (EmployeeID, Name, Gender, DOB, DeptId, Salary, AuditAction)
        SELECT EmployeeID, Name, Gender, DOB, DeptId, Salary, 'INSERT'
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Employee_Audit (EmployeeID, Name, Gender, DOB, DeptId, Salary, AuditAction)
        SELECT EmployeeID, Name, Gender, DOB, DeptId, Salary, 'UPDATE'
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO Employee_Audit (EmployeeID, Name, Gender, DOB, DeptId, Salary, AuditAction)
        SELECT EmployeeID, Name, Gender, DOB, DeptId, Salary, 'DELETE'
        FROM deleted;
    END
END

INSERT INTO Employee (Name, Gender, DOB, DeptId, Salary)
VALUES ('Rohit Verma', 'M', '1988-06-15', 5, 70000)

UPDATE Employee
SET Salary = 60000
WHERE EmployeeID = 1

DELETE FROM Employee
WHERE EmployeeID = 3


/*create Room Table with below columns
RoomID,RoomType,Availability
create Bookins Table with below columns
BookingID,RoomID,CustomerName,CheckInDate,CheckInDate
 
Insert some test data with both  the tables
Ensure both the tables are having Entity relationship
Write a transaction that books a room for a customer, ensuring the room is marked as unavailable.*/

-- Create the Room table
CREATE TABLE Room (
    RoomID INT IDENTITY(1, 1) PRIMARY KEY,
    RoomType VARCHAR(50) ,
    Availability int
)

CREATE TABLE Bookings (
    BookingID INT IDENTITY(1, 1) PRIMARY KEY,
    RoomID INT NOT NULL,
    CustomerName VARCHAR(100) ,
    CheckInDate DATE ,
    CheckOutDate DATE ,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)  
)

INSERT INTO Room (RoomType, Availability)
VALUES
('Deluxe', 1),   
('Standard', 1), 
('Suite', 0)

INSERT INTO Bookings (RoomID, CustomerName, CheckInDate, CheckOutDate)
VALUES 
(1, 'Aryan Rastogi', '2024-10-22', '2024-10-25'),
(2, 'mohit sharma', '2024-10-23', '2024-10-26')


BEGIN TRANSACTION

IF EXISTS (SELECT 1 FROM Room WHERE RoomID = 3 AND Availability = 1)
BEGIN
    INSERT INTO Bookings (RoomID, CustomerName, CheckInDate, CheckOutDate)
    VALUES (3, 'Suresh Patel', '2024-11-01', '2024-11-05');

    UPDATE Room
    SET Availability = 0
    WHERE RoomID = 3;

    COMMIT TRANSACTION;
    PRINT 'Room booked successfully and marked as unavailable.';
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Room is not available.';
END



