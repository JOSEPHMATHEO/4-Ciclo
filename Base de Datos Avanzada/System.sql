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
 
ALTER TABLE usuarios ADD CONSTRAINT chk_email CHECK (email LIKE '%__@__%' );

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
    INSERT INTO autores (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES (1, 'Gabriel Garc a M rquez', 'CB', NULL, 'Gabriel Garc a M rquez naci  el 6 de marzo de 1927 en Aracataca, Colombia. Es considerado uno de los escritores m s importantes del siglo XX y uno de los principales exponentes del realismo m gico. Garc a M rquez es conocido por su estilo narrativo  nico y su capacidad para combinar lo real y lo fant stico en sus obras. Entre sus obras m s destacadas se encuentran "Cien a os de soledad", "El amor en los tiempos del c lera" y "Cr nica de una muerte anunciada". Gan  el Premio Nobel de Literatura en 1982 por su contribuci n a la literatura mundial.', 25);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 1, 1);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (1, 'Estante A1', 'D', 1);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (2, 'Estante A1', 'D', 1);
END;

-- LIBRO 2
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(2, '9781501121107', 'It', '"It" es una novela de terror que sigue 
    a un grupo de ni os que se enfrentan a una entidad maligna que adopta la 
    forma de sus peores miedos. Treinta a os despu s, los ahora adultos deben 
    enfrentarse nuevamente a la criatura cuando regresa a su ciudad natal.', 
    1138, 'EN', 1986, 1, EMPTY_BLOB(), 'AC002', 1)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_it.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Insertar autor
    INSERT INTO AUTORES (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES (2, 'Stephen King', 'EU', NULL, 'Stephen King naci  el 21 de 
    septiembre de 1947 en Portland, Maine, Estados Unidos. Es conocido como uno 
    de los autores m s prol ficos y exitosos en el g nero del terror. King ha 
    escrito numerosas novelas superventas, muchas de las cuales han sido 
    adaptadas al cine y la televisi n. Sus obras a menudo exploran temas oscuros 
    y perturbadores, y son apreciadas por su narrativa envolvente y sus 
    personajes memorables.', 60);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (2, 2, 2);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (3, 'Estante A2', 'D', 2);
    INSERT INTO EJEMPLARES (idejemplar, ubicacion, status, idlibro) 
    VALUES (4, 'Estante A2', 'D', 2);
END;

-- LIBRO 3
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(3, '9780307345003', 'The Shining', '"The Shining" es una novela de terror 
    psicol gico que sigue a Jack Torrance, un escritor alcoh lico, y su familia 
    mientras se convierten en los cuidadores de un hotel aislado durante el invierno. 
    A medida que la nieve bloquea las salidas, los oscuros secretos del hotel comienzan 
    a afectar la cordura de Jack.', 
    447, 'EN', 1977, 1, EMPTY_BLOB(), 'AC001', 3)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_the_shining.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 2, 3);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (5, 'Estante A2', 'D', 3);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (6, 'Estante A2', 'D', 3);
END;

-- LIBRO 4
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(4, '9781501107852', 'Misery', '"Misery" es un thriller psicol gico que 
    sigue a Paul Sheldon, un escritor famoso, quien es rescatado por una fan obsesiva 
    despu s de un accidente automovil stico. Pronto descubre que su salvadora no 
    tiene intenciones de dejarlo ir y lo obliga a escribir una nueva novela para 
    satisfacer sus deseos retorcidos.', 
    369, 'EN', 1987, 1, EMPTY_BLOB(), 'AC002', 3)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_misery.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros)
    VALUES (1, 2, 4);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (7, 'Estante A3', 'D', 4);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (8, 'Estante A3', 'D', 4);
END;

-- LIBRO 5
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(5, '9780385121004', 'Pet Sematary', '"Pet Sematary" cuenta la historia 
    de Louis Creed, un m dico que se muda con su familia a una casa cerca de un 
    cementerio de animales que tiene poderes sobrenaturales. Cuando una tragedia 
    golpea a la familia, Louis se adentra en un territorio oscuro y peligroso al 
    intentar alterar el curso natural de la muerte.', 
    562, 'EN', 1983, 1, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_misery.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 2, 5);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (9, 'Estante A3', 'D', 5);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (10, 'Estante A3', 'D', 5);
