
create schema if not exists streaming;
set search_path to streaming;

create table genero (
    id_genero   serial       primary key,
    nombre      varchar(60)  not null unique,
    descripcion text
);

create table artista (
    id_artista       serial       primary key,
    nombre_artistico varchar(120) not null,
    pais_origen      varchar(80),
    fecha_debut      date,
    id_genero        int          not null
        constraint fk_artista_genero references genero(id_genero)
);

create table cancion (
    id_cancion   serial       primary key,
    titulo       varchar(200) not null,
    duracion_seg smallint     not null
        constraint chk_duracion check (duracion_seg > 0),
    id_artista   int          not null
        constraint fk_cancion_artista references artista(id_artista),
    id_genero    int          not null
        constraint fk_cancion_genero  references genero(id_genero)
);

create table playlist (
    id_playlist    serial       primary key,
    nombre         varchar(150) not null,
    es_publica     boolean      not null default true,
    fecha_creacion timestamptz  not null default now()
);


create table cancion_playlist (
    id_cancion     int          not null
        constraint fk_cp_cancion  references cancion(id_cancion),
    id_playlist    int          not null
        constraint fk_cp_playlist references playlist(id_playlist),
    posicion       smallint     not null default 1
        constraint chk_posicion check (posicion >= 1),
    fecha_agregada timestamptz  not null default now(),
    constraint pk_cancion_playlist primary key (id_cancion, id_playlist)

create index idx_artista_genero  on artista(id_genero);
create index idx_cancion_artista on cancion(id_artista);
create index idx_cancion_genero  on cancion(id_genero);
create index idx_cp_playlist     on cancion_playlist(id_playlist);



