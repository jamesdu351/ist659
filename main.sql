
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'tutormatch')
    BEGIN
    Create DATABASE tutormatch
    
    END
GO

Use tutormatch -- replace this line with whatever database you named this as, is changable

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Clients' and xtype='U')
BEGIN
    CREATE TABLE Clients (
        client_id INT PRIMARY KEY IDENTITY (1, 1),
        firstname VARCHAR(100),
        lastname varchar(100),
        email varchar(100)
    )
END

GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Jobs' and xtype='U')
BEGIN
    CREATE TABLE Jobs (
        job_id INT PRIMARY KEY IDENTITY (1, 1),
        date_posted date,
        due_date date,
        assign_type varchar(100) -- not sure if this is supposed to be yes or no thing but can change after

            )
END

    
