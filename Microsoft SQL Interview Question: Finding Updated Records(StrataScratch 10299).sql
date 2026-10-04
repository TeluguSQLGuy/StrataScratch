-- =====================================================================
-- Target Table: ms_employee_salary
-- Problem ID: StrataScratch 10299 (Finding Updated Records)
-- Author: TeluguSQLGuy
-- =====================================================================

-- 1. Create Table Definition
CREATE TABLE ms_employee_salary (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INT,
    department_id INT
);

-- 2. Insert Sample Records (StrataScratch Original Data)
INSERT INTO ms_employee_salary (id, first_name, last_name, salary, department_id) VALUES
(1, 'Max', 'Steel', 100000, 1),
(1, 'Max', 'Steel', 110000, 1),
(2, 'Todd', 'Wilson', 110000, 1),
(2, 'Todd', 'Wilson', 125000, 1),
(3, 'Justin', 'Simon', 125000, 1),
(3, 'Justin', 'Simon', 130000, 1),
(4, 'Kelly', 'Coleman', 100000, 2),
(4, 'Kelly', 'Coleman', 115000, 2),
(5, 'Amanda', 'Ray', 110000, 2),
(5, 'Amanda', 'Ray', 120000, 2);

-- 3. Verify Table Data
SELECT * FROM ms_employee_salary;

-- Solution - Method 1 Group by + MAX():
SELECT ID,
              FIRST_NAME,
              LAST_NAME,
              DEPARTMENT,
              MAX(SALARY) AS CURRENT_SALARY

FROM ms_employee_salary
GROUP BY 1,
                    2,
                    3,
                    4
ORDER BY ID ASC;


-- Solution Method 2 CTE + Window Function (Row_Number):

WITH ranked_salaries AS (
SELECT id,
              first_name,
              last_name,
            department_id,
            salary AS current_salary,
           ROW_NUMBER() OVER (PARTITION BY id  ORDER BY salary DESC) AS rn

FROM ms_employee_salary
)

SELECT id,
              first_name,
              last_name,
             department_id,
             current_salary

FROM ranked_salaries

WHERE rn = 1

ORDER BY id ASC;

-- Bonus - Qualify clause:

SELECT id,
       first_name,
       last_name,
       department_id,
       salary AS current_salary
           
FROM ms_employee_salary

QUALIFY ROW_NUMBER() OVER (PARTITION BY id  ORDER BY salary DESC) = 1;
