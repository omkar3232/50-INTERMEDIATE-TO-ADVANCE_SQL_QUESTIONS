USE org;
SELECT * FROM bonus;
SELECT * FROM title;
SELECT * FROM worker;

-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT first_name AS worker_name FROM worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(first_name) FROM worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT department FROM worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTRING(first_name,1,3) FROM worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
SELECT INSTR(first_name, "B") FROM worker WHERE first_name = "Amitabh";
 
-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(first_name) FROM worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(first_name) FROM worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT department, LENGTH(department) FROM worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE (first_name, 'a', 'A') FROM worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT CONCAT(first_name, ' ', last_name) AS COMPLETE_NAME FROM worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker ORDER BY first_name;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker ORDER BY first_name, department DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name IN ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
SELECT * FROM worker WHERE department LIKE 'Admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE first_name LIKE '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM worker WHERE salary BETWEEN 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM worker WHERE YEAR(joining_date) = 2014 AND MONTH(joining_date) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT department, COUNT(*) FROM worker WHERE department = 'Admin';

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(first_name, ' ', last_name) FROM worker
WHERE salary BETWEEN 50000 AND 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT department, COUNT(worker_id) AS no_of_worker FROM worker GROUP BY department
ORDER BY no_of_worker DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT w.* FROM worker AS w INNER JOIN title AS t ON w.worker_id = t.worker_ref_id WHERE t.worker_title = 'Manager';
SELECT * FROM worker AS w INNER JOIN title AS t ON w.worker_id = t.worker_ref_id WHERE t.worker_title = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
SELECT worker_title, count(*) AS count FROM title GROUP BY worker_title HAVING count > 1;
    
-- Q-26. Write an SQL query to show only odd rows from a table.
-- select * from worker where MOD (WORKER_ID, 2) != 0; 
SELECT * FROM worker WHERE MOD (worker_id,2) != 0;
SELECT * FROM worker WHERE MOD (worker_id,2) <> 0;
 
-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM worker WHERE MOD (worker_id, 2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE worker_clone LIKE worker;
INSERT INTO worker_clone SELECT * FROM worker;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT worker.* FROM worker INNER JOIN worker_clone USING(worker_id);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
SELECT worker.* FROM worker LEFT JOIN worker_clone USING(worker_id) WHERE worker_clone.worker_id = NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT CURDATE();
SELECT NOW();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT * FROM worker ORDER BY salary DESC LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM worker ORDER BY salary DESC LIMIT 4,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
SELECT salary FROM worker w1
WHERE 4 = (
SELECT COUNT(DISTINCT (w2.salary))
FROM worker w2
WHERE w2.salary >= w1.salary
);
 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT w1.* FROM worker w1, worker w2 WHERE w1.salary = w2.salary AND w1.worker_id != w2.worker_id;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT MAX(salary) FROM worker
WHERE salary NOT IN (SELECT MAX(salary) FROM worker);

-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM worker
UNION ALL 
SELECT * FROM worker ORDER BY worker_id;

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
SELECT worker_id FROM worker WHERE worker_id NOT IN (SELECT worker_ref_id FROM bonus);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM worker WHERE worker_id <= (SELECT COUNT(worker_id)/2 FROM worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT department, COUNT(department) AS depCount FROM worker GROUP BY department HAVING depCount < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT department, COUNT(department) AS depCount FROM worker GROUP BY department;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM worker WHERE worker_id = (SELECT MAX(worker_id ) FROM worker);

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM worker WHERE worker_id = (SELECT MIN(worker_id) FROM worker);

-- Q-44. Write an SQL query to fetch the last five records from a table.
(SELECT * FROM worker ORDER BY worker_id DESC LIMIT 5) ORDER BY worker_id;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT w.department, w.first_name, w.salary FROM 
(SELECT MAX(salary) AS maxsal, department FROM worker GROUP BY department) temp
INNER JOIN worker w ON temp.department = w.department AND temp.maxsal = w.salary;

-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT DISTINCT salary FROM worker w1
WHERE 3 >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary <= w2.salary) ORDER BY w1.salary DESC;
-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT 
SELECT DISTINCT salary FROM worker ORDER BY salary DESC LIMIT 3;


-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT DISTINCT salary FROM worker w1
WHERE 3 >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary >= w2.salary) ORDER BY w1.salary DESC;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
SELECT DISTINCT salary FROM worker w1
WHERE n >= (SELECT count(DISTINCT salary) FROM worker w2 WHERE w1.salary <= w2.salary) ORDER BY w1.salary DESC;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT department , SUM(salary) AS depSal FROM worker GROUP BY department ORDER BY depSal DESC;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT first_name, salary FROM worker WHERE salary = (SELECT MAX(Salary) FROM worker);

