\set ON_ERROR_STOP on
\echo 'Exportando tabla artista...'
\copy artista to 'exports/artista.csv' with (FORMAT csv, HEADER true)
\echo 'Exportación completada.'
