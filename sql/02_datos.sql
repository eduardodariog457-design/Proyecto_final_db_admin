insert into genero (nombre, descripcion) values 
   ('Pop',         'Genero musical nacido a finales de los años 50 que busca llegar a una gran audiencia con canciones directas, melodías pegadizas y un sonido muy comercial'),
    ('Rock',        'El rock es un amplio género de música popular que nació en Estados Unidos en los años 50. Viene del rock and roll, que mezcló el rhythm and blues con la música country. Usa mucho la guitarra eléctrica, la batería y el bajo'),
    ('Reggaeton',   'Es un popular género de música bailable. Nació a principios de los años 90 combinando el reggae en español, el dancehall de Jamaica y el hip-hop de Estados Unidos. Se originó principalmente entre Panamá y Puerto Rico'),
    ('Jazz',        'género musical originado a fines del siglo XIX y principios del siglo XX en Nueva Orleans, Estados Unidos'),
    ('Electrónica', 'género amplio que usa instrumentos musicales electrónicos, computadoras y tecnología digital para crear sonidos, ritmos y melodías');

insert into artista (nombre_artistico, pais_origen, fecha_debut, id_genero) values
    ('Bad Bunny',    'Puerto Rico',    '2016-01-01', 3),
    ('Michael Jackson', 'Estados Unidos', '1971-10-07', 1),
    ('Daft Punk',    'Francia',        '1993-01-01', 5),
    ('Miles Davis',  'Estados Unidos', '1944-01-01', 4);

insert into cancion (titulo, duracion_seg, id_artista, id_genero) values
    ('Moscow Mule',      196, 1, 3),
    ('Tití Me Preguntó', 238, 1, 3),
    ('Remember The Time', 200, 2, 1),
    ('Dirty Diana',    202, 2, 1),
    ('Get Lucky',        248, 3, 5),
    ('Instant Crush',    337, 3, 5),
    ('So What',          562, 4, 4),
    ('Blue in Green',    337, 4, 4);

insert into playlist (nombre, es_publica) values
    ('Mis favoritas',      TRUE),
    ('Para el gym',        TRUE),
    ('Clásicos del Jazz',  FALSE),
    ('Viaje en carretera', TRUE);

insert into cancion_playlist (id_cancion, id_playlist, posicion) values
    (1, 1, 1), (3, 1, 2), (5, 1, 3),
    (1, 2, 1), (2, 2, 2), (3, 2, 3),
    (7, 3, 1), (8, 3, 2),
    (3, 4, 1), (5, 4, 2), (6, 4, 3);

