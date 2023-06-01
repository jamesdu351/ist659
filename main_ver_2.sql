
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
        firstname VARCHAR(100) not NULL,
        lastname varchar(100) not NULL,
        email varchar(100) not NULL,
    )

    -- Resetting surrogate key

    DBCC CHECKIDENT ('Clients', RESEED, 1);

    -- Data Initialization that resets

    Insert into Clients (firstname, lastname, email)
    VALUES
    ('Stephen', 'King', 'skiing@gmail.com'),
    ('Andy', 'Harris', 'aharri@outlook.com'),
    ('Brynlee', 'Torres', 'Bryntorres123@gmail.com'),
    ('Angela', 'Simpson', 'A_simp_son@syr.edu')


END


GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Jobs' and xtype='U')
BEGIN
    CREATE TABLE Jobs (
        job_id INT PRIMARY KEY IDENTITY (1, 1),
        job_client_id INT Foreign KEY References CLIENTS(client_id), 
        date_posted date not NULL,
        due_date date not NULL,
        assign_type varchar(100) -- not sure if this is supposed to be yes or no thing but can change after

            )

    DBCC CHECKIDENT ('Jobs', RESEED, 1);

    Insert into Jobs (job_client_id, date_posted, due_date, assign_type)
    VALUES
    ('1','2023-06-01', '2023-06-15', 'homework'),
    ('3','2023-05-29', '2023-06-05', 'project'),
    ('4','2023-04-30', '2023-07-25', 'test'),
    ('1', '2023-05-20', '2023-05-22', 'essay')
END
GO

select * from Clients

GO

select * from Jobs