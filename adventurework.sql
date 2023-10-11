use adventureworks;

/*--- 1. Write a query to display employee numbers and employee name (first name, last name)
of all the sales employees who received an amount of 2000 in bonus. ----*/
select E.employeeID, firstname, lastname from employee E
join contact C
on E.employeeID = C.contactID
join salesperson S 
on C.contactID = S.salespersonID
where bonus =2000;



/*----2. Fetch address details of employees belonging to the state CA. If address is null, provide
default value N/A.-------*/
select * from employee E join
employeeaddress EA on E.employeeid = EA.employeeid 
join address A on E.employeeID = A.addressID
join salesterritory S on A.addressID = S.territoryID
where countryregioncode = "CA"
group by countryregioncode;



/*----3. Write a query that displays all the products along with the Sales OrderID even if an order
has never been placed for that product------*/


select name, salesorderid from product p
join salesorderdetail s
on p.productid = s.productid;


/*-----5. A. Write a query to display employees and their manager details. Fetch employee id,
employee first name, and manager id, manager name-------*/

select employeeID, Firstname, managerId
from employee E join contact C
on E.employeeid = C.contactid
;

/*-----B. Display the employee id and employee name of employees who do not have manager.---*/
select employeeID, Firstname
from employee E join contact C
on E.employeeid = C.contactid
where managerid is null;


/*------6. A. Display the names of all products of a particular subcategory 15 and the names of their
vendors.-----*/
select P.name as ProductName, 
V.name as vendorName from product P
 join productvendor PV 
on P.productID = PV.productID 
join vendor V on PV.vendorID =V.vendorID
where productsubcategoryID = 15; 


/*----B. Find the products that have more than one vendor-----*/


select productid,count(vendorid)as no_of_vendor from productvendor
group by productid
having count(*)>1;


/*------7. Find all the customers who do not belong to any store------*/
select firstname from contact c left join storecontact s
on c.contactid = s.customerid;

/*-----8. Find sales prices of product 718 that are less than the list price recommended for that
product----*/

 select unitprice from salesorderdetail s
 join product p on
 s.productid = p.productid where
 s.productid =718
and unitprice < listprice
 group by unitprice;
 
 
 
 
 
 /*-------9. Display product number, description and sales of each product in the year 2001.------*/
 select productid, (orderqty*unitprice) as sales, description,
 year(shipdate)as year from salesorderdetail s  inner join productdescription p on 
 s.productid= p.productdescriptionid
join salesorderheader h
 on s.salesorderid =h.salesorderid
  where year(shipdate) = "2001"
  ; 
 /*---------10. Build the logic on the above question to extract sales for each category by year. Fetch
Product Name, Sales_2001, Sales_2002, Sales_2003.-----------*/
select name, (orderqty*unitprice) as sales, year(shipdate)as year
from productcategory  p join salesorderdetail s
on p.productcategoryid = s.salesorderdetailid
join salesorderheader h on
s.salesorderid= h.salesorderid
;

/*--------Hint: For questions 9 & 10 (From Sales.SalesOrderHeader, sales. SalesOrderDetail,
Production. Product. Use ShipDate of SalesOrderHeader to extract shipped year.
Calculate sales using QTY and unitprice from Sales OrderDetail.)-----------*/
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 