 -- Pregunta 1

SELECT last_name, first_name, 
        job_id, (CASE job_id 
                    WHEN 'ST_CLERK' THEN  'E'
                    WHEN'SA_REP' THEN 'D'
                    WHEN'IT_PROG' THEN 'C' 
                    WHEN'ST_MAN' THEN 'B'
                    WHEN  'AD_PRES' THEN 'A'
                    ELSE '0'
                END) as GRADE
FROM employees;


-- Pregunta 2 

SELECT MAX(e.salary)Salario_Maximo, count(e.job_id), d.department_name Total_de_Roles
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY MAX(e.salary)DESC;


-- Pregunta 3

SELECT e.employee_id, Concat(e.first_name, e.last_name) AS Nombre_Completo
FROM Employees e
WHERE salary = ANY (SELECT e.salary
                FROM employees e
                WHERE e.department_id = 60);
                
                
-- Pregunta 4

SELECT d.department_name, COUNT(e.employee_id)
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id 
GROUP BY (d.department_name)
HAVING COUNT(e.employee_id) >=(
                                SELECT COUNT(e.employee_id)
                                FROM employees e
                                INNER JOIN departments d ON d.department_id = e.department_id
                                WHERE d.department_name = 'Purchasing'
                                );


    