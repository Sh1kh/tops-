use hrdb;

SELECT * FROM hrdb.emp_details_view;



-- 1. Display all information in the tables EMP and DEPT.
select * from employees join departments on employees.employee_id = departments.department_id;

-- 2. Display only the hire date and employee name for each employee.
select concat(first_name,"  ", last_name)as employees_name, hire_date from employees;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and
-- name the column Employee and Title
select concat(first_name,"  ", last_name)as ename, job_id as title from employees;

-- 4. Display the hire date, name and department number for all clerks.
select concat(first_name,"  ", last_name)as name, hire_date, department_id
 from employees where job_id like "%clerk";
 
 
-- 5. Create a query to display all the data from the EMP table. Separate each column by a
-- comma. Name the column THE OUTPUT
select CONCAT_WS(employee_id,' , ', first_name,' , ', last_name, ' , ',
email, ' , ', phone_number, ' , ', hire_date, ' , ', job_id, ' , ',salary, ' , ', commission_pct, ' , ',
manager_id, ' , ', department_id)as THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
select concat(first_name,"  ", last_name)as name, 
(salary*commission_pct)+salary as salary from employees 
where (salary*commission_pct)+salary >2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start
-- Date"
select concat(first_name,"  ", last_name)as Name, hire_date as Start_Date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired. 
select concat(first_name,"  ", last_name)as name, hire_date from employees 
order by hire_date asc;

-- 9. Display the names and salaries of all employees in reverse salary order.
select concat(first_name,"  ", last_name)as name, (salary*commission_pct)+salary as salary
 from employees order by salary 
  desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in
-- reverse order.
select concat(first_name,"  ", last_name)as ename, department_id, (salary*commission_pct)+salary as salary
from employees 
where commission_pct is not null
order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager
select last_name, job_title from employees join jobs on employees.job_id = jobs.job_id
where manager_id is null
order by job_title;


-- 12. Display the last name, job, and salary for all employees whose job is sales representative
-- or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name, job_title,(salary*commission_pct)+salary as salary from employees
join jobs on employees.job_id = jobs.job_id
where job_title = "sales representative"
 or  job_title = "stock clerk"
 and salary != 2500.00 and 3500 and 5000;
 
 -- 1) Display the maximum, minimum and average salary and commission earned.
 select min(salary) as mininum, max(salary) as maximum, avg(salary) as average_salary,
 min(commission_pct ) as min_com, max(commission_pct ) as max_com, avg(commission_pct) as avg_com
 from employees;
 
-- 2) Display the department number, total salary payout and total commission payout for
-- each department.
select department_id, salary,
(salary*commission_pct)as Total_Commission_payout from employees
group by department_id;


-- 3) Display the department number and number of employees in each department.
select department_id as department_number, 
count(*)as number_of_employees from employees 
group by department_id;


-- 4) Display the department number and total salary of employees in each department.
select department_id, sum(salary) as total_salary 
from employees 
group by department_id;

-- 5) Display the employee's name who doesn't earn a commission. Order the result set
-- without using the column name
select concat(first_name,"  ", last_name) as "  " from employees
 where commission_pct is null;

-- 6) Display the employees name, department id and commission. If an Employee doesn't
-- earn the commission, then display as 'No commission'. Name the columns appropriately
select
concat(first_name,"  ", last_name)as name, department_id, commission_pct,
case when commission_pct is not null then  commission_pct
else 'no commission' 
end as commission
from employees;

-- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee
-- doesn't earn the commission, then display as 'No commission. Name the columns
-- appropriately
select
concat(first_name,"  ", last_name)as employees_name,salary,
case when commission_pct is not null then  commission_pct*2
else 'no commission' 
end as commission
from employees;

-- 8) Display the employee's name, department id who have the first name same as another
-- employee in the same department
select concat(first_name,"  ", last_name)
as employee_Name, department_id 
from employees
where  employees.first_name = first_name
group by department_id;



-- 9) Display the sum of salaries of the employees working under each Manager.
select sum(salary) as salary, manager_id from employees
where manager_id is not null
 group by manager_id;

-- 10) Select the Managers name, the count of employees working under and the department
-- ID of the manager.
select m.last_name as manager,  m.department_id, 
count(*) as  employees from employees e , employees m
where e.manager_id= m.employee_id 
group by m.department_id;

select e.last_name as employees, e.employee_id, m.last_name as manager
from employees e , employees m 
where e.manager_id = m.employee_id ;
-- 11) Select the employee name, department id, and the salary. Group the result with the
-- manager name and the employee last name should have second letter 'a! --
select concat(first_name,"  ", last_name)
as employee_Name, department_id, salary
from employees
where last_name like "_a%"
group by manager_id; 


-- 12) Display the average of sum of the salaries and group the result with the department id.
-- Order the result with the department id.
select (sum(salary)/count(*))as avg_of_sum_of_salary
from employees group by department_id 
order by department_id;



 

-- 13) Select the maximum salary of each department along with the department id
select department_name, E.department_id, max(salary) as maximum_salary
 from employees E join departments D on E.department_id = D.department_id
group by department_name;

--  14) Display the commission, if not null display 10% of salary, if null display a default value 1

select  salary,
case
when commission_pct is not null  then salary*0.1 
else  '1'
end as commission 
from employees;

