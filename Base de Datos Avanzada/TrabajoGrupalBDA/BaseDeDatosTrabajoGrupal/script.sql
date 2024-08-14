-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-05-10 21:35:09 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

-- Creacion de Usuarios

CREATE USER invitado IDENTIFIED BY invitado;

-- Asignacion de Roles al Usuario 

GRANT CONNECT,RESOURCE TO INVITADO;

-- Creacion de los TABLESPACE

CREATE TABLESPACE RegistrosMARU 
    DATAFILE 
        'C:/Datos/RegistroAsistencias_01' SIZE 3M,
        'C:/Datos/RegistroAsistencias_02' SIZE 4M;
        
CREATE TABLESPACE IndicesMARU
    DATAFILE 
        'C:/Datos/IndicesMARU_01' SIZE 7M;

-- Creacion de las Tablas

CREATE TABLE asignaciones (
    id_estudiantes  INTEGER NOT NULL,
    id_rangos       INTEGER NOT NULL,
    fecha_alcanzada DATE NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE asignaciones ADD CONSTRAINT asignaciones_pk PRIMARY KEY ( id_rangos,
                                                                      id_estudiantes );

CREATE TABLE asistencias (
    id_estudiante    INTEGER NOT NULL,
    id_clases        INTEGER NOT NULL,
    fecha_asistencia DATE NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE asistencias ADD CONSTRAINT asistencias_pk PRIMARY KEY ( id_estudiante,
                                                                    id_clases );

CREATE TABLE clases (
    id_clase   INTEGER NOT NULL,
    lugar      VARCHAR2(15) NOT NULL,
    fecha_hora DATE NOT NULL,
    nivel      VARCHAR2(15) NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE clases ADD CONSTRAINT clases_pk PRIMARY KEY ( id_clase );

CREATE TABLE estudiantes (
    id_estudiante INTEGER NOT NULL,
    nombre        VARCHAR2(50) NOT NULL,
    apellido      VARCHAR2(50) NOT NULL,
    fecha_nac     DATE NOT NULL,
    fecha_ingre   DATE NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE estudiantes ADD CONSTRAINT estudiante_pk PRIMARY KEY ( id_estudiante );

CREATE TABLE impartidas (
    id_instructores INTEGER NOT NULL,
    id_clases       INTEGER NOT NULL,
    funcion         VARCHAR2(10) NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE impartidas ADD CONSTRAINT impartidas_pk PRIMARY KEY ( id_clases,
                                                                  id_instructores );

CREATE TABLE instructores (
    id_instructor   INTEGER NOT NULL,
    fecha_inicio    DATE NOT NULL,
    tipo_instructor CHAR(1) NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE instructores ADD CONSTRAINT instructores_pk PRIMARY KEY ( id_instructor );

CREATE TABLE rangos (
    id_rango    INTEGER NOT NULL,
    nombre      VARCHAR2(50) NOT NULL,
    color_cinta CHAR(1) NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE rangos ADD CONSTRAINT rangos_pk PRIMARY KEY ( id_rango );

CREATE TABLE requisitos (
    requisito VARCHAR2(1000) NOT NULL,
    id_rango  INTEGER NOT NULL
)TABLESPACE RegistrosMARU;

ALTER TABLE requisitos ADD CONSTRAINT requisitos_pk PRIMARY KEY ( id_rango,
                                                                  requisito );

-- Constrains de Llaves Foraneas 

ALTER TABLE asignaciones
    ADD CONSTRAINT asignaciones_estudiante_fk FOREIGN KEY ( id_estudiantes )
        REFERENCES estudiantes ( id_estudiante );

ALTER TABLE asignaciones
    ADD CONSTRAINT asignaciones_rangos_fk FOREIGN KEY ( id_rangos )
        REFERENCES rangos ( id_rango );

ALTER TABLE asistencias
    ADD CONSTRAINT asistencias_clases_fk FOREIGN KEY ( id_clases )
        REFERENCES clases ( id_clase );

ALTER TABLE asistencias
    ADD CONSTRAINT asistencias_estudiante_fk FOREIGN KEY ( id_estudiante )
        REFERENCES estudiantes ( id_estudiante );

ALTER TABLE impartidas
    ADD CONSTRAINT impartidas_clases_fk FOREIGN KEY ( id_clases )
        REFERENCES clases ( id_clase );

ALTER TABLE impartidas
    ADD CONSTRAINT impartidas_instructores_fk FOREIGN KEY ( id_instructores )
        REFERENCES instructores ( id_instructor );

ALTER TABLE instructores
    ADD CONSTRAINT instructores_estudiantes_fk FOREIGN KEY ( id_instructor )
        REFERENCES estudiantes ( id_estudiante );

ALTER TABLE requisitos
    ADD CONSTRAINT requisitos_rangos_fk FOREIGN KEY ( id_rango )
        REFERENCES rangos ( id_rango );


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             16
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
