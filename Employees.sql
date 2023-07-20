/**
 *This is practical 26 to perform SQL query
 *@author md shahnawaj
 *@version 8.0.32 
*/

/** Create database */

CREATE DATABASE employeeses;

/** Use selected database */

USE employeeses;

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
  address VARCHAR(255) NOT NULL
);

/** Create table employee_salary */

CREATE TABLE employee_salary (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  salary DECIMAL(10, 2) NOT NULL, 
  salary_date DATE NOT NULL, 
  fk_employee_id INT, 
  CONSTRAINT fk_employee_id FOREIGN KEY(fk_employee_id) REFERENCES employee(id)
);

/** Create table employee_hobby */

CREATE TABLE employee_hobby (
  id INT PRIMARY KEY NOT NULL auto_increment, 
  fk_employee_id INT, 
  FOREIGN KEY(fk_employee_id) REFERENCES employee(id), 
  fk_employee_hobby_id INT, 
  CONSTRAINT fk_employee_hobby_id FOREIGN KEY(fk_employee_hobby_id) REFERENCES hobby(id)
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

INSERT INTO employee_salary (salary, salary_date, fk_employee_id) 
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
  fk_employee_id, fk_employee_hobby_id
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

/** Update hobby name from hobby table */

UPDATE 
  hobby 
SET 
  name = "Shopping" 
WHERE 
  id = 1;

/** Update employee address from employee table */
  
UPDATE 
  employee 
SET 
  address = "Canada" 
WHERE 
  id = 1;

/** Update employee salary from employee_salary table */
  
UPDATE 
  employee_salary 
SET 
  salary = 15000 
WHERE 
  id = 3;

/** Update fk_employee_hobby from employee_hobby table */

UPDATE 
  employee_hobby 
SET 
  fk_employee_hobby = 5 
WHERE 
  id = 4;
  
/** Delete record from employee_hobby table */

DELETE FROM 
  employee_hobby 
WHERE 
  id = 9;

/** Delete record from hobby table */

DELETE FROM 
  hobby 
WHERE 
  id = 6;

/** Delete record from employee_salary table */

DELETE FROM 
  employee_salary 
WHERE 
  id = 15;

/** Delete record from employee table */

DELETE FROM 
  employee 
WHERE 
  id = 6;
  
/** Truncate all table */

TRUNCATE hobby;
TRUNCATE employee_hobby;
TRUNCATE employee_salary;
TRUNCATE employee;

/** Print all data from hobby table */

SELECT * FROM hobby;

/** Print all data from employee table */

SELECT * FROM employee;

/** Print all data from employee_salary table */

SELECT * FROM employee_salary;

/** Print all data from employee_hobby */

SELECT * FROM employee_hobby;
  
/** Create a select single query to get all employee name, all hobby_name in single column */

SELECT 
  Concat(first_name, ' ', last_name) AS "Name And Hobbies" 
FROM 
  employee 
UNION ALL 
SELECT 
  name 
FROM 
  hobby;

/** Create a select query to get employee name, his/her employee_salary */

SELECT 
  Concat(e.first_name, ' ', e.last_name) AS "Employee Name", 
  salary AS employee_salary 
FROM 
  employee e
  LEFT JOIN employee_salary es ON e.id = es.fk_employee_id;

/** Create a select query to get employee name, total salary of employee, hobby 
name(comma-separated - you need to use subquery for hobby name) */

SELECT 
  Concat(e.first_name, ' ', e.last_name) AS "Employee", 
  Sum(salary) AS "Total Salary", 
  (SELECT Group_concat(DISTINCT h.name) FROM hobby h 
      INNER JOIN employee_hobby eh ON eh.fk_employee_hobby_id = h.id 
      AND eh.fk_employee_id = e.id) AS Hobbies 
FROM 
  employee e 
  LEFT JOIN employee_salary es ON e.id = es.fk_employee_id 
GROUP BY e.id;
