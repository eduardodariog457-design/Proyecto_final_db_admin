select c.titulo,
       a.nombre_artistico,
       g.nombre as genero,
       c.duracion_seg
from cancion c
join artista a on a.id_artista = c.id_artista
join genero  g on g.id_genero  = c.id_genero
order by a.nombre_artistico, c.titulo;

select p.nombre as playlist,
       cp.posicion,
       c.titulo,
       a.nombre_artistico
from cancion_playlist cp
join playlist p on p.id_playlist = cp.id_playlist
join cancion  c on c.id_cancion  = cp.id_cancion
join artista  a on a.id_artista  = c.id_artista
where p.nombre = 'Mis favoritas'
order by cp.posicion;

select a.nombre_artistico,
       count(c.id_cancion)      as total_canciones,
       sum(c.duracion_seg)      as duracion_total_seg
from artista a
left join cancion c on c.id_artista = a.id_artista
group by a.nombre_artistico
order by total_canciones desc;

select p.nombre,
       p.fecha_creacion,
       count(cp.id_cancion) as num_canciones
from playlist p
left join cancion_playlist cp on cp.id_playlist = p.id_playlist
where p.es_publica = true
group by p.id_playlist, p.nombre, p.fecha_creacion
order by num_canciones desc;

select g.nombre as genero,
       count(c.id_cancion) as total_canciones
from genero g
left join cancion c on c.id_genero = g.id_genero
group by g.nombre
order by total_canciones desc;

select c.titulo, count(cp.id_playlist) as num_playlists
from cancion c
join cancion_playlist cp on cp.id_cancion = c.id_cancion
group by c.titulo
having count(cp.id_playlist) > 1
order by num_playlists desc;

