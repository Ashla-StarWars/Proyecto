drop database if exists INVICTUS;
create database INVICTUS;
use INVICTUS;
 
create table VIDEOJUEGO(
	id_videojuego int primary key auto_increment,
    nombre varchar(45),
    desarrolladora varchar (45),
    fecha_salida date,
    descripcion longtext,
    genero varchar (80),
    game_image_path varchar(255)
);

create table TORNEO(
    id_torneo int primary key auto_increment,
    nombre varchar(45),
    fecha_inicio date,
    fecha_final date,
    descripcion longtext,
    id_organizador int,
    id_videojuego int,

    index(id_organizador),
    foreign key(id_videojuego) references VIDEOJUEGO(id_videojuego) ON DELETE CASCADE ON UPDATE CASCADE
);

create table COMUNIDAD(
	id_comunidad int primary key auto_increment,
    nombre varchar(45),
    descripcion longtext
);

create table BAN(
	id_ban int primary key auto_increment,
    fecha_inicio date,
    fecha_final date,
    motivo longtext,
    id_usuario int,
    index(id_usuario)
);

create table USUARIO(
	id_usuario int primary key auto_increment,
    nombre varchar(45),
    apellidos varchar(45),
    nikname varchar(45),
    email varchar(45) unique,
    contrasena varchar(255),
    descripcion longtext,
    id_torneo_org int,
    user_admin boolean,
    id_ban int,
    user_image_path VARCHAR(255),

    FOREIGN KEY (id_torneo_org) REFERENCES TORNEO(id_organizador) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ban) REFERENCES BAN(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);
 
 
create table ADMINISTRAR_BAN(
    id_ban int,
    id_usuario int,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(id_ban) references BAN(id_ban) ON DELETE CASCADE ON UPDATE CASCADE
);
 
create table CREAR_COMUNIDAD(
    id_usuario int,
    id_comunidad int,
    fecha_creacion date,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE, 
    foreign key(id_comunidad) references COMUNIDAD(id_comunidad) ON DELETE CASCADE ON UPDATE CASCADE
);

create table ADMINISTRAR_COMUNIDAD(
    id_comunidad int,
    id_usuario int,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(id_comunidad) references COMUNIDAD(id_comunidad) ON DELETE CASCADE ON UPDATE CASCADE
);
 
create table PARTICIPAR_COMUNIDAD(
    id_usuario int,
    id_comunidad int,
    fecha_union date,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(id_comunidad) references COMUNIDAD(id_comunidad) ON DELETE CASCADE ON UPDATE CASCADE
);
 
create table PARTICIPAR_TORNEO(
	id_usuario int,
    id_torneo int,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(id_torneo) references TORNEO(id_torneo) ON DELETE CASCADE ON UPDATE CASCADE
);
 
create table RESENA(
    fecha_publicacion date,
    descripcion longtext,
    id_usuario int,
    id_videojuego int,

    foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(id_videojuego) references VIDEOJUEGO(id_videojuego) ON DELETE CASCADE ON UPDATE CASCADE
);
 
