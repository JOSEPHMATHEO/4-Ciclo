SELECT d.department_name, COUNT(*)as Total_Empleados, 
        COUNT(e.commission_pct) Con_comision, 
        COUNT(*) - COUNT(e.commission_pct) as Sin_comision
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d
   ON e.department_id = d.department_id
WHERE e.salary >= 4000
GROUP BY d.department_name
HAVING COUNT(*) >5;


SELECT d.department_name, COUNT(*)as Total_Empleados, 
        SUM(NVL2(e.commission_pct,1,0)) Con_comision, 
        SUM(NVL2(e.commission_pct,0,1)) as Sin_comision
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d
   ON e.department_id = d.department_id
WHERE e.salary >= 4000
GROUP BY d.department_name
HAVING COUNT(*) >5;

SELECT last_name,salary
FROM EMPLOYEES e
WHERE e.salary > 
                (SELECT salary 
                FROM Employees e
                WHERE last_name = 'Abel');
                
                
SELECT e.employee_id, e.last_name
FROM EMPLOYEES e
WHERE e.department_id = ANY
                    (SELECT DISTINCT e.department_id 
                    FROM EMPLOYEES e
                    WHERE lower(e.last_name)like '%u%'
                    );