END;

-- LIBRO 6
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(6, '9780385121684', 'The Stand', '"The Stand" es una novela  pica que 
    sigue a un grupo de supervivientes despu s de que una plaga apocal ptica ha 
    devastado la poblaci n mundial. La narrativa se centra en las luchas de poder 
    entre el bien y el mal mientras los sobrevivientes intentan reconstruir la 
    sociedad.', 
    1152, 'EN', 1978, 1, EMPTY_BLOB(), 'AC002', 2)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_misery.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 2, 6);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (11, 'Estante A1', 'D', 6);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (12, 'Estante A1', 'D', 6);
END;

-- LIBRO 7
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(7, '9788466321676', 'El amor en los tiempos del c lera', 
    'Esta novela cuenta la historia de amor entre Fermina Daza y Florentino Ariza,
    quienes se enamoran en su juventud pero se separan por circunstancias de la vida.
    A lo largo de d cadas, Florentino espera pacientemente para volver a conquistar 
    el coraz n de Fermina.', 
    496, 'ES', 1985, 1, EMPTY_BLOB(), 'AC002', 4)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_amor_tiempos_colera.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 1, 7);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (13, 'Estante A2', 'D', 7);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (14, 'Estante A2', 'D', 7);
END;

-- LIBRO 8
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(8, '9788408093589', 'Cr nica de una muerte anunciada', 
    'Esta novela relata los eventos que llevan a la muerte de Santiago Nasar,
    un joven cuya muerte estaba anunciada pero nadie hizo nada para evitarla. 
    A trav s de m ltiples narradores, se revelan los secretos y las motivaciones 
    detr s de este crimen.', 
    137, 'ES', 1981, 1, EMPTY_BLOB(), 'AC002', 4)
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_cronica_muerte_anunciada.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 1, 8);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (15, 'Estante A2', 'D', 8);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (16, 'Estante A2', 'D', 8);
END;

-- LIBRO 9
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(9, '9788437606021', 'La hojarasca', 'Esta novela marca el 
    debut literario de Garc a M rquez. Narra la historia de un m dico que 
    regresa al pueblo donde creci  para atender al funeral de un viejo amigo. 
    A trav s de los recuerdos y testimonios de los habitantes del pueblo, 
    se revelan los eventos tr gicos que llevaron a la muerte del amigo.', 
    74, 'ES', 1955, 1, EMPTY_BLOB(), 'AC002', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_hojarasca.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 1, 9);

    -- Insertar ejemplares
    INSERT INTO bib_riofrio_santiago.ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (17, 'Estante A3', 'D', 9);
    INSERT INTO bib_riofrio_santiago.ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (18, 'Estante A3', 'D', 9);
END;

-- LIBRO 10
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(10, '9788483067179', 'La singularidad est  cerca: Cuando los humanos 
    transcendamos la biolog a', 'En este libro, Ray Kurzweil explora el concepto de 
    la singularidad tecnol gica, un punto futuro en el que la inteligencia artificial 
    y otras tecnolog as alcanzar n un nivel que transformar  radicalmente la sociedad 
    y la condici n humana.', 
    680, 'ES', 2006, 1, EMPTY_BLOB(), 'AC002', 2)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_singularidad_esta_cerca.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);
    
    -- Insertar autor
    INSERT INTO autores (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES(3, 'Ray Kurzweil', 'US', EMPTY_BLOB(), 'Ray Kurzweil naci  el 
    12 de febrero de 1948 en Queens, Nueva York. Es un inventor, futurista, y empresario 
    estadounidense. Kurzweil es conocido por sus contribuciones en el campo de la 
    inteligencia artificial, la biotecnolog a y la futur stica. Ha fundado varias 
    empresas en  reas como el reconocimiento de voz y la s ntesis de voz, y ha recibido 
    numerosos premios y honores por sus innovaciones tecnol gicas. Es autor de varios 
    libros que exploran temas como el futuro de la tecnolog a, la singularidad tecnol gica 
    y la prolongaci n de la vida.', 9);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 10);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro)
    VALUES (19, 'Estante A3', 'D', 10);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (20, 'Estante A3', 'D', 10);
END;

-- LIBRO 11
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(11, '9788415751480', 'C mo crear una mente: El secreto del pensamiento humano',
    'En este libro, Kurzweil explora el funcionamiento del cerebro humano y propone un modelo 
    de c mo podr amos recrear la inteligencia artificial para simular el pensamiento humano. 
    Ofrece una visi n fascinante de la mente y la tecnolog a.', 
    480, 'ES', 2012, 1, EMPTY_BLOB(), 'AC002', 4)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_como_crear_mente.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 11);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (21, 'Estante A3', 'D', 11);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro)
    VALUES (22, 'Estante A3', 'D', 11);
