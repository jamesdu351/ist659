use tservice
-- avg rating
select avg(rating) as 'average rating',
review_for_user as tutor 
from Reviews 
group by review_for_user
GO
-- create view
create view v_averageTutorRating as 
select avg(rating) as 'average rating',
review_for_user as tutor_id 
from Reviews 
group by review_for_user
GO
select * from v_averageTutorRating
GO
--jobs count
select count(job_id) as '# of jobs',
assign_type as 'assignmnet type'
from Jobs
group by assign_type
GO
--create view
create view v_jobsCount as 
select count(job_id) as '# of jobs',
assign_type as 'assignmnet type'
from Jobs
group by assign_type
GO
select * from v_jobsCount
GO
-- tutor and client info
select Clients.client_id,
Clients.firstname+' '+Clients.lastname as 'client name',
Clients.email as 'client email',
Tutors.tutor_id,
Tutors.firstname+' '+Tutors.lastname as 'tutors name',
Tutors.tutor_email as 'tutor email',
Appointments.app_date as 'appointment date'
from Appointments
join Tutors on Appointments.appointment_tutor_id = Tutors.tutor_id
join Jobs on Appointments.appointment_job_id = Jobs.job_id
join Clients on Jobs.job_client_id = Clients.client_id
GO
--create view
create view v_clientTutorAppInfo as 
select Clients.client_id,
Clients.firstname+' '+Clients.lastname as 'client name',
Clients.email as 'client email',
Tutors.tutor_id,
Tutors.firstname+' '+Tutors.lastname as 'tutors name',
Tutors.tutor_email as 'tutor email',
Appointments.app_date as 'appointment date'
from Appointments
join Tutors on Appointments.appointment_tutor_id = Tutors.tutor_id
join Jobs on Appointments.appointment_job_id = Jobs.job_id
join Clients on Jobs.job_client_id = Clients.client_id
GO
select * from v_clientTutorAppInfo
GO
