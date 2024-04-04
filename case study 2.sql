create database casestudy
use casestudy

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);



INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30);

select * from LOCATION
select * from DEPARTMENT
select * from JOB
select * from EMPLOYEE
select * from salary_grade

create table salary_grade (grade int  primary key,
lower_bound float, 
upper_bound float );

INSERT INTO salary_grade VALUES
(1, 4000.00, 5000.00 ),
(2 , 3999.00, 3000.00 ),
(3, 2999.00, 2000.00 ),
(4, 1999.00, 1000.00),
(5 , 999.00, 300.00);

select * from salary_grade


--Simple Queries:
--1. List all the employee details. 
select * from EMPLOYEE

--2. List all the department details. 
select * from DEPARTMENT

--3. List all job details.
select * from JOB

-- 4. List all the locations.
select * from LOCATION

--5. List out the First Name, Last Name, Salary, Commission for allEmployees. 
select first_name, last_name, salary, comm from EMPLOYEE;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", Department ID as "Dep_id".
select EMPLOYEE_ID as 'ID of the employee', last_name as 'name of the employee', department_id as 'dep_id' from EMPLOYEE

--7. List out the annual salary of the employees with their names only.
select first_name, last_name, salary*12 as 'annual salary' from EMPLOYEE


--WHERE Condition:
--1. List the details about "Smith".
select * from EMPLOYEE where LAST_NAME = 'smith'

--2. List out the employees who are working in department 20.
select * from EMPLOYEE where DEPARTMENT_ID = 20;

--3. List out the employees who are earning salaries between 3000 and 4500.
select *from EMPLOYEE where SALARY between 3000 and 4500

--4. List out the employees who are working in department 10 or 20.
select * from EMPLOYEE where DEPARTMENT_ID= 10 or  DEPARTMENT_ID=20;
select * from EMPLOYEE where DEPARTMENT_ID in (10,20);

--5. Find out the employees who are not working in department 10 or 30.
select * from EMPLOYEE where not DEPARTMENT_ID in (10,30) 

--6. List out the employees whose name starts with 'S'
select * from EMPLOYEE where FIRST_NAME like 's%' or LAST_NAME like 's%'

--7. List out the employees whose name starts with 'S' and ends with'H
select * from EMPLOYEE where FIRST_NAME like 's%h';
select * from EMPLOYEE where LAST_NAME like 's%h';

--8. List out the employees whose name length is 4 and start with 'S'. 
select * from EMPLOYEE where len(FIRST_NAME) = 4 and LAST_NAME like 's%' ;

--9. List out employees who are working in department 10 and draw salaries more than 3500. 
select * from EMPLOYEE where DEPARTMENT_ID = 10 and SALARY >3500;

--10. List out the employees who are not receiving commission.
select * from EMPLOYEE where COMM is null ;


--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select employee_id , last_name from EMPLOYEE order by EMPLOYEE_ID asc;

--2. List out the Employee ID and Name in descending order based onsalary.
select EMPLOYEE_id, first_name,last_name, SALARY from EMPLOYEE order by SALARY desc;

--3. List out the employee details according to their Last Name in ascending-order
select * from EMPLOYEE order by LAST_NAME asc;

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select * from EMPLOYEE order by LAST_NAME ;
select * from EMPLOYEE order by DEPARTMENT_ID desc; 


--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in the organization?
select DEPARTMENT.Department_Id , count(EMPLOYEE_ID) as [count_employee ]
from EMPLOYEE , DEPARTMENT group  by DEPARTMENT.Department_Id 

--2. List out the department wise maximum salary, minimumsalary andaverage salary of the employees.
select max( salary )as max_salary, min(salary ) as min_salary, AVG (salary) as avg_salary from EMPLOYEE;

--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees.
select job_id, max( salary )as max_salary, min(salary ) as min_salary, AVG (salary) as avg_salary from EMPLOYEE
group by JOB_ID;

--4. List out the number of employees who joined each month in ascendingorder.
select count(employee_id) [emp id], month (hire_date ) as 'month of joining'
from employee group by month (hire_date);

