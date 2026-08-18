\set ON_ERROR_STOP on
\echo "Creando Tablas",
\ir 01_creacion.sql 
\echo "Insertando Datos"
\ir 02_datos.sql
\echo "Creando Usuarios"
\ir 03_usuarios_permisos.sql



