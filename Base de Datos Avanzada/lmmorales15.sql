-- 2.En el esquema del nuevo usuario crear una nueva tabla llamada PERSONAS 
-- (Definir los campos a su criterio, al menos 5

CREATE TABLE PERSONAS(

        nombre VARCHAR2(50) NOT NULL PRIMARY KEY, 
        apellido VARCHAR2(50) NOT NULL, 
        correo VARCHAR2(50), 
        telefono VARCHAR2(50) NOT NULL, 
        direccion VARCHAR2(500) NOT NULL
    );