--5. List out the number of employees for each month and year in ascending order based on the year and month.
select  count(employee_id) [emp id], month (hire_date ) as 'month of joining', year (HIRE_DATE) as 'year of joining '
from employee group by month (hire_date) , year (HIRE_DATE) ;

--6. List out the Department ID having at least four employees.
 select department_id from employee
 group by department_id having count(*) >=4

--7. How many employees joined in the month of January?
select DATENAME(mm,hire_date)  month, count(*) 'number of employees' from EMPLOYEE
where DATENAME (mm,hire_date) ='january' group by datename (mm,hire_date);

--8. How many employees joined in the month of January orSeptember?
select DATENAME(mm,hire_date)  month, count(*) 'number of employees' from EMPLOYEE
where DATENAME (mm,hire_date) in ('january' , 'september') group by datename (mm,hire_date);

--9. How many employees joined in 1985?
select DATENAME(yy,hire_date)  month, count(*) 'number of employees' from EMPLOYEE
where DATENAME (yy,hire_date) = 1985 group by datename (yy,hire_date);

--10. How many employees joined each month in 1985?
select DATENAME(yy,hire_date)year,
datename(mm, hire_date)month, count(*) 'number of employees' from EMPLOYEE
where DATENAME (yy,hire_date) = 1985 group by datename (yy,hire_date),datename(mm, hire_date);

--11. How many employees joined in March 1985?
select DATENAME(yy,hire_date)year,
datename(mm, hire_date)month, count(*) 'number of employees' from EMPLOYEE
where DATENAME (yy,hire_date) = 1985 and datename(mm, HIRE_DATE) ='march' group by datename (yy,hire_date),datename(mm, hire_date);

--12. Which is the Department ID having greater than or equal to 3 employeesjoining in April 1985?
select DEPARTMENT_ID, count(*) 'number of employee' from EMPLOYEE 
where datename (yy,HIRE_DATE)=1985 and datename(mm, HIRE_DATE)= 'april' group by DEPARTMENT_ID having count(*)>=3;

--Joins:
--1. List out employees with their department names
select employee_id, last_name, salary, e.department_id , FIRST_NAME from employee e
inner join department d on e.DEPARTMENT_ID= d.Department_Id;

--2. Display employees with their designations. 
 SELECT EMPLOYEE_ID,LAST_NAME,SALARY,E.DEPARTMENT_ID
FROM EMPLOYEE E
INNER JOIN JOB J
ON E.JOB_ID=J.JOB_ID;

--3. Display the employees with their department names and regional groups. 
select employee_id, last_name, first_name, salary, e.department_id
from employee e 
inner join department d  on e.department_id = d.department_id 
inner join location l  on d.Location_Id = l.Location_ID;

--4. How many employees are working in different departments? Displaywithdepartment names.
 SELECT NAME AS "DEPARTMENT NAME",COUNT(*) AS "NUMBER OF EMPLOYEES"
      FROM DEPARTMENT D
      INNER JOIN EMPLOYEE E
      ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
   GROUP BY NAME;

--5. How many employees are working in the sales department?  
   SELECT NAME,COUNT(*) AS "NUMBER OF EMPLOYEES"
      FROM DEPARTMENT D
      INNER JOIN EMPLOYEE E
      ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
      GROUP BY NAME
      HAVING NAME='SALES';

----6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order. 
     SELECT NAME AS "DEPARTMENT NAME",COUNT(*) AS "NUMBER OF EMPLOYEES"
      FROM DEPARTMENT D
      INNER JOIN EMPLOYEE E
      ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
      GROUP BY NAME
   HAVING COUNT(*)>=5;

--7. How many jobs are there in the organization? Display with designations.
 SELECT COUNT(*) AS "NO OF JOBS"
      FROM JOB J
      INNER JOIN EMPLOYEE E
      ON E.JOB_ID=J.JOB_ID;

--8. How many employees are working in "New York"?
 SELECT COUNT(*) "NUMBER OF EMPLOYEES"
      FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
      WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
      AND D.LOCATION_ID=L.LOCATION_ID;
   
