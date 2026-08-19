\set ON_ERROR_STOP on
set search_path to streaming;

-- Busca artistas que no tienen país de origen o fecha de debut registrada
select id_artista, nombre_artistico, pais_origen, fecha_debut
from artista
where pais_origen is null
   or fecha_debut is null;

-- Detecta géneros duplicados ignorando espacios y diferencias entre mayúsculas y minúsculas
select lower(trim(nombre)) as nombre_normalizado, count(*) as repeticiones
from genero
group by lower(trim(nombre))
having count(*) > 1;

-- Detecta canciones repetidas con el mismo título y artista
select titulo, id_artista, count(*) as repeticiones
from cancion
group by titulo, id_artista
having count(*) > 1;

-- Busca canciones con una duración fuera del rango permitido
select id_cancion, titulo, duracion_seg
from cancion
where duracion_seg < 30
   or duracion_seg > 1800;

-- Busca artistas con una fecha de debut posterior a la fecha actual
select id_artista, nombre_artistico, fecha_debut
from artista
where fecha_debut > current_date;

-- Busca canciones cuyo género es diferente al género asignado a su artista
select
    c.id_cancion,
    c.titulo,
    a.nombre_artistico,
    g_cancion.nombre  as genero_cancion,
    g_artista.nombre  as genero_artista
from cancion c
join artista a        on a.id_artista = c.id_artista
join genero  g_cancion on g_cancion.id_genero = c.id_genero
join genero  g_artista on g_artista.id_genero = a.id_genero
where c.id_genero != a.id_genero;

-- Detecta posiciones repetidas dentro de una misma playlist.
select id_playlist, posicion, count(*) as canciones_en_esa_posicion
from cancion_playlist
group by id_playlist, posicion
having count(*) > 1;
