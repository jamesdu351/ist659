create database tservice
GO
Use tservice -- replace this line with whatever database you named this as, is changable

GO

--DROP
--drop procedures
drop procedure if exists p_upsert_client
GO
drop procedure if exists p_upsert_job
GO
drop procedure if exists p_upsert_tutor
GO
drop procedure if exists p_upsert_appointments
GO
drop procedure if exists p_upsert_reviews
GO
-- drop foreign key constraints
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_jobs_job_client_id')
alter table jobs drop constraint fk_jobs_job_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_appointments_appointment_job_id')
alter table appointments drop constraint fk_appointments_appointment_job_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_appointments_appointment_tutor_id')
alter table appointments drop constraint fk_appointments_appointment_tutor_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_reviews_review_for_user')
alter table Reviews drop constraint fk_reviews_review_for_user
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_reviews_review_by_user')
alter table Reviews drop constraint fk_reviews_review_by_user
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_reviews_rating')
alter table Reviews drop constraint fk_reviews_rating
GO
Drop table if exists Clients
Drop table if exists Jobs 
Drop table if exists Rating_Astype_Lookup
Drop table if exists Reviews 
DROP TABLE IF EXISTS Tutors
DROP TABLE IF EXISTS Appointments
GO
--UP Metadata
-- create tables
CREATE TABLE Clients (
    client_id INT PRIMARY KEY IDENTITY (1, 1),
    firstname VARCHAR(100) not NULL,
    lastname varchar(100) not NULL,
    email varchar(100) not NULL,
    )

    -- Resetting surrogate key
    DBCC CHECKIDENT ('Clients', RESEED, 1);
GO
CREATE TABLE Jobs (
    job_id INT PRIMARY KEY IDENTITY (1, 1),
    job_client_id INT, 
    date_posted date not NULL,
    due_date date not NULL,
    assign_type varchar(100) -- not sure if this is supposed to be yes or no thing but can change after

    constraint fk_jobs_job_client_id Foreign KEY (job_client_id) References CLIENTS(client_id)

        )

    DBCC CHECKIDENT ('Jobs', RESEED, 1);
GO
create table Tutors (
tutor_id int identity (1, 1) not null,
firstname char(50) not null,
lastname char(50) not null,
tutor_email varchar(50) not null,
skills_description varchar(50) not null,
constraint pk_tutors primary key (tutor_id),
constraint u_tutors unique (tutor_email),
)
GO
create table Appointments (
appointment_id int identity (1, 1) not null,
appointment_job_id int not null,
appointment_tutor_id int not null,
pay_rate money not null,
app_date date not null,
constraint pk_appointments primary key (appointment_id),
constraint fk_appointments_appointment_job_id foreign key (appointment_job_id) references jobs(job_id),
constraint fk_appointments_appointment_tutor_id foreign key (appointment_tutor_id) references Tutors(tutor_id)
)
GO
CREATE TABLE Rating_Astype_Lookup( 

    rating_astype INT PRIMARY KEY not NULL 

) 
GO
CREATE TABLE Reviews( 

    review_id INT IDENTITY (1, 1) not NULL, 

    review_for_user int not NULL, 

    review_by_user int not NULL, 

    rating int not NULL, 

    comment varchar(150) not NULL 
    constraint pk_reviews primary key (review_id),
    constraint fk_reviews_review_for_user foreign key (review_for_user) references Tutors(tutor_id),
    constraint fk_reviews_review_by_user foreign key (review_by_user) references Clients(client_id),
    constraint fk_reviews_rating foreign key (rating) references Rating_astype_lookup(rating_astype)
) 
GO

-- UP Data

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

GO
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
GO

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
  
INSERT into Rating_astype_lookup VALUES 

 ('1'),
 ('2'),
 ('3'),
 ('4'),
 ('5') 

 GO 

insert into Reviews  

(review_for_user, review_by_user, rating, comment) values   

('17', '4', '5', 'great job'), 

('15', '5', '4', 'good work'),  

('10', '18','5', 'explained homework in a well-organized way'),  

