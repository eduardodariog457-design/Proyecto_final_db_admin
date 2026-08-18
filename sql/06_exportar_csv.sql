\set ON_ERROR_STOP on
SET search_path TO streaming;

\echo 'Exportando tabla artista...'
\copy artista TO 'exports/artista.csv' WITH (FORMAT csv, HEADER true)

\echo 'Exportación completada.'