END;

-- LIBRO 12
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(12, '9788449305308', 'La era de las m quinas espirituales', 'En este libro, 
    Kurzweil explora el futuro de la inteligencia artificial y c mo cambiar  la sociedad 
    y la naturaleza misma de lo que significa ser humano. Proporciona una visi n provocativa 
    y optimista del papel de la tecnolog a en la evoluci n de la humanidad.', 
    432, 'ES', 1999, 1, EMPTY_BLOB(), 'AC002', 5)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_era_maquinas_espirituales.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 12);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (23, 'Estante A4', 'D', 12);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro)
    VALUES (24, 'Estante A4', 'D', 12);
END;

-- LIBRO 13
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(13, '9788449303014', 'Una breve historia del tiempo','En este libro, 
    Hawking explora los conceptos fundamentales del universo, desde el Big Bang 
    hasta los agujeros negros, la relatividad general y la mec nica cu ntica, todo 
    explicado de manera accesible para el lector no especializado. Es un viaje 
    fascinante a trav s de los misterios del cosmos.', 
    256, 'ES', 1988, 1, EMPTY_BLOB(), 'AC001', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_breve_historia_tiempo.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);
    
    -- Insertar autor
    INSERT INTO autores (idautor, nombreautor, pais, foto, bio, numlibros) 
    VALUES (4, 'Stephen William Hawking', 'RU', NULL, 'Stephen Hawking naci  el 8 de enero de 
    1942 en Oxford, Inglaterra, y falleci  el 14 de marzo de 2018 en Cambridge, Reino Unido. 
    Fue un f sico te rico, cosm logo y autor prol fico que realiz  contribuciones significativas 
    a nuestra comprensi n del universo, especialmente en relaci n con los agujeros negros y la 
    relatividad general. A lo largo de su vida, Hawking desafi  las limitaciones impuestas por 
    su enfermedad degenerativa, la esclerosis lateral amiotr fica (ELA), para continuar su investigaci n 
    y comunicar sus ideas al p blico en general.', 65);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 13);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (25, 'Estante A4', 'D', 13);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (26, 'Estante A4', 'D', 13);
END;

-- LIBRO 14
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(14, '9788449306701', 'El universo en una c scara de nuez', 
    'En este libro, Hawking explora las teor as m s avanzadas sobre el origen y 
    el destino del universo, desde la teor a de cuerdas hasta la f sica de los 
    agujeros negros y los viajes en el tiempo. Con un estilo claro y ameno, Hawking 
    ofrece una visi n  nica del cosmos.', 
    272, 'ES', 2001, 1, EMPTY_BLOB(), 'AC001', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_universo_cascara_nuez.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 14);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (27, 'Estante A1', 'D', 14);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (28, 'Estante A1', 'D', 14);
END;

-- LIBRO 15
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    IINSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(15, '9788449335290', 'Breves respuestas a las grandes preguntas', 
    'En este libro p stumo, Hawking aborda algunas de las preguntas m s profundas 
    y fundamentales sobre el universo y la humanidad. Desde la existencia de Dios 
    hasta la posibilidad de vida extraterrestre, Hawking ofrece sus reflexiones 
    finales sobre el significado de la vida y el cosmos.', 
    256, 'ES', 2018, 1, EMPTY_BLOB(), 'AC001', 2)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_breves_respuestas_grandes_preguntas.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 15);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (29, 'Estante A2', 'D', 15);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (30, 'Estante A2', 'D', 15);
