-- 6 Verificar que el usuario UPRACTICA, en efecto puede 
-- Consultar la vista
SELECT * FROM HR.InfoDepartamento;

-- Manipular la tabla PERSONAS
-- Insertar 
INSERT INTO LMMORALES15.PERSONAS (nombre, apellido, correo, telefono, direccion) 
VALUES ('Luis', 'Morales', 'llmorales@gmail.com', '0991526892', 'Turunuma Alto');

-- Consultar
SELECT * FROM LMMORALES15.PERSONAS;

-- Borrar 
DELETE FROM LMMORALES15.PERSONAS WHERE nombre = 'santiago';

-- Actualizar 
UPDATE LMMORALES15.PERSONAS SET nombre = 'Joseph' WHERE nombre = 'Luis';

-- consultar EMPLOYEES.

SELECT * FROM HR.EMPLOYEES;

-- Usuario: UPRACTICA