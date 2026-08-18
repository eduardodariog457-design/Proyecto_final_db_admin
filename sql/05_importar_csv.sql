\set ON_ERROR_STOP on
\echo 'Importando artistas desde CSV...'
\copy artista from 'data/artista_export_ejemplo.csv' with (FORMAT csv, HEADER true)
\echo 'Importando nuevos géneros desde CSV...'
\copy genero from 'data/nuevos_generos.csv' with (FORMAT csv, HEADER true)
\set ON_ERROR_STOP on
\echo 'Importación completada.'
