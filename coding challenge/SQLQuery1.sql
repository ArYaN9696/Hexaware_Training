create database codi_assign

CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
)

CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
)

CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
)

--adding values to table

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed')

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
 (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None')

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests')

 select*from suspect
 select* from Victim
 select*from Crime

--1. Select all open incidents.

select * from
crime
where status='Open'

--2. Find the total number of incidents.

select count(*) as totalincidents
from crime

--3. List all unique incident types.
select distinct incidenttype
from crime

--4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
select *
from crime
where incidentdate between '2023-09-01' and '2023-09-10'


--5. List persons involved in incidents in descending order of age.
 
alter table victim
add age int

alter table suspect
add age int

select c.incidentdate, v.name as victim_name, v.age as victim_age
from crime c
left join victim v on c.crimeid = v.crimeid
order by v.age desc

--6. Find the average age of persons involved in incidents.

select avg(age) as average_age
from (
    select age from victim
    union all
    select age from suspect
) as combined_ages

--7. List incident types and their counts, only for open cases.

select incidenttype,count(*) as incident_count
from crime
where status='Open'
group by incidenttype

--8. Find persons with names containing 'Doe'.
select name, age
from victim
where name like '%Doe%'

union all

select name,age
from suspect
where name like '%Doe%'

--9. Retrieve the names of persons involved in open cases and closed cases.

select v.name as person_name
from victim v
join crime c on v.crimeid = c.crimeid
where c.status in ('Open', 'Closed')

union all

select  s.name as person_name
from suspect s
join crime c on s.crimeid = c.crimeid
where c.status in ('Open', 'Closed')



--10. List incident types where there are persons aged 30 or 35 involved.

select distinct c.incidenttype
from crime c
left join victim v on c.crimeid = v.crimeid
left join suspect s on c.crimeid = s.crimeid
where v.age in (30, 35) or s.age in (30, 35)


--11. Find persons involved in incidents of the same type as 'Robbery'.

select v.name as [name] ,s.name as sus_name
from victim v
join crime c
on v.crimeid=c.crimeid
join suspect s
on c.crimeid=s.crimeid
where incidenttype='Robbery'



--12. List incident types with more than one open case.

select c.incidenttype
from crime c
where c.status = 'Open'
group by c.incidenttype
having count(*) > 1

--13. List all incidents with suspects whose names also appear as victims in other incidents.

select c.incidenttype, c.incidentdate, c.location, s.name as suspect_name,v.name as victim_name
from crime c
join suspect s on c.crimeid = s.crimeid
join victim v on s.name = v.name
where v.crimeid <> c.crimeid


--14. Retrieve all incidents along with victim and suspect details.

select c.*, v.name as victim_name,v.contactinfo as victim_contact,v.injuries as victim_injuries,
s.name as suspect_name,s.description as suspect_description,s.criminalhistory as suspect_criminalhistory
from crime c
left join victim v on c.crimeid = v.crimeid
left join suspect s on c.crimeid = s.crimeid

--15. Find incidents where the suspect is older than any victim.

select v.crimeid,s.name as suspect_name
from victim v
join suspect s
on v.crimeid=s.crimeid
where s.age > v.age

--16. Find suspects involved in multiple incidents

select s.name as suspect_name,count(s.crimeid) as incident_count
from suspect s
group by s.name
having count(s.crimeid) > 1

--17. List incidents with no suspects involved.

select c.crimeid,c.incidenttype,c.incidentdate,c.location,c.description,c.status
from crime c
left join suspect s 
on c.crimeid = s.crimeid
where s.suspectid is null


--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.

select c1.crimeid
from crime c1
where c1.incidenttype in ('homicide', 'robbery')
and not exists (
  select 1
  from crime c2
  where c2.crimeid = c1.crimeid
  and c2.incidenttype not in ('robbery', 'homicide')
)



--19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.

select c.crimeid,c.incidenttype,c.incidentdate,c.location,c.description,c.status,
isnull(s.name, 'No Suspect') as suspect_name  
from crime c
left join suspect s 
on c.crimeid = s.crimeid  

--20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault

select  s.suspectid,s.name,s.age,s.description,s.criminalhistory
from suspect s
join crime c 
on s.crimeid = c.crimeid  
where c.incidenttype in ('Robbery', 'Assault')