----9. Display the employee details with salary grades. Use conditional statement to create a grade column. 
  select e.last_name, e.salary, g.grade from EMPLOYEE e
full join salary_grade g on 
  e.salary= g.grade;
                                 --or
select *,
  case 
        when salary >1000 then 'b'
		when salary >2000 then 'a'
		else 'c'
	end as grade_salary 
	from EMPLOYEE;

--10. List out the number of employees grade wise. Use conditional statementtocreate a grade column. 
select s.grade ,count(*), max (salary)
from employee e , salary_grade s
where e.salary between s.lower_bound and s. upper_bound
group by s.grade;

--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
select * from EMPLOYEE
where salary between 2000 and 5000; 

--12. Display all employees in sales or operation departments.
select * from DEPARTMENT d full join  EMPLOYEE e 
on d.name = e.LAST_NAME
where d.name in ('operations,sales');

--SET Operators:
----1. List out the distinct jobs in sales and accounting departments.
     SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT                                        
	  WHERE NAME='SALES'))
      UNION
      SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT                                  
	  WHERE NAME='ACCOUNTING'));


--2. List out all the jobs in sales and accounting departments. 
SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT        
	  WHERE NAME='SALES'))
      UNION ALL
      SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT                    
	  WHERE NAME='ACCOUNTING'));

--3. List out the common jobs in research and accounting departments in ascending order.
  SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT                  
	  WHERE NAME='SALES'))
      INTERSECT
      SELECT *
      FROM JOB WHERE JOB_ID IN(SELECT JOB_ID FROM EMPLOYEE
      WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENT                
	  WHERE NAME='ACCOUNTING'));

----Subqueries:
----1. Display the employees list who got the maximum salary.
 SELECT * FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE);

----2. Display the employees who are working in the sales department. 
      SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENT
  WHERE NAME='SALES');

--3. Display the employees who are working as 'Clerk'.
 SELECT * FROM EMPLOYEE
 WHERE JOB_ID IN (SELECT JOB_ID FROM JOB
                  WHERE DESIGNATION='CLEARK');

--4. Display the list of employees who are living in "New York".
 SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM DEPARTMENT
            WHERE LOCATION_ID IN (SELECT LOCATION_ID FROM LOCATION
                            WHERE CITY='NEW YORK'));

--5. Find out the number of employees working in the sales department.
 SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN 
(SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE NAME='SALES');

--6. Update the salaries of employees who are working as clerks on thebasisof 10%.
 SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENT
                                    WHERE NAME='SALES');

--7. Delete the employees who are working in the accounting department. 
 SELECT * FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENT
                                    WHERE NAME='SALES');

--8. Display the second highest salary drawing employee details. 
  SELECT * FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY) FROM EMPLOYEE
                WHERE SALARY <(SELECT MAX(SALARY) FROM EMPLOYEE));

--9. Display the nth highest salary drawing employee details. 
  SELECT A.SALARY FROM EMPLOYEE A
WHERE N-1=(SELECT COUNT(DISTINCT(B.SALARY)) FROM EMPLOYEE B
             WHERE A.SALARY<B.SALARY)
2ND,3RD AND 5TH MAX SALARYS
SELECT A.SALARY FROM EMPLOYEE A
WHERE (SELECT COUNT(DISTINCT(B.SALARY)) FROM EMPLOYEE B
             WHERE A.SALARY<B.SALARY)IN(1,2,4);

--10. List out the employees who earn more than every employee in department 30.
  SELECT * FROM EMPLOYEE
WHERE SALARY>ALL(SELECT SALARY FROM EMPLOYEE
                 WHERE DEPARTMENT_ID=30);

--11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees.
 SELECT * FROM EMPLOYEE
WHERE SALARY>ANY(SELECT MIN(SALARY) FROM EMPLOYEE
                 WHERE DEPARTMENT_ID=30);

--12. Find out which department has no employees. 13. Find out the employees who earn greater than the average salary for their department.
  SELECT DEPARTMENT_ID,NAME FROM DEPARTMENT
WHERE DEPARTMENT_ID NOT IN(SELECT DEPARTMENT_ID FROM EMPLOYEE);
