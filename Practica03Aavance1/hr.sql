CREATE VIEW ListaEmpleados AS
SELECT emp.EMPLOYEE_ID,
 emp.FIRST_NAME,
 emp.LAST_NAME,
 emp.EMAIL,
 emp.PHONE_NUMBER,
 car.JOB_TITLE,
 emp.SALARY,
 dep.DEPARTMENT_NAME,
 loc.CITY
FROM employees emp
INNER JOIN JOBS car
ON emp.job_id = car.job_id
LEFT JOIN DEPARTMENTS dep
ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
LEFT JOIN LOCATIONS loc
ON dep.location_id = loc.location_id;