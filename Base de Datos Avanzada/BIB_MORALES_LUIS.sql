-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-05-06 18:41:07 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE areas_conocimientp (
    codareas     VARCHAR2(15) NOT NULL,
    nombrearea   VARCHAR2(250) NOT NULL,
    codareapadre VARCHAR2(15)
);

ALTER TABLE areas_conocimientp ADD CONSTRAINT areas_conocimientp_pk PRIMARY KEY ( codareas );

CREATE TABLE autores (
    idautor     INTEGER NOT NULL,
    nombreautor VARCHAR2(100) NOT NULL,
    pais        CHAR(2) NOT NULL,
    foto        BLOB,
    bio         VARCHAR2(2500),
    numlibros   INTEGER NOT NULL
);

ALTER TABLE autores ADD CONSTRAINT autores_pk PRIMARY KEY ( idautor );

CREATE TABLE autorias (
    orden    SMALLINT NOT NULL,
    idautor  INTEGER NOT NULL,
    idlibros INTEGER NOT NULL
);

ALTER TABLE autorias ADD CONSTRAINT autorias_pk PRIMARY KEY ( idautor,
                                                              idlibros );

CREATE TABLE editoriales (
    idedt     INTEGER NOT NULL,
    nombreedt VARCHAR2(100) NOT NULL,
    pais      VARCHAR2(100) NOT NULL,
    web       VARCHAR2(200)
);

ALTER TABLE editoriales ADD CONSTRAINT editoriales_pk PRIMARY KEY ( idedt );

CREATE TABLE ejemplares (
    idejemplar INTEGER NOT NULL,
    ubicacion  VARCHAR2(40),
    status     CHAR(1) NOT NULL,
    idlibro    INTEGER NOT NULL
);

ALTER TABLE ejemplares ADD CONSTRAINT ejemplares_pk PRIMARY KEY ( idejemplar );

CREATE TABLE libros (
    idlibro    INTEGER NOT NULL,
    isbn       VARCHAR2(15),
    titulo     VARCHAR2(500) NOT NULL,
    sinopsis   VARCHAR2(2500),
    numpaginas INTEGER NOT NULL,
    idioma     CHAR(2) NOT NULL,
    anio       NUMBER(4) NOT NULL,
    nroedicion NUMBER(2) NOT NULL,
    imgportada BLOB,
    codarea    VARCHAR2(15) NOT NULL,
    idedt      INTEGER NOT NULL
);

ALTER TABLE libros ADD CONSTRAINT libros_pk PRIMARY KEY ( idlibro );

ALTER TABLE libros ADD CONSTRAINT libros__un UNIQUE ( isbn );

CREATE TABLE prestamos (
    idprestamos      INTEGER NOT NULL,
    "fechaPrestamo " DATE NOT NULL,
    fechavencimiento DATE NOT NULL,
    fechadevolucion  DATE,
    observacion      VARCHAR2(2000) NOT NULL,
    idejemplar       INTEGER NOT NULL,
    cedula           VARCHAR2(15) NOT NULL
);

ALTER TABLE prestamos ADD CONSTRAINT prestamos_pk PRIMARY KEY ( idprestamos );

CREATE TABLE usuarios (
    cedula    VARCHAR2(15) NOT NULL,
    apellidos VARCHAR2(50) NOT NULL,
    nombres   VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(250),
    telefono1 VARCHAR2(20),
    telefono2 VARCHAR2(20),
    telefono3 VARCHAR2(20),
    email     VARCHAR2(60)
);

ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( cedula );

ALTER TABLE usuarios ADD CONSTRAINT usuarios__un UNIQUE ( email );

ALTER TABLE prestamos
    ADD CONSTRAINT cedula FOREIGN KEY ( cedula )
        REFERENCES usuarios ( cedula );

ALTER TABLE libros
    ADD CONSTRAINT codarea FOREIGN KEY ( codarea )
        REFERENCES areas_conocimientp ( codareas );

ALTER TABLE areas_conocimientp
    ADD CONSTRAINT codareapadre FOREIGN KEY ( codareapadre )
        REFERENCES areas_conocimientp ( codareas );

ALTER TABLE autorias
    ADD CONSTRAINT idautor FOREIGN KEY ( idautor )
        REFERENCES autores ( idautor );

ALTER TABLE libros
    ADD CONSTRAINT idedt FOREIGN KEY ( idedt )
        REFERENCES editoriales ( idedt );

ALTER TABLE prestamos
    ADD CONSTRAINT idejemplar FOREIGN KEY ( idejemplar )
        REFERENCES ejemplares ( idejemplar );

ALTER TABLE autorias
    ADD CONSTRAINT idlibros FOREIGN KEY ( idlibros )
        REFERENCES libros ( idlibro );

ALTER TABLE ejemplares
    ADD CONSTRAINT idlibrosv2 FOREIGN KEY ( idlibro )
        REFERENCES libros ( idlibro );
        
ALTER TABLE prestamos ADD CONSTRAINT chk_fechaDevolucion CHECK (fechadevolucion >= fechaprestamo);

ALTER TABLE libros ADD CONSTRAINT chk_numPaginas CHECK (numpaginas > 50 AND numpaginas < 2000);

ALTER TABLE libros ADD CONSTRAINT chk_nroEdicion CHECK (nroedicion > 0);

ALTER TABLE libros ADD CONSTRAINT chk_anio CHECK (anio > 1800);

ALTER TABLE ejemplares ADD CONSTRAINT chk_status CHECK (status IN ('D', 'P', 'B'));

ALTER TABLE autores ADD CONSTRAINT chk_numLibros CHECK (numlibros >= 0);

ALTER TABLE usuarios ADD CONSTRAINT chk_email CHECK (email LIKE '%__@__%' );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             18
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