-- 1. Write a query that displays the employee's last names only from the string's 2-5th
-- position with the first letter capitalized and all other letters lowercase, Give each column an
-- appropriate label.
select concat(upper(substring(last_name ,2,1)),lower(substring(last_name,3))) as 
employees_last_name
 from employees;



-- 2. Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the
-- month on which the employee has joined.
select concat(first_name," - ", last_name)
as employee_Name,hire_date from employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than
-- ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
-- 1500 each. Provide each column an appropriate label.
select  last_name,
case
when (salary/2)>10000  then (salary*1.1)+1500
else  (salary*1.15)+1500
end as New_salary
from employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end,
-- department id, salary and the manager name all in Upper case, if the Manager name
-- consists of 'z' replace it with '$!
select concat(substr(employee_id,2,2),"00", substr(employee_id,2))
  from employees;

-- 5. Write a query that displays the employee's last names with the first letter capitalized and
-- all other letters lowercase, and the length of the names, for all employees whose name
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the
-- employees' last names

select concat(upper(substring(last_name ,1,1)),lower(substring(last_name,2))) as 
employees_last_name, length(last_name) as length_of_name
 from employees
 where last_name like "A%" ||
 last_name like "J%" || 
 last_name like "M%"
 order by last_name; 

-- 6. Create a query to display the last name and salary for all employees. Format the salary to
-- be 15 characters long, left-padded with $. Label the column SALARY
select last_name, lpad(salary ,15, "$") as salary  from employees;

-- 7. Display the employee's name if it is a palindrome
select first_name,
case
when first_name = reverse(first_name) then "yes"
else 'no '
end as  it_is_palindrome 
from employees;


-- 8. Display First names of all employees with initcaps.
select concat(upper(substr(first_name,1,1)), lower(substr(first_name,2)))
as first_name from employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the
-- STREET ADDRESS column.
select substring(street_address," ")  from locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add
-- "@systechusa.com" at the end. Name the column as e-mail address. All characters should
-- be in lower case. Display this along with their First Name.
select   concat(lower(left(first_name,1)),lower(last_name),"@systechusa.com")
as email_address
 from employees;
 
-- 11. Display the names and job titles of all employees with the same job as Trenna.

select first_name ,job_title from employees e
join jobs j
on e.job_id = j.job_id
where e.job_id= (select job_id from employees where first_name="trenna");



-- 12. Display the names and department name of all employees working in the same city as
-- Trenna.

select e.first_name ,d.department_name from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where d.department_id= (select e.department_id from employees e  where first_name="trenna");



-- 13. Display the name of the employee whose salary is the lowest.
select concat(first_name,"  ", last_name)as employee_Name, min(salary) as  min_salary
from employees ;

-- 14. Display the names of all employees except the lowest paid
select concat(first_name,"  ", last_name)as employee_Name
from employees 
where salary > (select min(salary) from employees) ;


-- 1. Write a query to display the last name, department number, department name for all
-- employees.
select last_name, E.department_id, department_name 
from employees E join departments D on E.department_id = D.department_id;

-- 2. Create a unique list of all jobs that are in department 80. Include the location of the
-- department in the output.

select distinct job_id,  D.location_id 
from employees E , departments D 
where E.department_id = D.department_id
and D.department_id = 80;




-- 3. Write a query to display the employee last name,department name,location id and city of
-- all employees who earn commission.
select E.last_name, D.department_name , D.location_id, L.city from employees E,
departments D, locations L
where E.department_id = D.department_id
  and D.location_id = L.location_id
and commission_pct is not null;




-- 4. Display the employee last name and department name of all employees who have an 'a'
-- in their last name
select last_name, department_name from employees E 
join departments D on E.department_id = D.department_id
where last_name like '%a%';

-- 5. Write a query to display the last name,job,department number and department name for
-- all employees who work in Australia.
select last_name, job_id, E.department_id, department_name
 from employees E join departments D
on E.department_id = D.department_id
join locations L on D.location_id = L.Location_id
where L.Country_id ="AU";





-- 6. Display the employee last name and employee number along with their manager's last
-- name and manager number.
select e.last_name as employees, e.employee_id, m.last_name as manager, e.manager_id
from employees e , employees m 
where e.manager_id = m.employee_id ;

-- 7. Display the employee last name and employee number along with their manager's last
-- name and manager number (including the employees who have no manager).
select e.last_name as employees, e.employee_id, m.last_name as manager
from employees e , employees m 
where e.manager_id = m.employee_id ;

-- 8. Create a query that displays employees last name,department number,and all the
-- employees who work in the same department as a given employee.
select last_name,  E.department_id
 from employees E join departments D
on E.department_id = D.department_id

;

-- 9. Create a query that displays the name,job,department name,salary,grade for all
-- employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)

select concat(first_name,"  ", last_name)as employee_Name, 
job_title,department_name, salary,
case
 when salary >=50000 then "A" 
 when salary >= 30000 then "B"
 when salary <30000 then "C" 
 end as grade
from employees E 
join departments D
 on E.department_id= D.department_id 
 join jobs on E.job_id = jobs.job_id;


-- 10. Display the names and hire date for all employees who were hired before their
-- managers along withe their manager names and hire date. Label the columns as Employee
-- name, emp_hire_date,manager name,man_hire_date

select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e , employees m 
where e.manager_id = m.employee_id 
and e.hire_date < m.hire_date;


