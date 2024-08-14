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
 
ALTER TABLE autorias ADD CONSTRAINT autorias_pk PRIMARY KEY ( idautor, idlibros ); 
 
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
    fechaPrestamo    DATE NOT NULL, 
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
 
ALTER TABLE usuarios ADD CONSTRAINT chk_email CHECK (email LIKE '%@%' );

-- Inserci n de datos en editoriales

INSERT INTO editoriales (idedt, nombreedt, pais, web) VALUES (1, 'Editorial A', 'USA', 'www.editoriala.com');
INSERT INTO editoriales (idedt, nombreedt, pais, web) VALUES (2, 'Editorial B', 'UK', 'www.editorialb.co.uk');
INSERT INTO editoriales (idedt, nombreedt, pais, web) VALUES (3, 'Editorial C', 'FR', 'www.editorialc.fr');
INSERT INTO editoriales (idedt, nombreedt, pais, web) VALUES (4, 'Editorial D', 'ECU', 'www.editoriald.edu');
INSERT INTO editoriales (idedt, nombreedt, pais, web) VALUES (5, 'Editorial E', 'BR', 'www.editoriale.br');

-- Inserci n de datos en areas_conocimientp

INSERT INTO areas_conocimientp (codareas, nombrearea, codareapadre) VALUES ('AC001', 'Ciencia', 'AC001');
INSERT INTO areas_conocimientp (codareas, nombrearea, codareapadre) VALUES ('AC002', 'Arte', 'AC002');
INSERT INTO areas_conocimientp (codareas, nombrearea, codareapadre) VALUES ('AC003', 'Tecnolog a', 'AC003');

-- Crear Directorio

CREATE DIRECTORY IMAGES_DIR AS 'C:\TareaGrupal2BDA\imagen_portada';

-- Insersion de Datos / Img Blob

-- LIBRO 1
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(1, '9780307474728', 'Cien a os de soledad', 'Cien a os de soledad es 
    una novela del escritor colombiano Gabriel Garc a M rquez que narra la 
    historia de varias generaciones de la familia Buend a y su maldici n, que 
    castiga el matrimonio entre parientes d ndoles hijos con cola de cerdo', 
    432, 'ES', 1967, 1, EMPTY_BLOB(), 'AC002', 1)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_cien_a os_de_soledad.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Insertar autor
    INSERT INTO AUTORES (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES (1, 'Gabriel Garc a M rquez', 'CB', NULL, 'Gabriel Garc a M rquez naci  
    el 6 de marzo de 1927 en Aracataca, Colombia. Es considerado uno de los escritores 
    m s importantes del siglo XX y uno de los principales exponentes del realismo m gico. 
    Garc a M rquez es conocido por su estilo narrativo  nico y su capacidad para combinar 
    lo real y lo fant stico en sus obras. Entre sus obras m s destacadas se encuentran 
    "Cien a os de soledad", "El amor en los tiempos del c lera" y "Cr nica de una muerte 
    anunciada". Gan  el Premio Nobel de Literatura en 1982 por su contribuci n a la literatura mundial.', 25);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 1, 1);
END;

-- LIBRO 2
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de "El amor en los tiempos del c lera"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(2, '978-84-663-2167-6', 'El amor en los tiempos del c lera', 
    'Esta novela cuenta la historia de amor entre Fermina Daza y Florentino Ariza,
    quienes se enamoran en su juventud pero se separan por circunstancias de la vida.
    A lo largo de d cadas, Florentino espera pacientemente para volver a conquistar 
    el coraz n de Fermina.', NULL, 'Espa ol', 1985, NULL, EMPTY_BLOB(), 'AC002', 1)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_amor_tiempo_colera.jpg');
    
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 1, 2);
    
-- LIBRO 3

    -- Insertar "Cr nica de una muerte anunciada"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(3, '978-84-08-09358-9', 'Cr nica de una muerte anunciada', 
    'Esta novela relata los eventos que llevan a la muerte de Santiago Nasar,
    un joven cuya muerte estaba anunciada pero nadie hizo nada para evitarla. 
    A trav s de m ltiples narradores, se revelan los secretos y las motivaciones 
    detr s de este crimen.', NULL, 'Espa ol', 1981, NULL, EMPTY_BLOB(), 'AC002', 1)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_cronica_muerte_anunciada.jpg');
    
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 1, 3);

