-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-04-22 12:04:29 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alquileres (
    nro_horas              SMALLINT NOT NULL,
    usuarios_cedula        VARCHAR2(10) NOT NULL,
    fecha_hora_p           DATE NOT NULL,
    biciletas_nro_registro INTEGER NOT NULL,
    id_alquiler            INTEGER NOT NULL,
    fecha_hora_d           DATE
);

ALTER TABLE alquileres ADD CONSTRAINT alquileres_pk PRIMARY KEY ( id_alquiler );

CREATE TABLE biciletas (
    nro_registro                 INTEGER NOT NULL,
    marca                        VARCHAR2(20) NOT NULL,
    modelo                       VARCHAR2(20) NOT NULL,
    tipo                         CHAR(1) NOT NULL,
    color                        VARCHAR2(20) NOT NULL,
    estado                       CHAR(1) NOT NULL,
    rastreadores_numero          INTEGER NOT NULL,
    fecha_instalacion_rastreador DATE NOT NULL,
    latitud_utlima               FLOAT NOT NULL,
    longitud_ultima              FLOAT NOT NULL
);

ALTER TABLE biciletas ADD CONSTRAINT biciletas_pk PRIMARY KEY ( nro_registro );

ALTER TABLE biciletas ADD CONSTRAINT biciletas__un UNIQUE ( rastreadores_numero );

CREATE TABLE rastreadores (
    numero    INTEGER NOT NULL,
    marca     VARCHAR2(20),
    modelo    VARCHAR2(20),
    nro_serie VARCHAR2(20)
);

ALTER TABLE rastreadores ADD CONSTRAINT rastreadores_pk PRIMARY KEY ( numero );

CREATE TABLE titulos (
    usuarios_cedula VARCHAR2(10) NOT NULL,
    titulo          VARCHAR2(50) NOT NULL
);

ALTER TABLE titulos ADD CONSTRAINT titulos_pk PRIMARY KEY ( usuarios_cedula,
                                                            titulo );

CREATE TABLE usuarios (
    cedula    VARCHAR2(10) NOT NULL,
    nombre    VARCHAR2(40) NOT NULL,
    apellido  VARCHAR2(40) NOT NULL,
    direccion VARCHAR2(300) NOT NULL,
    email     VARCHAR2(100) NOT NULL,
    telefono1 VARCHAR2(15),
    telefono2 VARCHAR2(15),
    telefono  VARCHAR2(15)
);

ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( cedula );

ALTER TABLE alquileres
    ADD CONSTRAINT alquileres_biciletas_fk FOREIGN KEY ( biciletas_nro_registro )
        REFERENCES biciletas ( nro_registro );

ALTER TABLE alquileres
    ADD CONSTRAINT alquileres_usuarios_fk FOREIGN KEY ( usuarios_cedula )
        REFERENCES usuarios ( cedula );

ALTER TABLE biciletas
    ADD CONSTRAINT biciletas_rastreadores_fk FOREIGN KEY ( rastreadores_numero )
        REFERENCES rastreadores ( numero );

ALTER TABLE titulos
    ADD CONSTRAINT titulos_usuarios_fk FOREIGN KEY ( usuarios_cedula )
        REFERENCES usuarios ( cedula );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             0
-- ALTER TABLE                             10
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
