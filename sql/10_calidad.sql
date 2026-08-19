\set ON_ERROR_STOP on
\echo '1/3 Ejecutando mantenimiento...'
\ir 07_mantenimiento.sql
\echo '2/3 Ejecutando monitoreo...'
\ir 08_monitoreo.sql
\echo '3/3 Ejecutando calidad de datos...'
\ir 09_calidad_datos.sql