-- LIBRO 4

    -- Insertar "La hojarasca"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(4, '978-84-376-0602-1', 'La hojarasca', 'Esta novela marca el 
    debut literario de Garc a M rquez. Narra la historia de un m dico que 
    regresa al pueblo donde creci  para atender al funeral de un viejo amigo. 
    A trav s de los recuerdos y testimonios de los habitantes del pueblo, 
    se revelan los eventos tr gicos que llevaron a la muerte del amigo.', 
    NULL, 'Espa ol', 1955, NULL, EMPTY_BLOB(), 'AC002', 1)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_la_hojarasca.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 1, 4);

    -- Insertar ejemplares (ejemplo)
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (1, 'Estante A1', 'Disponible', 2);

    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (2, 'Estante B2', 'Prestado', 2);

    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (3, 'Estante C3', 'Disponible', 3);

    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (4, 'Estante D4', 'Disponible', 4);
END;k

-- Libro 5

DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Insertar "La singularidad est  cerca"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(5, '978-84-8306-717-9', 'La singularidad est  cerca: 
    Cuando los humanos transcendamos la biolog a', 'En este libro, 
    Ray Kurzweil explora el concepto de la singularidad tecnol gica, 
    un punto futuro en el que la inteligencia artificial y otras tecnolog as 
    alcanzar n un nivel que transformar  radicalmente la sociedad y la condici n humana.',
    680, 'Espa ol', 2006, NULL, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_singularidad_cerca.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);
    
    INSERT INTO AUTORES (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES(2, 'Ray Kurzweil', 'Estados Unidos', NULL, 'Ray Kurzweil naci  el 12 de febrero de 
    1948 en Queens, Nueva York. Es un inventor, futurista, y empresario estadounidense. 
    Kurzweil es conocido por sus contribuciones en el campo de la inteligencia artificial, 
    la biotecnolog a y la futur stica. Ha fundado varias empresas en  reas como el reconocimiento 
    de voz y la s ntesis de voz, y ha recibido numerosos premios y honores por sus innovaciones 
    tecnol gicas. Es autor de varios libros que exploran temas como el futuro de la tecnolog a, 
    la singularidad tecnol gica y la prolongaci n de la vida.', 0);


    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 2, 5);

    -- Insertar ejemplares de "La singularidad est  cerca"
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (1, 'Estante A1', 'Disponible', 5);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (2, 'Estante A2', 'Disponible', 5);

-- Libro 6

    -- Insertar "C mo crear una mente"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(6, '978-84-15751-48-0', 'C mo crear una mente: El secreto del pensamiento humano',
    'En este libro, Kurzweil explora el funcionamiento del cerebro humano y propone un modelo
    de c mo podr amos recrear la inteligencia artificial para simular el pensamiento humano. 
    Ofrece una visi n fascinante de la mente y la tecnolog a.', 
    480, 'Espa ol', 2012, NULL, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_crear_mentes.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 2, 6);

    -- Insertar ejemplares de "C mo crear una mente"
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (3, 'Estante B1', 'Disponible', 6);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (4, 'Estante B2', 'Disponible', 6);
    
-- Libro 7

    -- Insertar "La era de las m quinas espirituales"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(7, '978-84-493-0530-8', 'La era de las m quinas espirituales', 
    'En este libro, Kurzweil explora el futuro de la inteligencia artificial 
    y c mo cambiar  la sociedad y la naturaleza misma de lo que significa ser humano. 
    Proporciona una visi n provocativa y optimista del papel de la tecnolog a en 
    la evoluci n de la humanidad.', 432, 'Espa ol', 1999, NULL, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_maquinas_espirituales.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 2, 7);

    -- Insertar ejemplares de "La era de las m quinas espirituales"
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (5, 'Estante C1', 'Disponible', 7);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (6, 'Estante C2', 'Disponible', 7);
    
-- Libro 8

    -- Insertar "The Age of Spiritual Machines"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(8, '978-0-670-88217-5', 'The Age of Spiritual Machines: When Computers Exceed Human Intelligence',
    'En este libro, Kurzweil presenta su visi n del futuro, donde las m quinas superan la inteligencia humana 
    y transforman radicalmente la sociedad y la vida diaria. Examina el potencial de la inteligencia artificial 
    para mejorar la vida humana y aborda las implicaciones  ticas y filos ficas de esta revoluci n tecnol gica.', 
    NULL, 'Ingl s', 1999, NULL, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_age_spiritual_machines.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 2, 8);

    -- Insertar ejemplares de "The Age of Spiritual Machines"
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (7, 'Estante D1', 'Disponible', 8);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (8, 'Estante D2', 'Disponible', 8);
    
-- Libro 9

    -- Insertar "Transcend: Nine Steps to Living Well Forever"
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    VALUES(9, '978-0-670-03384-3', 'Transcend: Nine Steps to Living Well Forever', 
    'En este libro, Kurzweil y Terry Grossman exploran c mo la biotecnolog a y la 
    nanotecnolog a pueden prolongar la vida humana y mejorar la calidad de vida. 
    Presentan un programa pr ctico en nueve pasos para optimizar la salud y la longevidad.', 
    NULL, 'Ingl s', 2009, NULL, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    v_file := BFILENAME('IMAGES_DIR', 'portada_transcend.jpg');
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO AUTORIAS (orden, idautor, idlibros) 
    VALUES (1, 2, 9);

    -- Insertar ejemplares de "Transcend: Nine Steps to Living Well Forever"
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (9, 'Estante E1', 'Disponible', 9);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (10, 'Estante E2', 'Disponible', 9);

END;


-- APARTADO DE SEGURIDAD

-- Vista de Libros con su Autor Principal

CREATE VIEW VistaLibrosAutorPrincipal AS
SELECT l.titulo, a.nombreautor AS autor_principal
FROM libros l
JOIN autorias au ON l.idlibro = au.idlibros AND au.orden = 1
JOIN autores a ON au.idautor = a.idautor;

-- Vista de Pr stamos Ordenados por Fecha Reciente

CREATE VIEW VistaPrestamosRecientes AS
SELECT p.idprestamos, p.fechaPrestamo, p.fechavencimiento, p.fechadevolucion, u.nombres || ' ' || u.apellidos AS usuario, e.idejemplar, l.titulo
FROM PRESTAMOS p
JOIN usuarios u ON p.cedula = u.cedula
JOIN ejemplares e ON p.idejemplar = e.idejemplar
JOIN libros l ON e.idlibro = l.idlibro
ORDER BY p.fechaPrestamo DESC;


-- Creaci n de Usuarios

-- Usuario 1

CREATE USER jhordy IDENTIFIED BY jhordy;
GRANT CONNECT TO jhordy;
GRANT SELECT ON VistaLibrosAutorPrincipal TO jhordy;

-- Usuario 2

CREATE USER kelvin IDENTIFIED BY kelvin;
GRANT CONNECT TO kelvin;
GRANT SELECT ON VistaPrestamosRecientes TO kelvin;

-- Usuario 3

CREATE USER gatoPipe IDENTIFIED BY gatoPipe;
GRANT CONNECT, RESOURCE TO gatoPipe;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuarios TO gatoPipe;
GRANT SELECT, INSERT, UPDATE, DELETE ON prestamos TO gatoPipe;
GRANT SELECT ON VistaPrestamosRecientes TO gatoPipe;
GRANT SELECT ON VistaLibrosAutorPrincipal TO gatoPipe;

-- Apartado de Verificacion 

-- Primero Conectarse al usuario 1 = jhordy

SELECT * FROM VistaLibrosAutorPrincipal; -- Debe funcionar
SELECT * FROM libros; -- Debe fallar

-- Primero Conectarse al usuario 2 = sarango

CONNECT usuario2/password2;
SELECT * FROM VistaPrestamosRecientes; -- Debe funcionar
SELECT * FROM prestamos; -- Debe fallar

-- Primero Conectarse al usuario 3 = gatoPipe

CONNECT usuario3/password3;
SELECT * FROM VistaPrestamosRecientes; -- Debe funcionar
INSERT INTO prestamos (idprestamos, fechaPrestamo, fechavencimiento, idejemplar, cedula) VALUES (1, SYSDATE, SYSDATE + 7, 1, '1234567890'); -- Debe funcionar -- Verificar sentencia de Insert
UPDATE libros SET titulo = 'Nuevo T tulo' WHERE idlibro = 1; -- Debe fallar