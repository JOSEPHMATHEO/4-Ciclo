INSERT INTO my_employee VALUES(1, 'Patel', 'Ralph', 'rpatel', 895);
INSERT INTO my_employee VALUES(2, 'Dancs', 'Betty', 'bdancs', 860);

SELECT * FROM my_employee;

INSERT INTO my_employee VALUES(3, 'Biri', 'Ben', 'bbiri', 1100);
INSERT INTO my_employee VALUES(4, 'Newman', 'Chad', 'cnewman', 750);

SELECT * FROM my_employee;

COMMIT;

UPDATE my_employee
SET last_name = 'Drexler'
WHERE id = 3;

UPDATE my_employee
SET salary = 1000
WHERE salary < 900;

SELECT * FROM my_employee;

DELETE  
FROM my_employee
WHERE id = 2;

SELECT * FROM my_employee;

COMMIT;

INSERT INTO my_employee VALUES(5, 'Ropeburn', 'Audrey', 'aropebur', 1550);

SELECT * FROM my_employee;

SAVEPOINT A;

DELETE FROM my_employee;

SELECT * FROM my_employee;

ROLLBACK TO SAVEPOINT A;

SELECT * FROM my_employee;

COMMIT;

SELECT * FROM my_employee;
