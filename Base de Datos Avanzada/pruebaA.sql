CREATE DATABASE IF NOT EXISTS proglimpiadas;
USE proglimpiadas;

CREATE TABLE CIUDAD (
                        id INT PRIMARY KEY,
                        nombre VARCHAR(100) NOT NULL,
                        countryCode VARCHAR(3) NOT NULL,
                        district VARCHAR(100) NOT NULL,
                        population INT NOT NULL
);

INSERT INTO CIUDAD (id, nombre, countryCode, district, population) VALUES
                                                                       (1, 'Tokyo', 'JPN', 'Kanto', 37400068),
                                                                       (2, 'Osaka', 'JPN', 'Kansai', 19222665),
                                                                       (3, 'Nagoya', 'JPN', 'Chubu', 9104841),
                                                                       (4, 'Yokohama', 'JPN', 'Kanto', 3726167),
                                                                       (5, 'Kobe', 'JPN', 'Kansai', 1537885),
                                                                       (6, 'Fukuoka', 'JPN', 'Kyushu', 1535394),
                                                                       (7, 'Kyoto', 'JPN', 'Kansai', 1474570),
                                                                       (8, 'Sapporo', 'JPN', 'Hokkaido', 1952356),
                                                                       (9, 'Hiroshima', 'JPN', 'Chugoku', 1194000),
                                                                       (10, 'Sendai', 'JPN', 'Tohoku', 1083207),
                                                                       (11, 'Seoul', 'KOR', 'Seoul', 9765114);


