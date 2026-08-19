\set on_error_stop on
set search_path to streaming;

-- Muestra las conexiones actuales y las consultas que están ejecutándose.
select
    pid,
    usename        as usuario,
    datname        as base_datos,
    client_addr    as direccion_cliente,
    state          as estado,
    query_start    as inicio_consulta,
    now() - query_start as duracion,
    left(query, 60) as consulta_actual
from pg_stat_activity
where datname = current_database()
order by query_start;


-- Cuenta cuántas conexiones hay en cada estado.
select
    state       as estado,
    count(*)    as cantidad
from pg_stat_activity
where datname = current_database()
group by state
order by cantidad desc;


-- Muestra el tamaño total de la base de datos actual.
select
    current_database()                              as base_datos,
    pg_size_pretty(pg_database_size(current_database())) as tamano;


-- Muestra el espacio ocupado por cada tabla, sus datos e índices.
select
    relname                                      as tabla,
    pg_size_pretty(pg_total_relation_size(relid)) as tamano_total,
    pg_size_pretty(pg_relation_size(relid))       as tamano_datos,
    pg_size_pretty(pg_indexes_size(relid))        as tamano_indices
from pg_catalog.pg_statio_user_tables
where schemaname = 'streaming'
order by pg_total_relation_size(relid) desc;


-- Muestra las consultas activas que no están en estado idle.
select
    pid,
    now() - query_start as duracion,
    state               as estado,
    left(query, 80)     as consulta
from pg_stat_activity
where datname = current_database()
  and state != 'idle';