('8', '15', '5', 'test scores increased'),   

('10', '13', '1', 'was not able to help with project, tutor was not well-versed on the subject'),  

('2', '3', '3', 'tutor was very patient but still did not understand the concept') 

GO  
-- Verify
select * from Clients
GO
select * from Jobs
GO
select * from Tutors
GO
select * from Appointments
GO
select * from Reviews
GO
select * from Rating_Astype_Lookup
GO
-- create procedures
-- these stored procedures will allow users to create new client and tutor accounts, new jobs and appointments, and post new reviews 
create PROCEDURE p_upsert_client (
    @firstname varchar(100),
    @lastname varchar(100),
    @email varchar(100)) 
AS
BEGIN
    if exists(select * from "Clients" where firstname = @firstname)
        begin 
            update "Clients"
            set firstname = @firstname, lastname = @lastname, email = @email
            where firstname = @firstname
        END
    ELSE
        BEGIN
            insert into "Clients"
            (firstname, lastname, email)
            VALUES
            (@firstname, @lastname, @email)
        END
        RETURN @@IDENTITY
    END;
GO


create PROCEDURE p_upsert_job(
    @job_client_id INT, 
    @date_posted date,
    @due_date date,
    @assign_type varchar(100)
)
AS
BEGIN
    if exists(select * from "Jobs" where job_client_id = @job_client_id)
        begin 
            update "Jobs"
            set job_client_id = @job_client_id, date_posted = @date_posted, due_date = @due_date,
            assign_type = @assign_type
            where job_client_id = @job_client_id
        END
    ELSE
        BEGIN
            insert into "Jobs"
            (job_client_id, date_posted, due_date, assign_type)
            VALUES
            (@job_client_id, @date_posted, @due_date, @assign_type)
        END
        RETURN @@IDENTITY
    END;
GO


create PROCEDURE p_upsert_tutor(
    @firstname char(50), 
    @lastname char(50),
    @tutor_email varchar(50),
    @skills_description varchar(50)
)
AS
BEGIN
    if exists(select * from "Tutors" where firstname = @firstname)
        begin 
            update "Tutors"
            set firstname = @firstname, lastname = @lastname, tutor_email = @tutor_email, skills_description = @skills_description
            where firstname = @firstname
        END
    ELSE
        BEGIN
            insert into "Tutors"
            (firstname, lastname, tutor_email, skills_description)
            VALUES
            (@firstname, @lastname, @tutor_email, @skills_description)
        END
        RETURN @@IDENTITY
    END;
GO


create PROCEDURE p_upsert_appointments(
    @appointment_job_id int,
    @appointment_tutor_id int,
    @pay_rate money,
    @app_date date
)
AS
BEGIN
    if exists(select * from "Appointments" where appointment_job_id = @appointment_job_id)
        begin 
            update "Appointments"
            set appointment_job_id = @appointment_job_id, appointment_tutor_id = @appointment_tutor_id, pay_rate = @pay_rate, app_date = @app_date
            where appointment_job_id = @appointment_job_id
        END
    ELSE
        BEGIN
            insert into "Appointments"
            (appointment_job_id, appointment_tutor_id, pay_rate, app_date)
            VALUES
            (@appointment_job_id, @appointment_tutor_id, @pay_rate, @app_date)
        END
        RETURN @@IDENTITY
    END;
GO


create PROCEDURE p_upsert_reviews(
    @review_for_user int, 
    @review_by_user int, 
    @rating int, 
    @comment varchar(150)
)
AS
BEGIN
    if exists(select * from "Reviews" where review_for_user = @review_for_user)
        begin 
            update "Reviews"
            set review_for_user = @review_for_user, review_by_user = @review_by_user, rating = @rating, comment = @comment
            where review_for_user = @review_for_user
        END
    ELSE
        BEGIN
            insert into "Reviews"
            (review_for_user, review_by_user, rating, comment)
            VALUES
            (@review_for_user, @review_by_user, @rating, @comment)
        END
        RETURN @@IDENTITY
    END;
GO