END;

-- LIBRO 16
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(16, '9788449326220', 'El gran dise o', 
    'En este libro, Hawking y Leonard Mlodinow exploran las ideas m s recientes 
    en f sica te rica, incluida la teor a de cuerdas y la teor a M, para explicar 
    c mo podr a haber surgido el universo y si realmente necesitamos un creador 
    divino para entenderlo.', 
    208, 'ES', 2010, 1, EMPTY_BLOB(), 'AC001', 2)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_gran_disenio.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 16);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (31, 'Estante A2', 'D', 16);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (32, 'Estante A2', 'D', 16);
END;

-- LIBRO 17
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(17, '9788449323052', 'La teor a del todo: El origen y el destino del universo', 
    'En este libro, Hawking ofrece una visi n integral de las teor as que podr an 
    unificar las leyes de la f sica, desde la relatividad general de Einstein hasta 
    la mec nica cu ntica, y c mo estas teor as pueden explicar la naturaleza del 
    universo.', 
    288, 'ES', 2002, 1, EMPTY_BLOB(), 'AC001', 3)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_teoria_todo.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 17);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (33, 'Estante A2', 'D', 17);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (34, 'Estante A2', 'D', 17);
END;

-- LIBRO 18
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(18, '9788449300603', 'Historia del tiempo: Del big bang a los agujeros negros', 
    'Esta edici n revisada y actualizada de "Una breve historia del tiempo" ofrece 
    una visi n actualizada de los avances m s recientes en la cosmolog a y la f sica 
    te rica, desde la teor a del caos hasta los  ltimos descubrimientos sobre agujeros 
    negros y la naturaleza del tiempo.', 
    256, 'ES', 1996, 1, EMPTY_BLOB(), 'AC001', 3)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_historia_tiempo.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 4, 18);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (35, 'Estante A3', 'D', 18);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (36, 'Estante A3', 'D', 18);
END;

-- LIBRO 19
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(19, '9780670882175', 'The Age of Spiritual Machines: When Computers Exceed Human Intelligence', 
    'En este libro, Kurzweil presenta su visi n del futuro, donde las m quinas superan 
    la inteligencia humana y transforman radicalmente la sociedad y la vida diaria. 
    Examina el potencial de la inteligencia artificial para mejorar la vida humana 
    y aborda las implicaciones  ticas y filos ficas de esta revoluci n tecnol gica.', 
    388, 'EN', 1999, 1, EMPTY_BLOB(), 'AC003', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_age_spiritual_machines.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros)
    VALUES (1, 3, 19);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (37, 'Estante A3', 'D', 19);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro)
    VALUES (38, 'Estante A3', 'D', 19);
END;

-- LIBRO 20
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(20, '9780670033843', 'Transcend: Nine Steps to Living Well Forever', 
    'En este libro, Kurzweil y Terry Grossman exploran c mo la biotecnolog a y la 
    nanotecnolog a pueden prolongar la vida humana y mejorar la calidad de vida. 
    Presentan un programa pr ctico en nueve pasos para optimizar la salud y la 
    longevidad.', 
    480, 'EN', 2009, 1, EMPTY_BLOB(), 'AC003', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_transcend.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 20);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (39, 'Estante A4', 'D', 20);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (40, 'Estante A4', 'D', 20);
END;

-- LIBRO 21
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(21, '9780451210845', 'The Dark Tower: The Gunslinger', 
    'En un mundo alternativo, Roland Deschain es el  ltimo pistolero que busca la 
    Torre Oscura, un edificio m tico que se dice que es el punto de uni n del 
    universo. El primer libro de la serie sigue a Roland mientras persigue al 
    Hombre de Negro a trav s de un paisaje desolado', 
    224, 'EN', 1982, 1, EMPTY_BLOB(), 'AC002', 2)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_dark_tower.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 2, 21);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (41, 'Estante A5', 'D', 21);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (42, 'Estante A5', 'D', 21);
END;

