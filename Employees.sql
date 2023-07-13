/**
 *This is practical 26 to perform SQL query
 *@author md shahnawaj
 *@version 8.0.32 
*/

/** Create database */

CREATE DATABASE employees;

/** Use selected database */

USE employees;

/** Create table hobby */

CREATE TABLE hobby (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  name VARCHAR(45) NOT NULL
);

/** Create table employee */

CREATE TABLE employee (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  first_name VARCHAR(45) NOT NULL, 
  last_name VARCHAR(45) NOT NULL, 
  age INT NOT NULL, 
  mobile_number VARCHAR(17) NOT NULL, 
  address VARCHAR(70) NOT NULL
);

/** Create table employee_salary */

CREATE TABLE employee_salary (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  salary DECIMAL(10, 2) NOT NULL, 
  date DATE NOT NULL, 
  fk_employee_id INT, 
  FOREIGN KEY(fk_employee_id) REFERENCES employee(id)
);

/** Create table employee_hobby */

CREATE TABLE employee_hobby (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  fk_employee_id INT, 
  FOREIGN KEY(fk_employee_id) REFERENCES employee(id), 
  fk_employee_hobby INT, 
  FOREIGN KEY(fk_employee_hobby) REFERENCES hobby(id)
);

/** Insert data in hobby table */

INSERT INTO hobby (name) 
VALUES 
  ("Dancing"), 
  ("Singing"), 
  ("Photography"), 
  ("Cooking"), 
  ("Painting");

/** Insert data in employee table */

INSERT INTO employee (
  first_name, last_name, age, mobile_number, address
) 
VALUES 
  ("Mohan", "Kumar", 23, "8877665544", "Banswara"), 
  ("Sohan", "Kumar", 24, "2877663544", "Talwara"), 
  ("Rohan", "Jain", 23, "8877665534", "Banswara"), 
  ("Garvit", "Gupta", 25, "3277665544", "udaipur"), 
  ("Kartik", "Panchal", 23, "1177665544", "Ahmedabad");

/** Insert data in employee_salary table */

INSERT INTO employee_salary (salary, date, fk_employee_id) 
VALUES 
  (10000, "2023-01-05", 1), 
  (10000, "2023-02-05", 1), 
  (10000, "2023-03-05", 1), 
  (20000, "2023-01-05", 2), 
  (20000, "2023-02-05", 2), 
  (20000, "2023-03-05", 2), 
  (30000, "2023-01-05", 3), 
  (30000, "2023-02-05", 3), 
  (30000, "2023-03-05", 3), 
  (40000, "2023-01-05", 4), 
  (40000, "2023-02-05", 4), 
  (40000, "2023-03-05", 4), 
  (50000, "2023-01-05", 5), 
  (50000, "2023-02-05", 5), 
  (50000, "2023-03-05", 5);

/** Insert data in employee_hobby table */

INSERT INTO employee_hobby (
  fk_employee_id, fk_employee_hobby
) 
VALUES 
  (1, 1), 
  (1, 2), 
  (1, 3), 
  (2, 2), 
  (2, 3), 
  (3, 1), 
  (3, 2), 
  (4, 1), 
  (4, 1), 
  (4, 4), 
  (5, 1), 
  (5, 5);

/** Update data in table */

UPDATE 
  hobby 
SET 
  name = "Shopping" 
WHERE 
  id = 1;
  
UPDATE 
  employee 
SET 
  address = "Canada" 
WHERE 
  id = 1;
  
UPDATE 
  employee_salary 
SET 
  salary = 15000 
WHERE 
  id = 3;
  
UPDATE 
  employee_hobby 
SET 
  fk_employee_hobby = 5 
WHERE 
  id = 4;
  
/** Delete data in table */

DELETE FROM 
  employee_hobby 
WHERE 
  id = 9;
  
DELETE FROM 
  hobby 
WHERE 
  id = 6;
  
DELETE FROM 
  employee_salary 
WHERE 
  id = 15;
  
DELETE FROM 
  employee 
WHERE 
  id = 6;
  
/** Truncate all table */

TRUNCATE hobby;
TRUNCATE employee_hobby;
TRUNCATE employee_salary;
TRUNCATE employee;

/** Select queries to get a hobby, employee, employee_salary,employee_hobby */

SELECT 
  * 
FROM 
  hobby;
  
SELECT 
  * 
FROM 
  employee;
  
SELECT 
  * 
FROM 
  employee_salary;
  
SELECT 
  * 
FROM 
  employee_hobby;
  
/** Create a select single query to get all employee name, all hobby_name in single column */

SELECT 
  Concat(first_name, ' ', last_name) AS "Name And Hobby" 
FROM 
  employee 
UNION ALL 
SELECT 
  name 
FROM 
  hobby;

/** Create a select query to get employee name, his/her employee_salary */

SELECT 
  Concat(first_name, ' ', last_name) AS "Employee Name", 
  salary As Salary 
FROM 
  employee 
  INNER JOIN employee_salary ON employee.id = employee_salary.fk_employee_id;

/** Create a select query to get employee name, total salary of employee, hobby 
name(comma-separated - you need to use subquery for hobby name) */

SELECT 
  Concat(
    employee.first_name, ' ', employee.last_name
  ) AS "Employees Name", 
  Sum(salary) AS "Total Salary", 
  (
    SELECT 
      Group_concat(DISTINCT hobby.name) 
    FROM 
      hobby 
      INNER JOIN employee_hobby ON employee_hobby.fk_employee_hobby = hobby.id 
      AND employee_hobby.fk_employee_id = employee.id
  ) AS Hobbies 
FROM 
  employee 
  LEFT JOIN employee_salary ON employee.id = fk_employee_id 
GROUP BY 
  employee.id;