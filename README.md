[README (1).md](https://github.com/user-attachments/files/31204638/README.1.md)
Proyecto_Final_db

Materia: Administración de Bases de Datos

Universidad Tecnológica de Durango

## 1. Integrantes

- Gonzalez Alcantar Eduardo Darío – usuario GitHub: `eduardodariog457-diseño`
-Avalos Tinoco Jordan Jonathan – usuario GitHub: `jordanavalos09092004`

## 2. Descripción del caso

El proyecto administra la base de datos de una **plataforma de música**, donde se organizan artistas, canciones, géneros musicales y listas de reproducción (playlists). El objetivo es practicar tareas reales de administración de PostgreSQL (creación, usuarios, respaldo, importación/exportación, automatización, monitoreo y calidad de datos) sobre un caso pequeño pero relacional.

Entidades principales:

- **Género**: catálogo de géneros musicales.
- **Artista**: artistas o bandas, cada uno asociado a un género.
- **Canción**: canciones, cada una con su artista y género.
- **Playlist**: listas de reproducción creadas por los usuarios.
- **Canción_Playlist**: tabla intermedia que resuelve la relación N-N entre canciones y playlists (incluye posición y fecha en que se agregó la canción).



## 3. Requisitos para ejecutar el proyecto

- PostgreSQL 14 o superior instalado localmente.
- Cliente `psql` o una herramienta como pgAdmin/DBeaver.
- Python 3.10+ (solo para el script de automatización `respaldo_mantenimiento.py`).
- No se requiere Docker, servidores externos ni instalación de MongoDB (solo se investigó a nivel teórico).

## 4. Orden de ejecución de los scripts SQL

Todos los scripts están en la carpeta `SQL/` y deben ejecutarse en este orden:

| # | Script | Qué hace |
|---|--------|----------|
| 1 | `00_crear_esquema.sql` | Crea la base/esquema de trabajo. |
| 2 | `01_creación.sql` | Crea las tablas, llaves primarias, foráneas, restricciones de integridad e índices básicos. |
| 3 | `02_datos.sql` | Inserta los datos de prueba (mínimo 30 registros distribuidos en las tablas). |
| 4 | `03_usuarios_permisos.sql` | Crea el usuario de consulta y el usuario de captura, y asigna únicamente los permisos necesarios a cada uno. |
| 5 | `04_consultas.sql` | Contiene las consultas útiles del caso, incluyendo al menos una con `JOIN`. |
| 6 | `05_importar_csv.sql` | Importa datos desde un archivo CSV de ejemplo (carpeta `datos/`). |
| 7 | `06_exportar_csv.sql` | Exporta una tabla (artista) a CSV (carpeta `exportaciones/`). |
| 8 | `07_mantenimiento.sql` | Script de mantenimiento/respaldo ejecutado por la automatización en Python. |
| 9 | `08_monitoreo.sql` | Consultas de monitoreo: conexiones activas, tamaño de la base, actividad, y `EXPLAIN` sobre una consulta. |
| 10 | `09_calidad_datos.sql` | Detección de problemas de calidad (nulos, duplicados, formatos inválidos o relaciones incorrectas). |
| 11 | `10_calidad.sql` | Consulta de verificación tras la corrección de los problemas detectados. |

Ejecución sugerida vía `psql`:

```bash
psql -U postgres -d final_db -f SQL/00_crear_esquema.sql
psql -U postgres -d final_db -f SQL/01_creación.sql
psql -U postgres -d final_db -f SQL/02_datos.sql
psql -U postgres -d final_db -f SQL/03_usuarios_permisos.sql
psql -U postgres -d final_db -f SQL/04_consultas.sql
psql -U postgres -d final_db -f SQL/05_importar_csv.sql
psql -U postgres -d final_db -f SQL/06_exportar_csv.sql
psql -U postgres -d final_db -f SQL/08_monitoreo.sql
psql -U postgres -d final_db -f SQL/09_calidad_datos.sql
psql -U postgres -d final_db -f SQL/10_calidad.sql
```

## 5. Respaldo y restauración

- El respaldo se genera automáticamente desde `respaldo_mantenimiento.py`, que llama a `pg_dump` en formato personalizado (comprimido):
  ```bash
  pg_dump -U postgres -d final_db -F c -f copias_de_seguridad/respaldo_<FECHA>.dump
  ```
  El archivo se guarda con marca de fecha y hora (`YYYYmmdd_HHMMSS`) dentro de `copias_de_seguridad/`.
- Restauración en una base distinta:
  ```bash
  pg_restore -U postgres -d final_db_restaurada copias_de_seguridad/respaldo_<FECHA>.dump
  ```
  *(reemplaza `<FECHA>` por el nombre real del archivo generado; si aún no ejecutaron la restauración con este comando exacto, corran esta prueba y documenten el resultado abajo)*
- Resultado verificado: [completar: p. ej. "se restauró en `final_db_restaurada` y se comprobó que `SELECT COUNT(*) FROM artista;` devolvía el mismo número de filas que en `final_db`"].
- Todo el proceso queda registrado en `troncos/mantenimiento_<FECHA>.registro` (log generado por el propio script).

## 6. Importación y exportación

- **Exportación**: la tabla `artista` se exportó a CSV (`exportaciones/artista.csv`) usando `06_exportar_csv.sql`.
- **Importación**: se importó `datos/artista_export_ejemplo.csv` con nuevos artistas (ids 10–17) usando `05_importar_csv.sql`.
- Ambos archivos de ejemplo se conservan en el repositorio para reproducir el proceso.

## 7. Automatización

El script `respaldo_mantenimiento.py` automatiza el respaldo y mantenimiento en 3 pasos:

1. **Genera el respaldo comprimido** de `final_db` con `pg_dump` en `copias_de_seguridad/`.
2. **Ejecuta `SQL/07_mantenimiento.sql`** contra la base para correr la tarea de mantenimiento/reporte.
3. Registra cada paso (inicio, salida de cada comando, errores y fin del proceso) en un archivo de log dentro de `troncos/`, y detiene la ejecución si algún paso falla (`código de retorno != 0`).

No requiere configurar un servidor ni tareas programadas; se ejecuta manualmente con:
```bash
python respaldo_mantenimiento.py
```

El script `10_calidad.sql` funciona como un "orquestador" en `psql` que ejecuta en cadena, con `\ir`, los scripts `07_mantenimiento.sql`, `08_monitoreo.sql` y `09_calidad_datos.sql`, imprimiendo el avance (`1/3`, `2/3`, `3/3`) con `\eco`.

## 8. Usuarios, monitoreo y calidad

**Usuarios y permisos** (`03_usuarios_permisos.sql`):

Se crearon dos roles y dos usuarios, con privilegio mínimo aplicado según su función:

| Usuario | Rol | Permisos | Contraseña (ficticia) |
|---|---|---|---|
| `usr_consulta` | `consulta` | `USAGE` sobre el esquema y `SELECT` en todas las tablas | `consulta_123` |
| `usr_captura` | `captura` | `USAGE` sobre el esquema e `INSERT` en todas las tablas | `captura_123` |

También se configuraron **privilegios predeterminados** (`ALTER DEFAULT PRIVILEGES`) para que cualquier tabla nueva que se cree en el esquema herede automáticamente `SELECT` para `consulta` e `INSERT` para `captura`, sin tener que volver a otorgar permisos manualmente.

- Prueba de acceso: [completar cómo comprobaron que `usr_consulta` no puede insertar y que `usr_captura` no puede, por ejemplo, hacer `DELETE`].

**Monitoreo** (`08_monitoreo.sql`):
- Conexiones activas agrupadas por estado (`pg_stat_activity`).
- Tamaño total de la base de datos actual (`pg_database_size`).
- Espacio ocupado por cada tabla del esquema, separando datos e índices (`pg_total_relation_size`, `pg_relation_size`, `pg_indexes_size`).
- Consultas activas que no están en estado inactivo (`idle`), con su duración.
- `EXPLAIN`: no está incluido en `08_monitoreo.sql`.

**Calidad de datos** (`09_calidad_datos.sql`):

Se implementaron 7 verificaciones de calidad sobre el caso:

1. Artistas sin país de origen o sin fecha de debut registrados (valores nulos).
2. Géneros duplicados ignorando mayúsculas/minúsculas y espacios.
3. Canciones repetidas (mismo título y mismo artista).
4. Canciones con duración fuera de rango permitido (menos de 30 s o más de 1800 s).
5. Artistas con fecha de debut posterior a la fecha actual (dato inconsistente).
6. Canciones cuyo género no coincide con el género asignado a su artista (consulta con múltiples `JOIN`).
7. Posiciones repetidas dentro de una misma playlist.

Problemas realmente encontrados en los datos de prueba: [completar, ej. "se detectaron 2 géneros duplicados por diferencias de mayúsculas y 1 canción con duración de 15 s"].

`10_calidad.sql` sirve como script de verificación posterior: ejecuta en cadena el mantenimiento, el monitoreo y la calidad de datos para confirmar que todo corre sin errores tras las correcciones.

## 9. Sección teórica de MongoDB

Ver [`teoria_mongodb/fundamentos.md`](./teoria_mongodb/fundamentos.md).

## 10. Conclusiones y fuentes

Este proyecto nos permitió poner en práctica las tareas principales de administración de una base de datos PostgreSQL sobre un caso real y pequeño desde el diseño de tablas relacionadas con llaves primarias y foráneas, hasta la gestión de usuarios con privilegios diferenciados, el respaldo y restauración de la base, la importación/exportación de datos, la automatización de tareas de mantenimiento y la revisión de calidad de los datos.

**Fuentes consultadas:**
- Documentación oficial de PostgreSQL: https://www.postgresql.org/docs/


