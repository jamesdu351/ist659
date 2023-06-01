
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
    ('Angela', 'Simpson', 'A_simp_son@gmail.com'),
    ('Arabella', 'Holmes', 'homles93@willms.com'),

    ('Bentley', 'Horton', 'benton_horley@gmail.com'),
    ('Ricardo', 'Reyes', 'rreyes@yahoo.com'),
    ('Christopher','Parker','cpaker34@gmail.com'),
    ('Joyce', 'Asta', 'astrojoyce@outlook.com'),
    ('Jorge', 'Parker', 'jayparker@gmail.com'),

    ('Angela', 'Smith', 'angelasmith333@gmail.com'),
    ('Axel', 'Reyes', 'axelotl@gmail.com'),
    ('Wynter', 'Foster', 'foster.wyn@foos.com'),
    ('Ian', 'Young', 'ian.old@gmail.com'),
    ('Alexa', 'Gutierrez', 'isporie@gmail.com'),

    ('Daniella', 'Walker', 'starwalker9@sky.net'),
    ('Annalise', 'Hermiston', 'Hermanna@gmail.com'),
    ('Simon', 'Ortiz', 'simonsaidso@gmail.com'),
    ('Kate','Douglas','katendoug@gmail.com'),
    ('Keith','Webster','Dictionarykeith@gmail.com')



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
    ('1', '2023-05-20', '2023-05-22', 'essay'),
    ('1','2023-06-03', '2023-06-04', 'misc'),

    ('10','2023-05-23', '2023-06-02', 'project'),
    ('5','2023-04-30', '2023-05-05', 'project'),
    ('13', '2023-05-22', '2023-05-24', 'quiz'),
    ('14','2023-06-01', '2023-06-14', 'homework'),
    ('13','2023-05-28', '2023-06-01', 'project'),

    ('17','2023-05-30', '2023-07-01', 'project'),
    ('15', '2023-05-20', '2023-05-22', 'test'),
    ('18','2023-06-01', '2023-06-01', 'homework'),
    ('7','2023-05-29', '2023-06-03', 'misc'),
    ('9','2023-05-31', '2023-06-25', 'misc'),

    ('6', '2023-05-20', '2023-05-25', 'essay')
END
GO

select * from Clients

GO

select * from Jobs
