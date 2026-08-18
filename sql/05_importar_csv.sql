\set ON_ERROR_STOP on
SET search_path TO streaming;

\echo 'Importando artistas desde CSV...'
\copy artista FROM 'data/artista_export_ejemplo.csv' WITH (FORMAT csv, HEADER true)

\echo 'Importando nuevos géneros desde CSV...'
\copy genero(nombre, descripcion) FROM 'data/nuevos_generos.csv' WITH (FORMAT csv, HEADER true)

\echo 'Importación completada.'

