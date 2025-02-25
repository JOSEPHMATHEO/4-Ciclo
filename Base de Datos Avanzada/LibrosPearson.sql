DROP USER librospearson CASCADE;

CREATE USER librospearson IDENTIFIED BY "oracle"
DEFAULT TABLESPACE users;

GRANT connect, resource TO librospearson;

CREATE TABLE librospearson.libros (
    isbn        VARCHAR2(13) NOT NULL,
    titulo      VARCHAR2(80) NOT NULL,
    edicion     NUMBER(2) NOT NULL,
    area        VARCHAR2(15) NOT NULL,
    anio        NUMBER(4) NOT NULL,
    CONSTRAINT libros_pk PRIMARY KEY ( isbn )
);

CREATE TABLE librospearson.autores (
    isbn         VARCHAR2(13) NOT NULL,
    autor        VARCHAR2(20) NOT NULL,
    CONSTRAINT autores_pk PRIMARY KEY ( isbn, autor )
);

INSERT INTO librospearson.libros VALUES ('9786073244244','QUIMICA 1',2,'Ciencias',2018);
INSERT INTO librospearson.libros VALUES ('9786073247238','FISICA 2',1,'Ciencias',2018);
INSERT INTO librospearson.libros VALUES ('9786073244800','MATEMATICAS 3',2,'Matemáticas',2018);
INSERT INTO librospearson.libros VALUES ('9786073248006','GEOMETRIA Y TRIGONOMETRIA',1,'Matemáticas',2019);
INSERT INTO librospearson.libros VALUES ('9786073244206','BIOLOGIA',1,'Ciencias',2018);
INSERT INTO librospearson.libros VALUES ('9786073243940','LITERATURA UNIVERSAL',5,'Humanidades',2018);
INSERT INTO librospearson.libros VALUES ('9786073238229','FISICA CONCEPTUAL',12,'Ciencias',2016);
INSERT INTO librospearson.libros VALUES ('9786073251792','EXPERIMENTACION QUIMICA YPENSAMIENTO ESTADISTICO',1,'Ciencias',2020);
INSERT INTO librospearson.libros VALUES ('9786073235808','GEOMETRIA, TRIGONOMETRIA Y GEOMETRIA ANALITICA',4,'Matemáticas',2015);
INSERT INTO librospearson.libros VALUES ('9786073242011','EL PLACER DE LA ESCRITURA MANUAL DE APROPIACION DE LA LENGUA',5,'Humanidades',2018);
INSERT INTO librospearson.libros VALUES ('9786073250955','RAZONAMIENTO MATEMATICO CON APLICACIONES EN LOS NEGOCIOS',1,'Matemáticas',2019);
INSERT INTO librospearson.libros VALUES ('9786073238380','BIOLOGIA',1,'Ciencias',2016);
INSERT INTO librospearson.libros VALUES ('9786073233316','CALCULO UNA VARIABLE',13,'Matemáticas',2015);
INSERT INTO librospearson.libros VALUES ('9786073243063','DIBUJO',1,'Humanidades',2018);
INSERT INTO librospearson.libros VALUES ('9786073239073','INFORMATICA 2',1,'Computación',2016);
INSERT INTO librospearson.libros VALUES ('9786073237789','TALLER DE LECTURA Y REDACCION 1',3,'Humanidades',2016);
INSERT INTO librospearson.libros VALUES ('9786073235761','GEOMETRIA ANALITICA',4,'Matemáticas',2015);
INSERT INTO librospearson.libros VALUES ('9786073244213','MATEMATICAS 1',2,'Ciencias',2018);
INSERT INTO librospearson.libros VALUES ('9786073239233','QUIMICA 2',1,'Ciencias',2016);
INSERT INTO librospearson.libros VALUES ('9786073237451','ALGEBRA LINEAL Y SUS APLICACIONES',5,'Matemáticas',2016);
INSERT INTO librospearson.libros VALUES ('9786073243780','ESTADISTICA 12 ED',12,'Matemáticas',2018);
INSERT INTO librospearson.libros VALUES ('9786073241984','ORIENTACION EDUCATIVA IV',2,'Humanidades',2018);
INSERT INTO librospearson.libros VALUES ('9786073235853','CALCULO DIFERENCIAL E INTEGRAL',4,'Matemáticas',2015);
INSERT INTO librospearson.libros VALUES ('9786073237642','MATEMATICAS 1',1,'Matemáticas',2016);
INSERT INTO librospearson.libros VALUES ('9786073249881','CALCULO DIFERENCIAL E INTEGRAL',2,'Matemáticas',2019);
INSERT INTO librospearson.libros VALUES ('9786073240994','MECANICA DE MATERIALES',9,'Ingeniería',2017);
INSERT INTO librospearson.libros VALUES ('9788490354926','OPTICA',5,'Ingeniería',2016);
INSERT INTO librospearson.libros VALUES ('9786073238021','COMO PROGRAMAR EN JAVA',10,'Computación',2016);
INSERT INTO librospearson.libros VALUES ('9788490356074','INTRODUCCION A LA FARMACOLOGIA',2,'Ciencias',2018);