-- LIBRO 22
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
   INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(22, '9780060882860', 'El oto o del patriarca', 
    'Esta novela narra la vida y el declive de un dictador envejecido que ha gobernado 
    su pa s durante d cadas. La historia explora los temas de poder absoluto y la 
    corrupci n, con un estilo narrativo caracter stico de Garc a M rquez que mezcla 
    realismo y fantas a.', 
    255, 'ES', 1975, 1, EMPTY_BLOB(), 'AC002', 4)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_otonio_patriarca.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 1, 22);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (43, 'Estante A5', 'D', 22);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (44, 'Estante A5', 'D', 22);
END;

-- LIBRO 23
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(23, '9780452285912', 'Fantastic Voyage: Live Long Enough to Live Forever', 
    'Kurzweil y el m dico Terry Grossman presentan una gu a sobre c mo mantener y 
    mejorar la salud con la esperanza de que los avances futuros en medicina y 
    biotecnolog a permitan una vida significativamente m s larga, o incluso inmortalidad. 
    El libro cubre una variedad de temas desde la nutrici n hasta las terapias avanzadas.', 
    464, 'EN', 2004, 1, EMPTY_BLOB(), 'AC003', 2)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_fantastic_votage.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 23);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (45, 'Estante A5', 'D', 23);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (46, 'Estante A5', 'D', 23);
END;

-- LIBRO 24
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(24, '9781627799241', 'The Singularity Is Nearer', 
    'En este seguimiento de "The Singularity Is Near", Kurzweil actualiza su visi n 
    de c mo la tecnolog a est  acelerando hacia la singularidad, el punto en el 
    que la inteligencia artificial supera a la inteligencia humana y transforma 
    la civilizaci n.', 
    352, 'EN', 2023, 1, EMPTY_BLOB(), 'AC003', 1)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_singularity_nearer.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 3, 24);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (47, 'Estante A5', 'D', 24);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (48, 'Estante A5', 'D', 24);
END;

-- LIBRO 25
DECLARE
    v_portada BLOB;
    v_file BFILE;
BEGIN
    -- Inserci n de un libro
    INSERT INTO libros (idlibro, isbn, titulo, sinopsis, numpaginas, idioma, anio, nroedicion, imgportada, codarea, idedt)
    
    VALUES(25, '9780385343324', 'Carrie', '"Carrie" es una novela de terror y drama 
    sobrenatural que sigue a Carrie White, una adolescente t mida y marginada que 
    desarrolla poderes telequin ticos. Despu s de a os de abuso por parte de su 
    madre fan tica religiosa y el acoso de sus compa eros de clase, Carrie finalmente 
    estalla en una violenta venganza durante el baile de graduaci n.', 
    199, 'EN', 1974, 1, EMPTY_BLOB(), 'AC002', 3)
    
    RETURNING imgportada INTO v_portada;

    -- Obtener ruta del archivo
    v_file := BFILENAME('IMAGES_DIR', 'portada_carrie.jpg');

    -- Lectura de imagen desde el sistema de archivos y almacenarla en el BLOB
    DBMS_LOB.OPEN(v_file, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADFROMFILE(v_portada, v_file, DBMS_LOB.GETLENGTH(v_file));
    DBMS_LOB.CLOSE(v_file);

    -- Relacionar autor con el libro
    INSERT INTO autorias (orden, idautor, idlibros) 
    VALUES (1, 2, 25);

    -- Insertar ejemplares
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (49, 'Estante A5', 'D', 25);
    INSERT INTO ejemplares (idejemplar, ubicacion, status, idlibro) 
    VALUES (50, 'Estante A5', 'D', 25);
END;

-- APARTADO DE SEGURIDAD

-- Vista de Libros con su Autor Principal

CREATE VIEW VistaLibrosAutorPrincipal AS
SELECT l.titulo, a.nombreautor AS autor_principal
FROM libros l
JOIN autorias au ON l.idlibro = au.idlibros AND au.orden = 1
JOIN autores a ON au.idautor = a.idautor;

commit;

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
GRANT SELECT ON VistaLibrosAutorPrincipal TO jhordy;
commit;

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
