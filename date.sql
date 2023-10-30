create database datedb;
use datedb;
create table date (Emp_ID int  , Hire_Date date, Resignation_Date date);
insert into date  (emp_ID, hire_date, resignation_date)
value ('1','2000-01-01', '2013-10-07'),
('2','2003-12-04', '2017-08-03'),
('3', '2012-09-22', '2015-06-21'),
('4', '2015-04-13', null),
('5', '2016-06-03', null),
('6', '2017-08-08', null),
('7', '2016-11-13',null);



/*-----1) Find the date difference between the hire date and resignation_date for all the
employees. Display in no. of days, months and year(1 year 3 months 5 days).-----*/
SELECT 
    TIMESTAMPDIFF(YEAR,
        hire_date,
        resignation_date) AS year,
    TIMESTAMPDIFF(MONTH,
        hire_date,
        resignation_date) AS month,
    TIMESTAMPDIFF(DAY,
        hire_date,
        resignation_date) AS day
FROM
    date;
    
/*-----2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd,
yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)------*/

select date_format(hire_date, "%m/%d/%Y")  as hire_date,
date_format(resignation_date, "%M, %d, %Y" ) as resignation_date from date;
update date set resignation_date= '1900-12-01' "%M %d %Y"
where resignation_date is null;
 



    
    /*------3) Calcuate experience of the employee till date in Years and months(example 1 year and 3
months)------*/

select timestampdiff(year, hire_date , resignation_date) as year,
timestampdiff(month, hire_date , resignation_date) as month 
from date ;


/*------4) Display the count of days in the previous quarter-----*/

select (quarter((now() - interval 1 quarter)));



/*---5) Fetch the previous Quarter's second week's first day's date------*/
select makedate(year(now()),1) 
+ interval quarter(curdate()) -2 quarter 
+ interval 2 week 
- interval 1 day as previous_Quarter_second_week_first_day_date ;
;



/*-----6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY)-----*/

select date_format(makedate(year(now()),1) 
+ interval quarter(curdate()) -3 quarter
+ interval 15 week 
- interval 1 day, "%b %d %Y")
as financial_year_15th_week_dates;

 