INSERT INTO librospearson.autores VALUES ('9786073244244','LOPEZ');
INSERT INTO librospearson.autores VALUES ('9786073244244','GUTIERREZ');
INSERT INTO librospearson.autores VALUES ('9786073247238','SLISKO');
INSERT INTO librospearson.autores VALUES ('9786073244800','JIMENEZ');
INSERT INTO librospearson.autores VALUES ('9786073248006','JIMÉNEZ');
INSERT INTO librospearson.autores VALUES ('9786073244206','AUDESIRK');
INSERT INTO librospearson.autores VALUES ('9786073243940','CORREA');
INSERT INTO librospearson.autores VALUES ('9786073238229','HEWITT');
INSERT INTO librospearson.autores VALUES ('9786073251792','RODRIGUEZ');
INSERT INTO librospearson.autores VALUES ('9786073235808','AGUILAR');
INSERT INTO librospearson.autores VALUES ('9786073242011','CORREA');
INSERT INTO librospearson.autores VALUES ('9786073250955','GLAROS');
INSERT INTO librospearson.autores VALUES ('9786073238380','GAMA');
INSERT INTO librospearson.autores VALUES ('9786073233316','THOMAS');
INSERT INTO librospearson.autores VALUES ('9786073243063','RUBIN');
INSERT INTO librospearson.autores VALUES ('9786073239073','PÉREZ');
INSERT INTO librospearson.autores VALUES ('9786073237789','DE TERESA');
INSERT INTO librospearson.autores VALUES ('9786073235761','AGUILAR');
INSERT INTO librospearson.autores VALUES ('9786073244213','JIMÉNEZ');
INSERT INTO librospearson.autores VALUES ('9786073239233','GUTIERREZ');
INSERT INTO librospearson.autores VALUES ('9786073237451','C. LAY');
INSERT INTO librospearson.autores VALUES ('9786073243780','TRIOLA');
INSERT INTO librospearson.autores VALUES ('9786073241984','ONOFRE');
INSERT INTO librospearson.autores VALUES ('9786073235853','AGUILAR');
INSERT INTO librospearson.autores VALUES ('9786073237642','JIMENEZ');
INSERT INTO librospearson.autores VALUES ('9786073237642','ESTRADA');
INSERT INTO librospearson.autores VALUES ('9786073249881','OTEYZA');
INSERT INTO librospearson.autores VALUES ('9786073240994','HIBBELER');
INSERT INTO librospearson.autores VALUES ('9788490354926','HECHT');
INSERT INTO librospearson.autores VALUES ('9786073238021','DEITEL');
INSERT INTO librospearson.autores VALUES ('9788490356074','MCFADDEN');

COMMIT;