create table ADMINISTRAR_TORNEO(
   id_usuario int,
   id_torneo int,

   foreign key(id_usuario) references USUARIO(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
   foreign key(id_torneo) references TORNEO(id_torneo) ON DELETE CASCADE ON UPDATE CASCADE
);
 
 
-- INSERTS --
 
-- Inserts for VIDEOJUEGO table
INSERT INTO VIDEOJUEGO (nombre, desarrolladora, fecha_salida, descripcion, genero, game_image_path) VALUES 
('League of Legends', 'Riot Games', '2022-01-01', 'League of Legends es un popular videojuego de estrategia en tiempo real desarrollado y publicado por Riot Games. Desde su lanzamiento en 2009, League of Legends ha sido uno de los juegos más jugados en el mundo, con una comunidad activa y un escenario competitivo profesional. Los jugadores controlan "campeones" con habilidades únicas y compiten en partidas 5v5, con el objetivo de destruir la base enemiga mientras defienden la suya propia en un mapa lleno de objetivos y estrategias.', 'MOBA', '../imagenes/games/lol-game.png'),
('Apex', 'Respawn Entertainment', '2022-02-01', 'Apex Legends es un videojuego de disparos en primera persona gratuito desarrollado por Respawn Entertainment y publicado por Electronic Arts. Lanzado en 2019, el juego se destaca por su acción frenética, mecánicas de movimiento fluidas y personajes únicos llamados "leyendas", cada uno con habilidades especiales. En Apex Legends, los jugadores forman equipos de tres y compiten en partidas Battle Royale en un mapa cambiante, con el objetivo de ser el último equipo en pie.', 'Battle Royale', '../imagenes/games/apex-game.jpg'),
('Valorant', 'Riot Games', '2022-03-01', 'Valorant es un videojuego de disparos táctico en primera persona desarrollado y publicado por Riot Games. Lanzado en 2020, Valorant combina elementos de juegos de disparos tácticos con habilidades únicas de personajes inspiradas en los juegos de tipo MOBA. Los jugadores se dividen en dos equipos y compiten en partidas 5v5, con el objetivo de plantar o desactivar una bomba o protegerla, dependiendo del modo de juego. Valorant se ha convertido en un título popular en el género de los eSports debido a su enfoque en la estrategia y la habilidad individual.', 'First-Person Shooter', '../imagenes/games/valorant-game.jpg'),
('CSGO', 'Valve Corporation', '2022-04-01', 'Counter-Strike: Global Offensive (CS:GO) es un videojuego de disparos en primera persona desarrollado por Valve Corporation. Lanzado en 2012, CS:GO es la cuarta entrega principal de la serie Counter-Strike y sigue siendo uno de los juegos más populares en el género de los eSports. Los jugadores se dividen en dos equipos, terroristas y contraterroristas, y compiten en rondas de juego para completar objetivos como plantar o desactivar bombas, rescatar rehenes o eliminar al equipo enemigo. CS:GO se destaca por su juego táctico, habilidad individual y competitividad.', 'First-Person Shooter', '../imagenes/games/cs2-game.png'),
('CyberPunk 2077', 'CD Projekt', '2022-04-01', 'Cyberpunk 2077 es un videojuego de rol de acción desarrollado y publicado por CD Projekt. Lanzado en 2020, el juego está ambientado en Night City, una metrópolis futurista obsesionada con el poder, la moda y la modificación corporal. Los jugadores asumen el papel de V, un mercenario en busca de un implante único que otorga la inmortalidad. Con una narrativa rica y un mundo abierto lleno de historias secundarias y actividades, Cyberpunk 2077 ofrece a los jugadores una experiencia inmersiva en un futuro distópico.', 'Action RPG', '../imagenes/games/cyberpunk-game.jpg'),
('Fornite', 'Epic Games', '2022-04-01', 'Fortnite es un videojuego de supervivencia y construcción desarrollado y publicado por Epic Games. Lanzado en 2017, el juego presenta un modo de juego cooperativo llamado "Salva el Mundo" y un modo Battle Royale gratuito que ha ganado una inmensa popularidad. En Fortnite Battle Royale, los jugadores compiten en partidas multijugador masivas en un mapa cada vez más pequeño, recolectando recursos, construyendo estructuras y luchando para ser el último en pie. Además de su jugabilidad, Fortnite es conocido por sus eventos en el juego, colaboraciones con otras franquicias y constantes actualizaciones de contenido.', 'Battle Royale', '../imagenes/games/fornite-game.jpg'),
('Robolox', 'Roblox Corporation', '2022-04-01', 'Roblox es una plataforma de creación de juegos y juegos en línea desarrollada y publicada por Roblox Corporation. Lanzado en 2006, Roblox permite a los usuarios crear y jugar una amplia variedad de juegos generados por los propios usuarios. Con una amplia gama de géneros y estilos de juego, Roblox ha ganado popularidad entre una amplia audiencia, especialmente entre los niños y adolescentes. Los jugadores pueden socializar, crear y compartir experiencias de juego únicas en un entorno virtual.', 'MMORPG', '../imagenes/games/robolox-game.jpg'),
('Rust', 'Facepunch Studios', '2022-04-01', 'Rust es un videojuego de supervivencia en línea desarrollado y publicado por Facepunch Studios. Lanzado en 2013, Rust desafía a los jugadores a sobrevivir en un mundo hostil lleno de peligros, como el hambre, la sed, el clima extremo y otros jugadores hostiles. Los jugadores comienzan con pocos recursos y deben recolectar materiales, construir refugios y formar alianzas para prosperar. Rust es conocido por su juego desafiante, su comunidad activa y su constante evolución a través de actualizaciones de contenido.', 'Survival', '../imagenes/games/rust-game.jpg'),
('Warzone', 'Infinity Ward', '2022-04-01', 'Call of Duty: Warzone es un videojuego de disparos en línea gratuito desarrollado por Infinity Ward y publicado por Activision. Lanzado en 2020, Warzone es una extensión independiente de Call of Duty: Modern Warfare y presenta un modo de juego Battle Royale y un modo de juego Plunder. En Warzone, los jugadores compiten en partidas masivas en un mapa enorme, recolectando armas, dinero y suministros mientras luchan por ser el último equipo o jugador en pie. Warzone ha sido elogiado por su acción intensa, su mecánica de juego sólida y sus constantes actualizaciones de contenido.', 'Battle Royale','../imagenes/games/warzone-game.jpg'),
('Dota 2', 'Valve Corporation', '2013-07-09', 'Dota 2 es un videojuego perteneciente al género de estrategia en tiempo real, también conocido como MOBA (Multiplayer Online Battle Arena), desarrollado y publicado por Valve Corporation.', 'MOBA', '../imagenes/games/dota2-game.png'),
('Overwatch 2', 'Blizzard Entertainment', 'TBD', 'Overwatch 2 es un próximo videojuego de disparos en primera persona multijugador desarrollado y publicado por Blizzard Entertainment.', 'First-Person Shooter', '../imagenes/games/ow2-game.png'),
('Grand Theft Auto V', 'Rockstar Games', '2013-09-17', 'Grand Theft Auto V es un videojuego de acción-aventura de mundo abierto desarrollado por Rockstar North y publicado por Rockstar Games.', 'Action-Adventure', '../imagenes/games/gtav-game.jpg'),
('The Last of Us', 'Naughty Dog', '2013-06-14', 'The Last of Us es un videojuego de acción-aventura y horror de supervivencia desarrollado por Naughty Dog y publicado por Sony Computer Entertainment.', 'Action-Adventure', '../imagenes/games/lastofus-game.jpg'),
('Spider-Man', 'Insomniac Games', '2018-09-07', 'Spider-Man es un videojuego de acción y aventura basado en el superhéroe de Marvel Comics Spider-Man, desarrollado por Insomniac Games y publicado por Sony Interactive Entertainment.', 'Action-Adventure', '../imagenes/games/spiderman-game.jpg'),
('Star Wars: Jedi Survivor', 'Lucasfilm Ltd.', 'TBD', 'Star Wars: Jedi Survivor es un próximo videojuego de acción y aventura que te coloca en el papel de un Jedi en un universo de Star Wars post-apocalíptico. Sobrevive en un mundo devastado por la guerra mientras luchas contra enemigos y te embarcas en una búsqueda para restaurar la paz en la galaxia. Utiliza la Fuerza y tus habilidades de combate con sable de luz para enfrentarte a desafiantes adversidades y descubrir el destino de los Jedi.', 'Acción y Aventura', '../imagenes/games/survivor-game.jpg'),
('Alone in the Dark', 'Atari', '2008-06-20', 'Alone in the Dark es un clásico videojuego de terror y supervivencia desarrollado por Infogrames (ahora Atari). Lanzado en 1992, es considerado uno de los pioneros del género survival horror. El juego te sumerge en una atmósfera oscura y aterradora, enfrentándote a criaturas monstruosas y resolviendo puzzles mientras exploras entornos ominosos. Con una jugabilidad innovadora para su época y una narrativa envolvente, Alone in the Dark dejó una marca indeleble en la historia de los videojuegos de terror.', 'Survival Horror', '../imagenes/games/alone-game.jpg'),
('God of War: Ragnarok', 'Santa Monica Studio', 'TBD', 'God of War: Ragnarok es un próximo videojuego de acción y aventura desarrollado por Santa Monica Studio y publicado por Sony Interactive Entertainment.', 'Action-Adventure', '../imagenes/games/gowragnarok-game.jpg'),
('Devour', 'Straight Back Games', '2020-01-28', 'Devour es un videojuego de terror de supervivencia cooperativo desarrollado por Straight Back Games.', 'Survival Horror', '../imagenes/games/devour-game.jpg'),
('Palworld', 'Pocketpair', 'TBD', 'Palworld es un próximo videojuego de aventuras y simulación desarrollado por Pocketpair.', 'Simulation', '../imagenes/games/palworld-game.jpg'),
('Diablo IV', 'Blizzard Entertainment', 'TBD', 'Diablo IV es un próximo videojuego de rol de acción desarrollado por Blizzard Entertainment.', 'Action RPG', '../imagenes/games/diablo4-game.png'),
('Horizon Forbidden West', 'Guerrilla Games', 'TBD', 'Horizon Forbidden West es un próximo videojuego de rol de acción y aventura desarrollado por Guerrilla Games.', 'Action-Adventure', '../imagenes/games/horizon-game.jpg'),
('The Finals', 'Unknown', 'TBD', 'Descripción del juego The Finals', 'Sports', '../imagenes/games/thefinals-game.jpg'),
('Among Us', 'InnerSloth', '2018-06-15', 'Among Us es un videojuego de fiesta en línea multijugador desarrollado y publicado por InnerSloth.', 'Party', '../imagenes/games/amongus-game.jpg'),
('The Witcher 3: Wild Hunt', 'CD Projekt', '2015-05-19', 'The Witcher 3: Wild Hunt es un videojuego de rol de acción desarrollado por CD Projekt Red.', 'Action RPG', '../imagenes/games/witcher-game.jpg'),
('Rocket League', 'Psyonix', '2015-07-07', 'Rocket League es un videojuego de deportes desarrollado y publicado por Psyonix.', 'Sports', '../imagenes/games/rocketleague-game.jpg');

 
-- Inserts for TORNEO table
INSERT INTO TORNEO (id_torneo, nombre, fecha_inicio, fecha_final, descripcion, id_organizador, id_videojuego) VALUES 
(1, 'Tournament1', '2022-03-01', '2022-03-10', 'Description for Tournament1',1, 1),
(2, 'Tournament2', '2022-04-01', '2022-04-15', 'Description for Tournament2',2, 2),
(3, 'Tournament3', '2022-05-01', '2022-05-10', 'Description for Tournament3',3, 3),
(4, 'Tournament4', '2022-06-01', '2022-06-15', 'Description for Tournament4',4, 4),
(5, 'Tournament5', '2022-07-01', '2022-07-10', 'Description for Tournament5',5, 5);
 
-- Inserts for BAN table
INSERT INTO BAN (id_ban, fecha_inicio, fecha_final, motivo, id_usuario) VALUES 
(1, '2022-01-01', '2022-02-01', 'aggression',5),
(2, '2022-03-01', '2022-04-01', 'Toxi',1),
(3, '2022-05-01', '2022-06-01', 'Using Script',5),
(4, '2022-07-01', '2022-08-01', 'Bullying',1),
(5, '2022-09-01', '2022-10-01', 'Racist',3);
 
-- Inserts for COMUNIDAD table
INSERT INTO COMUNIDAD (id_comunidad, nombre, descripcion) VALUES 
(1, 'Community1', 'Description for Community1'),
(2, 'Community2', 'Description for Community2'),
(3, 'Community3', 'Description for Community3'),
(4, 'Community4', 'Description for Community4'),
(5, 'Community5', 'Description for Community5');

-- Inserts for USUARIO table
INSERT INTO USUARIO (nombre, apellidos, nikname, email, contrasena, descripcion, user_admin, user_image_path ) VALUES 
('Enric', 'Domènech Aisa', 'Ashla_StarWars', 'enric.160493@gmail.com', '$2y$10$pKwPDp31bTdSh229H4hP7eyuV.9xbrmSgZjd62dPbMnI9PqHP3F0W', 'Soy un verdadero apasionado de los videojuegos, siempre listo para sumergirme en nuevas aventuras virtuales y compartir mi entusiasmo con otros jugadores en la comunidad en línea.', true, '../imagenes/src/dev-apex.jpg'),
('Enric', 'Domènech Aisa', 'Ashla_StarWars', 'enric.160493@gmail.es', '$2y$10$pKwPDp31bTdSh229H4hP7eyuV.9xbrmSgZjd62dPbMnI9PqHP3F0W', 'Soy un verdadero apasionado de los videojuegos, siempre listo para sumergirme en nuevas aventuras virtuales y compartir mi entusiasmo con otros jugadores en la comunidad en línea.', false, '../imagenes/src/usuario.png'),
('Martina', 'Gil Cervilla', 'martinagilcervilla', 'martinagilcervilla@gmail.es', '$2y$10$CrWZublVEmjkvNIIrYuUoe/.UUlM1u/hWaWTYYBpuwDFgACzpWT4S', 'Soy un verdadero apasionado de los videojuegos, siempre listo para sumergirme en nuevas aventuras virtuales y compartir mi entusiasmo con otros jugadores en la comunidad en línea.', false, '../imagenes/src/dev.png'),
('Martina', 'Gil Cervilla', 'martinagilcervilla', 'martinagilcervilla@gmail.com', '$2y$10$CrWZublVEmjkvNIIrYuUoe/.UUlM1u/hWaWTYYBpuwDFgACzpWT4S', 'Soy un verdadero apasionado de los videojuegos, siempre listo para sumergirme en nuevas aventuras virtuales y compartir mi entusiasmo con otros jugadores en la comunidad en línea.', true, '../imagenes/src/dev.png');

-- Inserts for ADMINISTRAR_BAN table
INSERT INTO ADMINISTRAR_BAN (id_ban, id_usuario) VALUES (1,1), (2,2), (3,1), (4,2), (5,1);

-- Inserts for CREAR_COMUNIDAD table
INSERT INTO CREAR_COMUNIDAD (id_usuario, id_comunidad, fecha_creacion) VALUES 
(1, 1, '2022-01-01'),
(2, 2, '2022-02-01'),
(1, 3, '2022-03-01'),
(2, 4, '2022-04-01'),
(1, 5, '2022-05-01');

-- Inserts for ADMINISTRAR_COMUNIDAD table
INSERT INTO ADMINISTRAR_COMUNIDAD (id_comunidad, id_usuario) VALUES (1,1), (2,1), (3,2), (4,2), (5,2);

-- Inserts for PARTICIPAR_COMUNIDAD table
INSERT INTO PARTICIPAR_COMUNIDAD (id_usuario, id_comunidad, fecha_union) VALUES 
(1,1, '2022-01-01'),
(2,2, '2022-02-01'),
(1,3, '2022-03-01'),
(2,4, '2022-04-01'),
(1,5, '2022-05-01');

-- Inserts for PARTICIPAR_TORNEO table
INSERT INTO PARTICIPAR_TORNEO (id_usuario, id_torneo) VALUES (1,1), (1,2), (2,3), (2,4), (1,5);

-- Inserts for RESENA table
INSERT INTO RESENA (fecha_publicacion, descripcion, id_usuario, id_videojuego) VALUES 
('2022-01-01', 'Review for League of Legends', 1, 1),
('2022-02-01', 'Review for Apex', 2, 2),
('2022-03-01', 'Review for Valorant', 1, 3),
('2022-04-01', 'Review for CSGO', 2, 4),
('2022-04-01', 'Review for CS2', 1, 4),
('2022-05-01', 'Review for Minecraft', 2, 5);

-- Inserts for ADMINISTRAR_TORNEO table
INSERT INTO ADMINISTRAR_TORNEO (id_usuario, id_torneo) VALUES (1,1), (1,2), (2,3), (2,4), (1,5);

SELECT * FROM USUARIO;
SELECT * FROM VIDEOJUEGO;

/*
DELETE FROM videojuego where id_videojuego=1;
DELETE FROM videojuego where id_videojuego=2;
DELETE FROM videojuego where id_videojuego=3;
DELETE FROM videojuego where id_videojuego=4;
DELETE FROM videojuego where id_videojuego=5;
DELETE FROM videojuego where id_videojuego=6;
DELETE FROM videojuego where id_videojuego=7;
DELETE FROM videojuego where id_videojuego=8;
DELETE FROM videojuego where id_videojuego=9;
DELETE FROM videojuego where id_videojuego=10;
DELETE FROM videojuego where id_videojuego=11;
*/