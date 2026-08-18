\set on_error_stop on
set search_path to streaming;

\echo '=== mantenimiento de base de datos: streaming ==='

\echo '1/3 ejecutando vacuum analyze en todas las tablas del esquema...'
vacuum analyze streaming.genero;
vacuum analyze streaming.artista;
vacuum analyze streaming.cancion;
vacuum analyze streaming.playlist;
vacuum analyze streaming.cancion_playlist;

\echo '2/3 generando reporte de conteo de filas por tabla...'
select 'genero'            as tabla, count(*) as filas from streaming.genero
union all
select 'artista',           count(*) from streaming.artista
union all
select 'cancion',           count(*) from streaming.cancion
union all
select 'playlist',          count(*) from streaming.playlist
union all
select 'cancion_playlist',  count(*) from streaming.cancion_playlist;

\echo '3/3 verificando tamaño de la base de datos y del esquema...'
select pg_size_pretty(pg_database_size(current_database())) as tamano_base_datos;

select
    relname as tabla,
    pg_size_pretty(pg_total_relation_size(relid)) as tamano_total
from pg_catalog.pg_statio_user_tables
where schemaname = 'streaming'
order by pg_total_relation_size(relid) desc;

