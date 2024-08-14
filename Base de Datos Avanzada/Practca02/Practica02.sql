CREATE TABLE areas_conocimiento(
    
    codArea VARCHAR2(15) NOT NULL PRIMARY KEY ,
    nombreArea VARCHAR2(250) NOT NULL,
    codAreaPadre VARCHAR2(15)
    
);

ALTER TABLE areas_conocimiento
FOREINGKEY(codAreaPadre)REFERENCES areas_conocimiento (codArea);





CREATE TABLE libros(
    
    idLibro INTEGER NOT NULL PRIMARY KEY ,
    IdEjemplar INTEGER NOT NULL,
    cedula VARCHAR2(15) NOT NULL,
    fechaPrestamo DATE NOT NULL,
    fechaVencimiento DATE NOT NULL,
    fechaDevolucion DATE,
    observacion VARCHAR(2000)
    
);

ALTER TABLE libros
FOREINGKEY(codAreaPadre)REFERENCES areas_conocimiento (codArea);

