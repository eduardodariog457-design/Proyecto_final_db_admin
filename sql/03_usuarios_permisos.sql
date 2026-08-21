create role consulta;
create role captura;

grant usage on schema streaming to consulta;
grant usage on schema streaming to captura;

grant usage on all sequences in schema streaming to captura;

grant select on all tables in schema streaming to consulta;
grant insert on all tables in schema streaming to captura;

alter default privileges in schema streaming
    grant select on tables to consulta;
alter default privileges in schema streaming
    grant insert on tables to captura;

alter default privileges in schema streaming
    grant usage on sequences to captura;

create user usr_consulta with password 'consulta_123';
create user usr_captura  with password 'captura_123';

grant consulta to usr_consulta;
grant captura  to usr_captura;

