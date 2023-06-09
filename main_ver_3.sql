
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

GO

-- DOWN
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_appointments_appointment_job_id')
alter table appointments drop constraint fk_appointments_appointment_job_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_appointments_appointment_tutor_id')
alter table appointments drop constraint fk_appointments_appointment_tutor_id
DROP TABLE IF EXISTS tutors
DROP TABLE IF EXISTS appointments
GO
-- UP Metadata
create table Tutors (
tutor_id int identity not null,
firstname char(50) not null,
lastname char(50) not null,
tutor_email varchar(50) not null,
skills_description varchar(50) not null,
constraint pk_tutors primary key (tutor_id),
constraint u_tutors unique (tutor_email),
)
GO
create table Appointments (
appointment_id int identity not null,
appointment_job_id int not null,
appointment_tutor_id int not null,
pay_rate money not null,
app_date date not null,
constraint pk_appointments primary key (appointment_id),
constraint fk_appointments_appointment_job_id foreign key (appointment_job_id) references jobs(job_id),
constraint fk_appointments_appointment_tutor_id foreign key (appointment_tutor_id) references tutors(tutor_id)
)
GO
-- UP Data
Insert into Tutors
	(firstname, lastname, tutor_email, skills_description) values
	('John', 'Renner', 'jrenner24@gmail.com', 'research paper writing'),
	('Sarah', 'Dunst', 'sd0408@gmail.com', 'history'),
	('Darren', 'Sandusky', 'darrensan@aol.com', 'music history'),
	('Oliver', 'Queen', 'oliqueen@yahoo.com', 'art history'),
	('Jessica', 'Bernard', 'jb2707@aol.com', 'r language'),
	('Claire', 'Johnson', 'cjohnson1@outlook.com', 'spanish'),
	('Ben', 'Rivers', 'benriv@gmail.com', 'history'),
	('Jaren', 'Jack', 'jjack99@yahoo.com', 'general biology'),
	('Sonia', 'Kabelo', 'soniakab@aol.com', 'creative writing'),
	('Nisha', 'Vimal', 'nvimal@outlook.com', 'statistics'),
	('Chris', 'Mora', 'chrism34@outlook.com', 'business law'),
	('Lindsay', 'Lamb', 'llcool20@aol.com', 'economics'),
	('Kelly', 'Bradford', 'kb2408@gmail.com', 'calculus'),
	('Ramiro', 'Mack', 'rmack@gmail.com', 'organic chemistry'),
	('Henrietta', 'Roach', 'henrir1414@yahoo.com', 'SQL language'),
	('Vince', 'Ken', 'vken@hotmail.com', 'music history'),
	('Hunter', 'Saunders', 'hsaunders@aol.com', 'calculus'),
	('Kristie', 'Graham', 'kg215@hotmail.com', 'film'),
	('Bernice', 'Phillips', 'bephil@gmail.com', 'database management'),
	('Heath', 'Reeves', 'hreev87@outlook.com', 'english literature')
GO
Insert into Appointments
	(appointment_job_id, appointment_tutor_id, pay_rate, app_date) values
	('3', '17', '20', '2023-05-10'),
	('7', '15', '25', '2023-05-01'),
	('13', '10', '15', '2023-06-01'),
	('12', '8', '30', '2023-05-20'),
	('1', '20', '20', '2023-06-05'),
	('6', '9', '18', '2023-05-24'),
	('11', '12', '15', '2023-06-10'),
	('16', '1', '25', '2023-05-21'),
	('10', '10', '20', '2023-05-28'),
	('2', '2', '18', '2023-05-31'),
    ('15', '14', '10', '2023-06-15'),
	('4', '7', '30', '2023-05-20')
GO
-- Verify
Select * from tutors
GO
Select * from appointments
GO